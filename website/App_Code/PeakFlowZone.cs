using System;
using System.Collections.Generic;
using System.Web;
using System.Xml.XPath;
using System.Xml;

using Microsoft.Health;
using Microsoft.Health.ItemTypes;

public class PeakFlowZone// : HealthRecordItem
{
    //private double m_redOrangeBoundary;
    //private double m_orangeYellowBoundary;
    //private double m_yellowGreenBoundary;
    //private HealthServiceDateTime m_when;

    //public PeakFlowZone()
    //    : base(new Guid("a5033c9d-08cf-4204-9bd3-cb412ce39fc0"))
    //{
    //}

    //public PeakFlowZone(double oyb, double rob, double ygb, HealthServiceDateTime when)
    //    : base(new Guid("a5033c9d-08cf-4204-9bd3-cb412ce39fc0"))
    //{
    //    m_orangeYellowBoundary = oyb;
    //    m_redOrangeBoundary = rob;
    //    m_yellowGreenBoundary = ygb;
    //    m_when = when;
    //}

    //public double RedOrangeBoundary
    //{
    //    get { return m_redOrangeBoundary; }
    //}


    //protected override void ParseXml(
    //IXPathNavigable typeSpecificXml)
    //{
    //    XPathNavigator navigator =
    //        typeSpecificXml.CreateNavigator();
    //    navigator = navigator.SelectSingleNode("app-specific");
    //    XPathNavigator when = navigator.SelectSingleNode("when");
    //    m_when = new HealthServiceDateTime();

    //    m_when.ParseXml(when);

    //    XPathNavigator formatAppid = navigator.SelectSingleNode(
    //        "format-appid");
    //    string appid = formatAppid.Value;

    //    XPathNavigator peakZone = navigator.SelectSingleNode(
    //        "PeakZone");
    //    peakZone.MoveToFirstAttribute();

    //    for (; ; )
    //    {
    //        switch (peakZone.LocalName)
    //        {
    //            case "RedOrangeBoundary":
    //                m_redOrangeBoundary = peakZone.ValueAsDouble;
    //                break;

    //            case "OrangeYellowBoundary":
    //                m_orangeYellowBoundary = peakZone.ValueAsDouble;
    //                break;

    //            case "YellowGreenBoundary":
    //                m_yellowGreenBoundary = peakZone.ValueAsDouble;
    //                break;
    //        }

    //        if (!peakZone.MoveToNextAttribute())
    //        {
    //            break;
    //        }
    //    }
    //}

    //public override void WriteXml(XmlWriter writer)
    //{
    //    writer.WriteStartElement("app-specific");
    //    {
    //        writer.WriteStartElement("format-appid");
    //        writer.WriteValue("MyAppName");
    //        writer.WriteEndElement();
    //        writer.WriteStartElement("format-tag");
    //        writer.WriteValue("PeakZone");
    //        writer.WriteEndElement();
    //        m_when.WriteXml("when", writer);
    //        writer.WriteStartElement("summary");
    //        writer.WriteValue("");
    //        writer.WriteEndElement();
    //        writer.WriteStartElement("PeakZone");
    //        writer.WriteAttributeString("RedOrangeBoundary",
    //            m_redOrangeBoundary.ToString());
    //        writer.WriteAttributeString("OrangeYellowBoundary",
    //            m_orangeYellowBoundary.ToString());
    //        writer.WriteAttributeString("YellowGreenBoundary",
    //            m_yellowGreenBoundary.ToString());
    //        writer.WriteEndElement();
    //    }

    //    writer.WriteEndElement();
    //}

}