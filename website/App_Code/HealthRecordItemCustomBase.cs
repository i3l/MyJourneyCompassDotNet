using System;
using System.Collections.Generic;
using System.Web;
using System.Xml.XPath;
using System.Xml;

//public class HealthRecordItemCustomBase
//{
//    protected CustomHealthTypeWrapper m_wrapper;

//    public CustomHealthTypeWrapper Wrapper
//    {
//        get { return m_wrapper; }
//        set { m_wrapper = value; }
//    }

//    abstract public virtual void ParseXml(IXPathNavigable typeSpecificXml);
//    abstract public virtual void WriteXml(XmlWriter writer);
//}

public abstract class HealthRecordItemCustomBase
{
    protected CustomHealthTypeWrapper m_wrapper;

    public CustomHealthTypeWrapper Wrapper
    {
        get { return m_wrapper; }
        set { m_wrapper = value; }
    }

    public abstract void ParseXml(IXPathNavigable typeSpecificXml);
    public abstract void WriteXml(XmlWriter writer);
}
