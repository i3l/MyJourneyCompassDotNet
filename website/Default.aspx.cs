using System;
using System.Data;
using System.Configuration;
using System.Collections.ObjectModel;
using System.Collections.Generic;

using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using Microsoft.Health;
using Microsoft.Health.Web;
using Microsoft.Health.ItemTypes;


public partial class _Default : HealthServicePage
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
        }
        try
        {
            // ApplicationInfo info = ApplicationConnection.GetApplicationInfo();
            // AppName.Text += info.Name;

            c_UserName.Text = PersonInfo.Name;
            StartupData.SetActiveView(StartupData.Views[0]);
        }
        catch (HealthServiceException ex)
        {
            Error.Text += ex.ToString();
            StartupData.SetActiveView(StartupData.Views[1]);
        }
    }

    //protected void addSymptoms(object sender, EventArgs e)
    //{
    //    Response.Redirect("SymptomInput.aspx");
    //}

    //protected void viewSymptomSummary(object sender, EventArgs e)
    protected void SignOut(object sender, EventArgs e)
    {
        WebApplicationUtilities.SignOut (HttpContext.Current);
    }

    protected void addSymptoms(object sender, EventArgs e)
    {
        String[] symptomValues = new String[] { c_pain.Text, c_nausea.Text, c_sleep.Text, c_fatigue.Text, c_constipation.Text };

        for (int i = 0; i < 5; i++)
        {
            Condition condition = new Condition();
            CodableValue symptomName = new CodableValue(Symptom.symptomNames[i]);
            condition.Name = symptomName;
            ApproximateDateTime now = new ApproximateDateTime(DateTime.Now);
            condition.OnsetDate = now;
            CodableValue symptomValue = new CodableValue(symptomValues[i]);
            condition.Status = symptomValue;
            PersonInfo.SelectedRecord.NewItem(condition);
        }
    }

    protected void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();

        if (ex is HealthServiceCredentialTokenExpiredException)
        {
            WebApplicationUtilities.RedirectToLogOn(HttpContext.Current);
        }

        // ShowError(ex);
        throw ex;
    }

}
