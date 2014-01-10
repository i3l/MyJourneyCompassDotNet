<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>JourneyCompass</title>
    <link rel="icon" type="image/png" href="mjcicon.png" />
    <link rel="stylesheet" type="text/css" href="includes/theme.css" />
    <link rel="stylesheet" type="text/css" href="jquery/css/smoothness/jquery-ui-1.10.3.custom.min.css" />
    <script src="jquery/js/jquery-1.9.1.js"></script>
    <script src="jquery/js/jquery-ui-1.10.3.custom.min.js"></script>
    <script>
        $(function () {
            $("#pain_slider").slider({
                range: "min",
                value: 5,
                min: 0,
                max: 10,
                slide: function (event, ui) {
                    $("#c_pain").val(ui.value);
                }
            });
        });

        $(function () {
            $("#nausea_slider").slider({
                range: "min",
                value: 5,
                min: 0,
                max: 10,
                slide: function (event, ui) {
                    $("#c_nausea").val(ui.value);
                }
            });
        });

        $(function () {
            $("#fatigue_slider").slider({
                range: "min",
                value: 5,
                min: 0,
                max: 10,
                slide: function (event, ui) {
                    $("#c_fatigue").val(ui.value);
                }
            });
        });

        $(function () {
            $("#sleep_slider").slider({
                range: "min",
                value: 5,
                min: 0,
                max: 10,
                slide: function (event, ui) {
                    $("#c_sleep").val(ui.value);
                }
            });
        });

        $(function () {
            $("#constipation_slider").slider({
                range: "min",
                value: 5,
                min: 0,
                max: 10,
                slide: function (event, ui) {
                    $("#c_constipation").val(ui.value);
                }
            });
        });
    </script>
    <script type="text/javascript">
        $(function () {
            $("#c_pain").val(5);
            $("#c_nausea").val(5);
            $("#c_fatigue").val(5);
            $("#c_sleep").val(5);
            $("#c_constipation").val(5);
        });
    </script>
</head>
<body>
    <table width="100%" border="0" cellpadding="5">
        <tr>
            <td width="20" />
            <td>
                <img alt="title" src="images/JourneyCompass_1_medium.png" border="0" />

            </td>
        </tr>
    </table>
    <div style="background: #005C8A; width:100%; height: 27px; opacity: 0.3; filter: alpha(opacity=30); float:none;">
        <table width="100%" border="0" cellpadding="2">
            <tr>
                <td style="width: 30px" />
                <td style="text-align: left"><a href="SymptomSummary.aspx" target="_blank">REPORT</a> | <a id="A1" href="#" runat="server" onServerClick="SignOut">SIGN OUT</a></td>
            </tr>
        </table>
    </div>
    <div style="background: #6AB2BA; margin: 50px; border: 1px solid #198895;">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="text-align: left; height: 35px;">
                    <asp:MultiView ID="StartupData" runat="server">
                        <asp:View ID="ApplicationData" runat="server">
                            <table width="100%" border="0" cellpadding="5" cellspacing="5">
                                <tr>
                                    <td>Welcome <b>
                                        <asp:Label ID="c_UserName" runat="Server" /></b>,<br />
                                        <br />
                                        Please use the following slide bar to indicate stress level of your symptoms. 
                                        Note that <b>0 means the least stressful and 10 means the most stressful</b>. After choosing your level
                                        of symptoms, press Add symptoms button to submit.<br />
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="ErrorData" runat="server">
                            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="AppName" runat="server" Text="Application Name: " /><br />
                            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Error" runat="server" Text="Error was encountered when trying to retrieve application data: " />
                        </asp:View>
                    </asp:MultiView>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="line-separator" />
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellpadding="12" cellspacing="5">
                        <tr>
                            <td style="height: 500px; vertical-align: top;">
                                <!-- iframe style="border:none; width:100%; height:500px;" src="SymptomInput.aspx" scrolling="auto" / -->
                                <form id="form1" runat="server">
                                    Attention: This tracker should not be used to report emergencies. In case of extreme symptoms please contact 911.<br />
                                    <br />
                                    <div style="margin: 10px;">
                                        <table style="border: none; width: 100%; padding: 3px">
                                            <tr>
                                                <td style="text-align: right; width: 150px">Pain scale: </td>
                                                <td>
                                                    <asp:TextBox ID="c_pain" runat="server" Text="5" Style="width:15px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <div id="pain_slider"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Nausea scale: </td>
                                                <td>
                                                    <asp:TextBox ID="c_nausea" runat="server" Text="5" Style="width:15px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <div id="nausea_slider"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Fatigue scale: </td>
                                                <td>
                                                    <asp:TextBox ID="c_fatigue" runat="server" Text="5" Style="width:15px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <div id="fatigue_slider"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Constipation scale:</td>
                                                <td>
                                                    <asp:TextBox ID="c_constipation" runat="server" Text="5" Style="width:15px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <div id="constipation_slider"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right">Sleep scale: </td>
                                                <td>
                                                    <asp:TextBox ID="c_sleep" runat="server" Text="5" Style="width:15px" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <div id="sleep_slider"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Button ID="c_AddSymptoms" Text="Add Symptoms Entry" OnClick="addSymptoms" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </form>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
