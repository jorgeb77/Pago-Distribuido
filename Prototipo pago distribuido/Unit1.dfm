object Form1: TForm1
  Left = 0
  Top = 0
  ActiveControl = EdMontoPagar
  BorderIcons = [biSystemMenu]
  Caption = 'DISTRIBUCION DEL MONTO PAGADO'
  ClientHeight = 504
  ClientWidth = 1332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnShow = FormShow
  TextHeight = 15
  object Button1: TButton
    Left = 264
    Top = 200
    Width = 145
    Height = 57
    Caption = 'Pagar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object EdMontoPagar: TLabeledEdit
    Left = 200
    Top = 72
    Width = 209
    Height = 40
    EditLabel.Width = 170
    EditLabel.Height = 40
    EditLabel.Caption = 'Monto a pagar :'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -24
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    LabelPosition = lpLeft
    NumbersOnly = True
    ParentFont = False
    TabOrder = 1
    Text = ''
  end
  object ListBox1: TListBox
    Left = 432
    Top = 72
    Width = 362
    Height = 417
    ItemHeight = 15
    TabOrder = 2
  end
  object ListBox2: TListBox
    Left = 800
    Top = 72
    Width = 513
    Height = 417
    ItemHeight = 15
    TabOrder = 3
  end
end
