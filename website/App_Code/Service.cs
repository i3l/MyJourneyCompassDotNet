using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Text.RegularExpressions;
using System.Net.Mail;
using System.Net;
using System.Net.Security;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using iTextSharp.text.html.simpleparser;
using System.Net.Mime;
using iTextSharp.tool.xml;

namespace MyJCompass
{
    [ServiceContract(Namespace = "")]
    public interface Direct
    {
        [WebInvoke]
        string SendEmail(string to, string subject, string note, string charts, string provider, string patient_info, string patient);
    }

    public class DirectService : Direct
    {
        public string SendEmail(string to, string subject, string note, string charts, string provider, string patient_info, string patient)
        {
            
            string lpath = "PATH_HERE";

            // Add your operation implementation here
            string[] files = Regex.Split(charts, "!#!");

            if (to == "")
            {
                deleteChartFiles(lpath, files, null);
                return "The Symptom Report is removed";
            }

            // Generate PDF file.
            // First create a table of charts.
            string chart_tbl = "<table border=\"0\"><tr>";
            int i = 0;
            int count = 0;
            int tot_count = files.Length;
            foreach (string fn in files)
            {
                string img_path = "<td><img width=\"350\" src=\"" + lpath + fn + "\"/></td>";
                chart_tbl += img_path;
                i++;
                count++;
                if (i % 2 == 0)
                {
                    if (count == tot_count)
                    {
                        chart_tbl += "</tr>";
                    }
                    else
                    {
                        chart_tbl += "</tr><tr>";
                    }
                }
            }
            if (i % 2 == 1)
            {
                chart_tbl += "<td></td></tr></table>";
            }
            else
            {
                chart_tbl += "</table>";
            }

            string html = "<p align=\"center\"><b>MyJourney Compass Symptom Report</b></p><br/><p><b>Date</b>: " + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "</p><p>" + provider + "</p><p>" + patient_info + "</p><br/><p><b>Patient Note</b>: " + note + "</p><br/>" + chart_tbl;
            Document document = new Document(PageSize.LETTER, 30, 30, 30, 30);
            MemoryStream msOutput = new MemoryStream();
            TextReader reader = new StringReader(html);

            // PdfWriter pdfwriter = PdfWriter.GetInstance(document, msOutput);
            string unique_name = Guid.NewGuid().ToString() + ".pdf";
            string pdfn = lpath + unique_name;

            try
            {
                PdfWriter pdfwriter = PdfWriter.GetInstance(document, new FileStream(pdfn, FileMode.Create));
                //HTMLWorker worker = new HTMLWorker(document);
                document.Open();
                XMLWorkerHelper worker = XMLWorkerHelper.GetInstance();
                worker.ParseXHtml(pdfwriter, document, reader);
                //worker.Parse(reader);
                //worker.Close();
                document.Close();
                pdfwriter.Close();
            }
            catch (Exception e)
            {
                deleteChartFiles(lpath, files, null);
                return "Error on PDF Generation: " + e.Message;
            }

            // Send an Direct email.
            // string from = "MyJourneyCompass Symptom Tracker <rick.testgahie@gadirect.net>";
            string p_to;
            if (to.IndexOf("harbin", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                p_to = "**@**";
            }
            else if (to.IndexOf("gadirect", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                p_to = "**@**";
            }
            else if (to.IndexOf("i3l", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                p_to = "**@**";
            }
            else
            {
                deleteChartFiles(lpath, files, pdfn);
                return "Sorry. <b>" + to + "</b> is not a participating clinic.<br/>Please check the name and try again";
            }

            MailAddress m_from, m_to;
            string host;
            m_from = new MailAddress("**@**", "MyJourney Compass Symptom Tracker");
            m_to = new MailAddress(p_to);
            host = "smtp.gadirect.net";

            int port = 25;

            MailMessage message = new MailMessage(m_from, m_to);
            //MailMessage message = new MailMessage(from, p_to);

            message.Subject = subject;
            message.IsBodyHtml = true;
            message.Body = @"Dear <b>Harbin Clinic</b><br/><br/>This message contains a symptom report.<br/><br/>======== Below is a note from patient =========";
            if (note != null)
            {
                message.Body += "<pre>" + note + "</pre>";
            }

            try
            {
                //Attachment data = new Attachment(msOutput, "SymptomReport.pdf", "application/pdf");
                Attachment data = new Attachment(pdfn, MediaTypeNames.Application.Pdf);
                message.Attachments.Add(data);
                ContentDisposition disposition = data.ContentDisposition;
                disposition.FileName = patient.Replace(" ", "_") + "_" + DateTime.Now.ToString("MMddyyyyHHmmss") + ".pdf";

                ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(RemoteServerCertificateValidationCallback);
                SmtpClient client = new SmtpClient(host, port);

                client.Credentials = new System.Net.NetworkCredential("**@**", "***");
                client.EnableSsl = true;
                client.Send(message);

                data.Dispose();
                //msOutput.Close();
            }
            catch (Exception e)
            {
                deleteChartFiles(lpath, files, pdfn);
                return "Error on sending Direct Message: " + e.Message;
            }

            deleteChartFiles(lpath, files, pdfn);
            return "Direct Message Sent Out to <b>" + p_to + "</b>";
        }

        private void deleteChartFiles(string lpath, string[] files, string pdfn)
        {
            if (pdfn != null)
                System.IO.File.Delete(pdfn);

            foreach (string fn in files)
            {
                string fn_path = lpath + fn;
                System.IO.File.Delete(fn_path);
            }
        }

        private bool RemoteServerCertificateValidationCallback(object sender, System.Security.Cryptography.X509Certificates.X509Certificate certificate, System.Security.Cryptography.X509Certificates.X509Chain chain, SslPolicyErrors sslPolicyErrors)
        {
            return true;
            //throw new NotImplementedException();
        }

        // Add more operations here and mark them with [OperationContract]
    }
}