using System;
using System.Collections.Generic;
using System.Web;
using Microsoft.Health.Web;
using Microsoft.Health;
using Microsoft.Health.ItemTypes;
using System.Security.Cryptography.X509Certificates;
using Microsoft.Health.ApplicationProvisioning;

public class CreateChildApplication
{
    public static void CreateApplication()
    {
        // Create an offline connection, we use an empty Guid as personId
        // There is a bug to create a constructor without requiring a guid
        //// Use this only if you master application wants to do this in Offline mode
        OfflineWebApplicationConnection offlineConnection =
            new OfflineWebApplicationConnection(Guid.Empty);
        offlineConnection.Authenticate();

        // Setting up the application we want to create
        ApplicationInfo appInfo =
            new ApplicationInfo();
        appInfo.Name = "Android application";
        appInfo.AuthorizationReason =
            "Android aplication";
        appInfo.Description =
            "Just an android application";
        // get a base64 encoded logo
        appInfo.LargeLogo = new ApplicationBinaryConfiguration(
            "C:\\blah.png", "image/gif");
        // base64 encoded public key for this application
        appInfo.PublicKeys.Add(
            GetPublicKeyFromPfxOrP12("C:\\JourneyCompass.cer"));

        // You need to have PrivacyStatement + TermsOfUse or ActionUrl
        appInfo.PrivacyStatement = new ApplicationBinaryConfiguration(
        "C:\\privacy.txt", "text/plain");
        appInfo.TermsOfUse = new ApplicationBinaryConfiguration
            ("C:\\terms.txt", "text/plain");
        //actionUrl
        //appInfo.ActionUrl = new Uri("http://localhost/redirect.aspx");

        // Create and add the rules individually
        List<AuthorizationSetDefinition> rules = new List<AuthorizationSetDefinition>();
        rules.Add((AuthorizationSetDefinition)(new TypeIdSetDefinition(Height.TypeId)));
        rules.Add((AuthorizationSetDefinition)(new TypeIdSetDefinition(new Guid("a5033c9d-08cf-4204-9bd3-cb412ce39fc0"))));
        AuthorizationRule rule1 = new AuthorizationRule(
            HealthRecordItemPermissions.All,
            rules,
            null);
        // Here we are setting up the child as an offline application
        appInfo.OfflineBaseAuthorizations.Add(rule1);

        // Add more rules, if needed

        // Lets make the child app!
        Provisioner.AddApplication(offlineConnection, appInfo);
    }

    private static byte[] GetPublicKeyFromPfxOrP12(string fullPathToCerFile)
    {
        X509Certificate cert = new X509Certificate(fullPathToCerFile);
        return cert.GetRawCertData();
    }
}