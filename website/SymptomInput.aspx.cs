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



public partial class SymptomInput : HealthServicePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
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
}