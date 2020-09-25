Attribute VB_Name = "Module1"

' The function I use in Module1
' Have to first double click C:\Program Files (x86)\Microsoft Office\Office15\SELFCERT.EXE 
' to create a certificate and sign after each modification in ALT+F11

Sub MarkPrivateAndAcceptMeeting(objMeetingRequest As MeetingItem)
    If objMeetingRequest.MessageClass <> "IPM.Schedule.Meeting.Request" Then
        Exit Sub
    End If
    
    AutoMarkMeetingPrivate objMeetingRequest
    AutoAcceptMeetings objMeetingRequest
End Sub

' https://www.datanumen.com/blogs/2-quick-tips-auto-mark-specific-incoming-meetings-private-outlook/
' Requires EnableUnsafeClientMailRules in HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Outlook\Security
Sub AutoMarkMeetingPrivate(objMeetingRequest As MeetingItem)
    Dim objMeeting As Outlook.AppointmentItem
    If TypeOf objMeetingRequest Is MeetingItem Then
       Set objMeeting = objMeetingRequest.GetAssociatedAppointment(True)
       objMeeting.Sensitivity = olPrivate
       objMeeting.Save
    End If
End Sub

' http://www.slipstick.com/outlook/calendar/autoaccept-a-meeting-request-using-rules/
Sub AutoAcceptMeetings(oRequest As MeetingItem)
If oRequest.MessageClass <> "IPM.Schedule.Meeting.Request" Then
  Exit Sub
End If

Dim oAppt As AppointmentItem
Set oAppt = oRequest.GetAssociatedAppointment(True)

Dim oResponse
 Set oResponse = oAppt.Respond(olMeetingAccepted, True)
 oResponse.Send ' Either .Send or .Display
End Sub
