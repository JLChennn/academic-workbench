' Academic Workbench silent autostart (startup folder) - server only, no browser
Set ws = CreateObject("WScript.Shell")
ws.CurrentDirectory = "C:\Users\CJL\Desktop\workspace\academic-workbench"

Function PortOpen()
    PortOpen = False
    On Error Resume Next
    Dim http
    Set http = CreateObject("WinHttp.WinHttpRequest.5.1")
    http.SetTimeouts 1500, 1500, 1500, 1500
    http.Open "GET", "http://127.0.0.1:8765/api/pdf/health", False
    http.Send
    If http.Status = 200 Then PortOpen = True
    On Error GoTo 0
End Function

If Not PortOpen() Then
    ws.Run """C:\Users\CJL\Desktop\workspace\academic-workbench\pdf_worker\.venv\Scripts\python.exe"" ""C:\Users\CJL\Desktop\workspace\academic-workbench\server.py""", 0, False
End If
