using System;
using System.Collections.Generic;
using System.Web;


public class Symptom
{
    public static String[] symptomNames = new String[] { "Pain", "Nausea", "Sleep", "Fatigue", "Constipation" };
    DateTime when;
    String symptomName;
    int symptomValue;

    public Symptom()
    {
        this.when = DateTime.Now;
    }

    public Symptom(String symptomName, int symptomValue):this()
    {
        this.symptomName = symptomName;
        this.symptomValue = symptomValue;
    }

    public String SymptomName
    {
        get { return symptomName; }
        set { symptomName = value; }
    }

    public int SymptomValue
    {
        get { return symptomValue; }
        set { symptomValue = value; }
    }

    public DateTime When
    {
        get { return when; }
        set { when = value; }
    }
}