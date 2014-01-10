<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SymptomInput.aspx.cs" Inherits="SymptomInput" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="includes/plain_theme.css" />
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
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
</head>

<body>
    <form id="form1" runat="server">
        Attention: This tracker should not be used to report emergencies. In case of extreme symptoms please contact 911.<br />
        <br />
        <div style="margin: 10px;">
            <table style="border:none; width:100%; padding:3px">
                <tr>
                    <td style="text-align:right; width:150px">Pain scale: </td>
                    <td>
                        <asp:TextBox ID="c_pain" runat="server" Text="5" Width="7" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div id="pain_slider"></div>
                    </td>
                </tr>
                <tr><td colspan="2"> &nbsp;</td></tr>
                <tr>
                    <td style="text-align: right">Nausea scale: </td>
                    <td>
                        <asp:TextBox ID="c_nausea" runat="server" Text="5" Width="7" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div id="nausea_slider"></div>
                    </td>
                </tr>
                <tr><td colspan="2"> &nbsp;</td></tr>
                <tr>
                    <td style="text-align: right">Fatigue scale: </td>
                    <td>
                        <asp:TextBox ID="c_fatigue" runat="server" Text="5" Width="7" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div id="fatigue_slider"></div>
                    </td>
                </tr>
                <tr><td colspan="2"> &nbsp;</td></tr>
                <tr>
                    <td style="text-align: right">Constipation scale:</td>
                    <td>
                        <asp:TextBox ID="c_constipation" runat="server" Text="5" Width="7" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div id="constipation_slider"></div>
                    </td>
                </tr>
                <tr><td colspan="2"> &nbsp;</td></tr>
                <tr>
                    <td style="text-align: right">Sleep scale: </td>
                    <td>
                        <asp:TextBox ID="c_sleep" runat="server" Text="5" Width="7" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div id="sleep_slider"></div>
                    </td>
                </tr>
                <tr><td colspan="2"> &nbsp;</td></tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="c_AddSymptoms" Text="Add Symptoms Entry" OnClick="addSymptoms" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
