Attribute VB_Name = "Module1"

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
