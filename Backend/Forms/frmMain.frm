VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form1"
   ClientHeight    =   8445
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   15135
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8445
   ScaleWidth      =   15135
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton btnAddSymbol 
      Caption         =   "+"
      Height          =   375
      Left            =   1440
      TabIndex        =   8
      Top             =   7200
      Width           =   375
   End
   Begin VB.TextBox txtSymbol 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   162
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   390
      Left            =   120
      TabIndex        =   7
      Text            =   "USDTRY"
      Top             =   7200
      Width           =   1335
   End
   Begin VB.ListBox listSymbol 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   162
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2490
      Left            =   120
      TabIndex        =   5
      Top             =   4680
      Width           =   1695
   End
   Begin VB.ListBox List1 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   162
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3570
      Left            =   120
      TabIndex        =   3
      Top             =   480
      Width           =   11895
   End
   Begin MSWinsockLib.Winsock ClientSocket 
      Index           =   0
      Left            =   13920
      Top             =   0
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.ListBox listClient 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   162
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3570
      ItemData        =   "frmMain.frx":0000
      Left            =   12120
      List            =   "frmMain.frx":0002
      TabIndex        =   0
      Top             =   480
      Width           =   2895
   End
   Begin VB.Label Label3 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Sembol Listesi"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   162
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   6
      Top             =   4320
      Width           =   1695
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   15000
      Y1              =   4200
      Y2              =   4200
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Ýþlem Kayýtlarý [ Logging ]"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   162
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   4
      Top             =   120
      Width           =   11895
   End
   Begin VB.Label Label1 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Client Sayýsý :"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   162
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   12120
      TabIndex        =   2
      Top             =   120
      Width           =   2175
   End
   Begin VB.Label lblClientCount 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   162
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   14400
      TabIndex        =   1
      Top             =   120
      Width           =   615
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim clientSocketCounter As Integer

Private Sub btnAddSymbol_Click()

Dim listSymbolCounter As Integer


    For listSymbolCounter = 0 To listSymbol.ListCount - 1
        If (InStr(CStr(listSymbol.List(listSymbolCounter)), CStr(txtSymbol.Text))) = 0 Then
            listSymbol.AddItem (txtSymbol.Text)
        End If
    Next


End Sub

Private Sub ClientSocket_Close(Index As Integer)

Dim listClientCounter As Integer

For listClientCounter = 0 To listClient.ListCount - 1
    If (InStr(CStr(listClient.List(listClientCounter)), CStr(ClientSocket(Index).RemoteHostIP))) <> 0 Then
        listClient.RemoveItem (listClientCounter)
    End If
Next

ClientSocket(Index).Close
Unload ClientSocket(Index)

clientSocketCounter = clientSocketCounter - 1

lblClientCount.Caption = clientSocketCounter
End Sub

Private Sub ClientSocket_ConnectionRequest(Index As Integer, ByVal requestID As Long)
    clientSocketCounter = clientSocketCounter + 1
    Load ClientSocket(clientSocketCounter)
    ClientSocket(clientSocketCounter).Accept (requestID)
    listClient.AddItem (clientSocketCounter & " - " & ClientSocket(clientSocketCounter).RemoteHostIP)
    lblClientCount.Caption = clientSocketCounter
End Sub

Private Sub ClientSocket_Error(Index As Integer, ByVal Number As Integer, Description As String, ByVal Scode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
On Error GoTo theErrorHandler

theErrorHandler:
Print Err.Description
End Sub

Private Sub Form_Load()
    ClientSocket(0).LocalPort = "1007"
    ClientSocket(0).Listen
End Sub

