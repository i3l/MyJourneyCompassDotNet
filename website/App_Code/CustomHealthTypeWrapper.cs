using System;
using System.Collections.Generic;
using System.Web;
using System.Xml.XPath;
using System.Xml;


using Microsoft.Health;
using Microsoft.Health.Web;
using Microsoft.Health.ItemTypes;

public class CustomHealthTypeWrapper : HealthRecordItem
{
    public const string ApplicationCustomTypeID =
    "a5033c9d-08cf-4204-9bd3-cb412ce39fc0";
    const string NullObjectTypeName = "NULLOBJECT";

    private HealthServiceDateTime m_when;
    private HealthRecordItemCustomBase
        m_wrappedObject = null;
    
    public static void RegisterCustomDataType()
    {
        ItemTypeManager.RegisterTypeHandler(
            new Guid(ApplicationCustomTypeID),
            typeof(CustomHealthTypeWrapper), true);

    }

    public CustomHealthTypeWrapper() : this(null) { }

    public CustomHealthTypeWrapper(
        HealthRecordItemCustomBase wrappedInstance) :
        base(new Guid(ApplicationCustomTypeID))
    {
        m_wrappedObject = wrappedInstance;

        // Test for null here because the deserialization code 
        // needs to create this object first...

        if (wrappedInstance != null)
        {
            wrappedInstance.Wrapper = this;
        }
        m_when = new HealthServiceDateTime();
    }

    public HealthRecordItemCustomBase WrappedObject
    {
        get { return m_wrappedObject; }
        set { m_wrappedObject = value; }
    }

    public override void WriteXml(XmlWriter writer)
    {
        if (writer == null)
        {
            throw new ArgumentNullException("null writer");
        }

        writer.WriteStartElement("app-specific");
        {
            writer.WriteStartElement("format-appid");
            writer.WriteValue("Custom");
            writer.WriteEndElement();

            string wrappedTypeName = NullObjectTypeName;

            if (m_wrappedObject != null)
            {
                Type type = m_wrappedObject.GetType();
                wrappedTypeName = type.FullName;
            }

            writer.WriteStartElement("format-tag");
            writer.WriteValue(wrappedTypeName);
            writer.WriteEndElement();

            m_when.WriteXml("when", writer);

            writer.WriteStartElement("summary");
            writer.WriteValue("");
            writer.WriteEndElement();

            if (m_wrappedObject != null)
            {
                writer.WriteStartElement("CustomType");
                m_wrappedObject.WriteXml(writer);
                writer.WriteEndElement();
            }
        }
        writer.WriteEndElement();
    }

    protected override void ParseXml(IXPathNavigable typeSpecificXml)
    {
        XPathNavigator navigator =
             typeSpecificXml.CreateNavigator();
        navigator = navigator.SelectSingleNode("app-specific");

        if (navigator == null)
        {
            throw new ArgumentNullException("null navigator");
        }

        XPathNavigator when = navigator.SelectSingleNode(
            "when");

        m_when = new HealthServiceDateTime();
        m_when.ParseXml(when);

        XPathNavigator formatAppid =
            navigator.SelectSingleNode("format-appid");
        string appid = formatAppid.Value;

        XPathNavigator formatTag =
            navigator.SelectSingleNode("format-tag");
        string wrappedTypeName = formatTag.Value;

        if (wrappedTypeName != NullObjectTypeName)
        {
            m_wrappedObject = (HealthRecordItemCustomBase)
                CreateObjectByName(wrappedTypeName);

            if (m_wrappedObject != null)
            {
                m_wrappedObject.Wrapper = this;
                XPathNavigator customType =
                    navigator.SelectSingleNode("CustomType");
                if (customType != null)
                {
                    m_wrappedObject.ParseXml(customType);
                }
            }
        }
    }

    public object CreateObjectByName(string typeName)
    {
        Type type = Type.GetType(typeName);
        object o = null;

        if (type != null)
        {
            if (type.BaseType != typeof(HealthRecordItemCustomBase))
            {
                throw new ApplicationException("Custom type not derived from HealthRecordItemCustomBase");
            }
            o = Activator.CreateInstance(type);
        }
        return o;
    }
}