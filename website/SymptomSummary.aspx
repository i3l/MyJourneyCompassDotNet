<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SymptomSummary.aspx.cs" Inherits="SymptomSummary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Symptom Summary</title>

    <link rel="stylesheet" type="text/css" href="jquery/css/smoothness/jquery-ui-1.10.3.custom.min.css" />
    <script src="jquery/js/jquery-1.9.1.js"></script>
    <script src="jquery/js/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="jquery/js/jquery.form.min.js"></script>

    <!--<script src="jquery/js/jQuery.XDomainRequest.js"></script>-->

    <link rel="stylesheet" type="text/css" href="includes/theme.css" />

    <script type="text/javascript" src="js/highcharts.src.js"></script>
    <script type="text/javascript" src="js/exporting.src.js"></script>

    <!-- <script type="text/javascript" src="js/draw_graph.js"></script> -->
    <asp:Literal ID="chartScript" runat="server" />
    <asp:Literal ID="collapse_chartScript" runat="server" />

    <script type="text/javascript">
        String.prototype.escapeSpecialChars = function (valueToEscape) {
            if (valueToEscape != null && valueToEscape != "") {
                return valueToEscape.replace(/\n/g, "\\n");
            } else {
                return valueToEscape;
            }
        };
    </script>

    <script type='text/javascript'>
        var formConfirm = null;
        $(function () {
            $.support.cors = true;
            $("#exportForm").ajaxForm({
                dataType: "json",
                beforeSubmit: function () {
                    if (formConfirm == null) {
                        $("#dialog-report").dialog({
                            open: function () { $(".ui-dialog-titlebar-close").hide(); },
                            resizable: false,
                            width: "auto",
                            height: "auto",
                            modal: true,
                            show: "clip",
                            dialogClass: 'dialog_general',
                            buttons: {
                                "Yes, Prepare...": function () {
                                    $(this).dialog("close");
                                    formConfirm = true;
                                    $("#exportForm").submit();
                                },
                                Cancel: function () {
                                    $(this).dialog("close");
                                    return false;
                                }
                            }
                        });
                        return false;
                    } else {
                        if (formConfirm != null)
                            formConfirm = null;
                        $("#dialog-preparereport").dialog({
                            open: function () { $(".ui-dialog-titlebar-close").hide(); },
                            width: "auto",
                            height: "auto",
                            modal: true,
                            dialogClass: 'dialog_general',
                            show: "blind"
                        });
                        return true;
                    }
                },
                success: function (data) {
                    $("#dialog-preparereport").dialog("close");
                    $("input[name='filenames']").val(data.filenames);
                    $("#dialog-sendreport").dialog({
                        closeOnEscape: false,
                        open: function () { $(".ui-dialog-titlebar-close").hide(); },
                        width: "auto",
                        height: "auto",
                        modal: true,
                        dialogClass: 'dialog_general',
                        show: "clip",
                        buttons: {
                            "Send Report": function () {
                                p_to = $("input[name='to']").val();
                                if (p_to == "" || p_to == "You must enter Clinic Name") {
                                    $("input[name='to']").val("You must enter Clinic Name");
                                    return false;
                                }
                                $(this).dialog("close");
                                $("#dialog-aftersend").html("<p><table border='0'><tr><td valign='top' width='38'><img src='images/icon_processing.gif' border='0' /></td><td valign='top'>Please wait until your mail is sent out<br/>This may take a while..</td></tr></table></p>");
                                $("#dialog-aftersend").dialog({
                                    open: function () { $(".ui-dialog-titlebar-close").show(); },
                                    width: "auto",
                                    height: "auto",
                                    modal: true,
                                    dialogClass: 'dialog_general',
                                    show: "clip"
                                });
                                p_info = $("input[name='patient_info']").val();
                                p_note = $("textarea[name='note']").val();
                                p_note = p_note.replace(/</g, '&lt;').replace(/>/g, '&gt;');
                                p_note = p_note.replace(/"/g, '\\"');
                                p_note = p_note.escapeSpecialChars(p_note);
                                p_provider = "<b>Provider</b>: " + $("#ProviderInfo").val();
                                p_files = $("input[name='filenames']").val();
                                p_subject = "Symptom Report for <%=user_name%>";
                                p_patient = "<%=user_name%>";
                                p_jsondata = '{ "to":"' + p_to + '", "subject":"' + p_subject + '", "patient_info": "' + p_info + '", "note": "' + p_note + '", "charts": "' + p_files + '", "provider": "'+p_provider+'", "patient": "' + p_patient + '" }';

                                // Make sure JSON data does not have any special characters in it.
                                // p_jsondata = p_jsondata.escapeSpecialChars(p_jsondata);

                                $.ajax({
                                    url: '/Service.svc/SendEmail',
                                    cache: false,
                                    type: 'POST',
                                    contentType: 'application/json; charset=utf-8',
                                    data: p_jsondata,
                                    success: function (data) {
                                        $("#dialog-aftersend").html("<p>" + data.d + "</p>" + "You can close this box now.");
                                    },
                                    error: function (xhr, textStatus, errorThrown) {
                                        $("#dialog-aftersend").html("in SendMail service error: " + textStatus + "<br/>" + errorThrown);
                                    }
                                });
                            },
                            Cancel: function () {
                                $(this).dialog("close");
                                $("#dialog-aftersend").html("<p><table border='0'><tr><td valign='top' width='38'><img src='images/icon_processing.gif' border='0' /></td><td valign='top'>Canceling the report<br/>Please wait..</td></tr></table></p>");
                                $("#dialog-aftersend").dialog({
                                    open: function () { $(".ui-dialog-titlebar-close").show(); },
                                    width: "auto",
                                    height: "auto",
                                    modal: true,
                                    dialogClass: 'dialog_general',
                                    show: "clip"
                                });
                                p_info = $("input[name='patient_info']").val();
                                p_note = "";
                                p_files = $("input[name='filenames']").val();
                                p_provider = "Provider: " + $("#ProviderInfo").val();
                                p_to = "";
                                p_subject = "Symptom Report for <%=user_name%>";
                                p_patient = "<%=user_name%>";
                                p_jsondata = '{ "to":"' + p_to + '", "subject":"' + p_subject + '", "patient_info": "' + p_info + '", "note": "' + p_note + '", "charts": "' + p_files + '", "provider": "' + p_provider + '", "patient": "' + p_patient + '" }';

                                $.ajax({
                                    url: '/Service.svc/SendEmail',
                                    cache: false,
                                    type: 'POST',
                                    contentType: 'application/json; charset=utf-8',
                                    data: p_jsondata,
                                    success: function (data) {
                                        $("#dialog-aftersend").html("<p>" + data.d + "</p>" + "You can close this box now.");
                                    },
                                    error: function (xhr, textStatus, errorThrown) {
                                        $("#dialog-aftersend").html("Error when canceling the report: " + textStatus + "<br/>" + errorThrown);
                                    }
                                });

                                return false;
                            }
                        }
                    });
                },
                error: function (xhr, textStatus, errorThrown) {
                    $("#dialog-preparereport").dialog("close");
                    alert("Chart Exposrt Server error: " + textStatus + " : "+errorThrown);
                }
            });
        });

    </script>

    <script type="text/javascript">
        $(function () {
            $('#charts_sel').button();
            $("label[for='charts_sel']").width(550);
            $('#refresh').button();
            $('#exportFormButton').button();
        });

        $(function () {
            $("#from_date").datepicker();
        });

        $(function () {
            $('#charts_sel').click(function () {
                if ($('#charts_sel').is(':checked')) {
                    $('#CollapseContainer').show();
                    $('#SeparateContainer').hide();
                } else {
                    $('#CollapseContainer').hide();
                    $('#SeparateContainer').show();
                }
            });
        });
    </script>

    <asp:Literal ID="initChartDisplay" runat="server" />
</head>
<body>
    <table width="100%" border="0" cellpadding="5">
        <tr>
            <td width="20" />
            <td>
                <img src="images/JourneyCompass_1_medium.png" border="0" /></td>
        </tr>
    </table>
    <div style="background: #005C8A; width: 1270px; height: 50px; opacity: 0.3; filter: alpha(opacity=30); padding: 2px 2px 2px 2px; overflow: auto">
        <table style="width: 1270px; border: 0; padding: 0;">
            <tr>
                <td style="text-align: center; font-size: xx-large">Symptom Summary</td>
            </tr>
        </table>
    </div>
    <br />
    <table style="border:none;margin:0px 0px 0px 0px;">
        <tr>
            <td>
                <div style="margin-left: 50px; margin-right: 50px;">
                    Name:
                    <asp:Label ID="patient_name" runat="Server" />
                    <br />
                    Birth Year:
                    <asp:Label ID="dob" runat="Server" />
                    <br />
                    City:
                    <asp:Label ID="city" runat="Server" />
                    <br />
                    State:
                    <asp:Label ID="state" runat="Server" />
                    <br />
                </div>
            </td>
        </tr>
    </table>
    <table style="border:none;width:1170px">
        <tr>
            <td>
                <form id="form1" runat="server">
                    <div style="margin-left: 50px; margin-right: 0px;">
                        Please select the date range (Default is 2 weeks):
                        from <asp:TextBox ID="from_date" runat="server" />
                        until Today. (Press Refresh Graph Button after new date is selected.)
                        <br /><br />
                        <asp:Checkbox id="charts_sel" runat="server" Text="Collapse/Uncollapse Symptom Charts"/> <asp:Button ID="refresh" Text="Refresh Graph" runat="server" style="width:550px"/>
                    </div>
                </form>
            </td>
        </tr>
    </table>
    <table style="border:none;width:1170px">
        <tr>
            <td>
                <div style="margin-left: 50px; margin-right: 0px;">
                    <asp:Literal ID="exportForm" runat="server" />
                </div>
            </td>
        </tr>
    </table>
    <br />
    <%--<div id="container" style="min-width: 400px; height: 400px; margin: 0 auto"></div>--%>
    <div style="background: #6AB2BA; width: 1120px; margin-left: 50px; margin-right: 50px; margin-bottom: 50px; border: 1px solid #198895;">
        <div id="CollapseContainer" style="width:1100px; display: none; margin: 7px;"></div>
        <div id="SeparateContainer">
            <table border="0" width="100%" cellpadding="3" cellspacing="3">
                <tr>
                    <td>
                        <div id="Pain_graph" style="width: 550px; height: 400px; float: none"></div>
                    </td>
                    <td>
                        <div id="Fatigue_graph" style="width: 550px; height: 400px; float: none"></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="Nausea_graph" style="width: 550px; height: 400px; float: none"></div>
                    </td>
                    <td>
                        <div id="Sleep_graph" style="width: 550px; height: 400px; float: none"></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="Constipation_graph" style="width: 550px; height: 400px; float: none"></div>
                    </td>
                    <td></td>
                </tr>
            </table>
        </div>
    </div>
    <div id="dialog-report" title="Symptom Report Request" style="display: none;" >
        <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>This will prepare a report for your physician. <br />Do you want to start preparing a report?</p>
    </div>
    
    <div id="dialog-preparereport" title="Prepare Report" style="display: none;" >
        <p><table border='0'><tr><td valign='top' width='38'><img src='images/icon_processing.gif' border='0' /></td><td valign='top'>Processing ... <br />Please wait until your report is generated.</td></tr></table></p>
    </div>

    <div id="dialog-sendreport" title="Send Report" style="display:none;" >
        <table border="0">
            <tr>
                <td style="float:right"><b>Clinic Name:</b></td>
                <td>
                    <input type="text" name="to" size="50" value=""/>
                </td>
            </tr>
            <tr>
                <td style="float:right"><b>Select Provider:</b></td>
                <td>
                    <%=ProviderInfoMenu%>
                </td>
            </tr>
            <tr>
                <td style="float:right"><b>Subject:</b></td><td>Patient Symptom Report for <%=user_name%></td>
            </tr>
            <tr>
                <td align="top" style="float:right;"><b>Note:</b></td>
                <td><textarea name="note" rows="5" cols="50"></textarea></td>
            </tr>
        </table>
        <input type="hidden" name="patient_info" value="<%=user_info%>"/>
        <input type="hidden" name="filenames" value=""/><br/>
    </div>

    <div id="dialog-aftersend" title="Send Report" style="display:none;" ></div>

</body>
</html>
