object Form1: TForm1
  Left = 0
  Top = 0
  ActiveControl = EdEfectivo
  BorderIcons = [biSystemMenu]
  Caption = 'DISTRIBUCION DE PAGOS'
  ClientHeight = 890
  ClientWidth = 1426
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  StyleName = 'Windows'
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 168
  TextHeight = 30
  object Label6: TLabel
    Left = 138
    Top = 842
    Width = 197
    Height = 34
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Saldo restante :'
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -28
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object LbDiferencia: TLabel
    Left = 341
    Top = 842
    Width = 53
    Height = 34
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = '0.00'
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -28
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 4
    Top = 12
    Width = 134
    Height = 34
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Concepto :'
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -28
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 44
    Top = 57
    Width = 96
    Height = 34
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Monto :'
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -28
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object PnTotalPendiente: TPanel
    Left = 667
    Top = 844
    Width = 203
    Height = 40
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Alignment = taRightJustify
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = '0.00'
    Color = 9588257
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -28
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
  end
  object PnTotalAplicado: TPanel
    Left = 879
    Top = 844
    Width = 199
    Height = 40
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Alignment = taRightJustify
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = '0.00'
    Color = 9588257
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -28
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 5
  end
  object EdConcepto: TEdit
    Left = 158
    Top = 14
    Width = 1264
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabStop = False
    AutoSize = False
    Color = 11599871
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object EdMonto: TEdit
    Left = 158
    Top = 59
    Width = 211
    Height = 39
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabStop = False
    AutoSize = False
    Color = 11599871
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    OnChange = EdMontoChange
  end
  object DBGrid1: TDBGrid
    Left = 5
    Top = 334
    Width = 1412
    Height = 500
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    DataSource = DsDocumentos
    DrawingStyle = gdsGradient
    FixedColor = clWindow
    GradientEndColor = 9588257
    GradientStartColor = 9588257
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -21
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnKeyPress = DBGrid1KeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'Documento'
        ReadOnly = True
        Title.Color = 9588257
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -28
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NroDocumento'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Color = 9588257
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -28
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Width = 196
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fecha'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Color = 9588257
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -28
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pendiente'
        ReadOnly = True
        Title.Color = 9588257
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -28
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Saldo'
        ReadOnly = True
        Title.Color = 9588257
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -28
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MontoAplicado'
        Title.Color = 9588257
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -28
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Width = 210
        Visible = True
      end>
  end
  object PnFormaPago: TPanel
    Left = 5
    Top = 112
    Width = 1412
    Height = 210
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    BevelOuter = bvNone
    Color = 16773093
    ParentBackground = False
    TabOrder = 2
    object Label3: TLabel
      Left = 42
      Top = 57
      Width = 116
      Height = 34
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Efectivo :'
      Color = clWindow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -28
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 46
      Top = 107
      Width = 113
      Height = 34
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Cheque :'
      Color = clWindow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -28
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label5: TLabel
      Left = 51
      Top = 157
      Width = 107
      Height = 34
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Tarjeta :'
      Color = clWindow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -28
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 1412
      Height = 43
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Alignment = taLeftJustify
      Caption = 'Forma de Pago'
      Color = 16769485
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -28
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object EdEfectivo: TEdit
      Left = 175
      Top = 53
      Width = 275
      Height = 42
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 1
      OnChange = EdEfectivoChange
    end
    object EdCheque: TEdit
      Left = 175
      Top = 103
      Width = 275
      Height = 42
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 2
      OnChange = EdChequeChange
    end
    object EdTarjeta: TEdit
      Left = 175
      Top = 153
      Width = 275
      Height = 42
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 3
      OnChange = EdTarjetaChange
    end
    object BtDistribuirPago: TButton
      Left = 952
      Top = 96
      Width = 350
      Height = 70
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Distribuir Pago'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Visible = False
      OnClick = BtDistribuirPagoClick
    end
  end
  object DsDocumentos: TDataSource
    DataSet = MtDocumentos
    Left = 504
    Top = 550
  end
  object MtDocumentos: TFDMemTable
    BeforePost = MtDocumentosBeforePost
    FieldDefs = <
      item
        Name = 'Documento'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'NroDocumento'
        DataType = ftInteger
      end
      item
        Name = 'Fecha'
        DataType = ftDateTime
      end
      item
        Name = 'Pendiente'
        DataType = ftCurrency
        Precision = 2
      end
      item
        Name = 'Saldo'
        DataType = ftCurrency
        Precision = 2
      end
      item
        Name = 'MontoAplicado'
        DataType = ftCurrency
        Precision = 2
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 1073741823
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 508
    Top = 448
    object MtDocumentosDocumento: TStringField
      FieldName = 'Documento'
      Size = 15
    end
    object MtDocumentosNroDocumento: TIntegerField
      Alignment = taCenter
      FieldName = 'NroDocumento'
    end
    object MtDocumentosFecha: TDateTimeField
      Alignment = taCenter
      FieldName = 'Fecha'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object MtDocumentosPendiente: TCurrencyField
      FieldName = 'Pendiente'
      DisplayFormat = '###,###,##0.00'
      currency = False
    end
    object MtDocumentosSaldo: TCurrencyField
      FieldName = 'Saldo'
      DisplayFormat = '###,###,##0.00'
      currency = False
    end
    object MtDocumentosMontoAplicado: TCurrencyField
      FieldName = 'MontoAplicado'
      DisplayFormat = '###,###,##0.00'
      currency = False
    end
  end
end
