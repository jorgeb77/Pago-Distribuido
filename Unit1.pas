unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.UITypes, Vcl.ExtCtrls, Data.DB, Vcl.Menus, Vcl.StdCtrls,
  System.Math, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;


type
  TForm1 = class(TForm)
    DsDocumentos: TDataSource;
    Label6: TLabel;
    LbDiferencia: TLabel;
    PnTotalPendiente: TPanel;
    PnTotalAplicado: TPanel;
    Label1: TLabel;
    EdConcepto: TEdit;
    Label2: TLabel;
    EdMonto: TEdit;
    MtDocumentos: TFDMemTable;
    MtDocumentosDocumento: TStringField;
    MtDocumentosNroDocumento: TIntegerField;
    MtDocumentosFecha: TDateTimeField;
    MtDocumentosPendiente: TCurrencyField;
    MtDocumentosSaldo: TCurrencyField;
    MtDocumentosMontoAplicado: TCurrencyField;
    DBGrid1: TDBGrid;
    PnFormaPago: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    EdEfectivo: TEdit;
    EdCheque: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    EdTarjeta: TEdit;
    BtDistribuirPago: TButton;
    procedure FormShow(Sender: TObject);
    procedure BtDistribuirPagoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MtDocumentosBeforePost(DataSet: TDataSet);
    procedure EdMontoChange(Sender: TObject);
    procedure EdEfectivoChange(Sender: TObject);
    procedure EdChequeChange(Sender: TObject);
    procedure EdTarjetaChange(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    wDeudaCliente, TotalPagos : Double;
    CampoDelValor : Integer;
    PuedoCalcular : Boolean;
    MontoAnterior : Double;
    procedure ValidarMontoAplicado;
    procedure DistribuirPago(MontoTotal : Double);
    procedure RevertirDistribucion;
    function GenerarConcepto : string;
//    function TotalCampo(Dataset : TDataSet; Campo : string) : Double;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses DataGenerator;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PuedoCalcular := False;
end;

procedure TForm1.FormShow(Sender: TObject);
const
  Documentos : array[1..2] of string = ('FACTURA','NOTA DE DEBITO');

var
  I, Idx : Integer;
begin
  wDeudaCliente := 0;

  if PuedoCalcular = False then
    begin
      MtDocumentos.Open;
      MtDocumentos.BeginBatch;
      try
        Randomize;
        for I:= 1 to 10 do
          begin
            Idx := Random(2) + 1;  //Indice aleatorio para los documentos

            with MtDocumentos do
              begin
                Append;
                FieldByName('Documento').AsString     := Documentos[Idx];
                FieldByName('NroDocumento').AsInteger := RandomRange(150, 300);
                FieldByName('Fecha').AsDateTime       := TDataGenerator.GenerateRandomDate(EncodeDate(2022, 01, 01), EncodeDate(2024, 12, 31));
                FieldByName('Pendiente').AsFloat      := TDataGenerator.RandomRangeDecimal(1500, 3000);
                FieldByName('Saldo').AsFloat          := FieldByName('Pendiente').AsFloat;
                FieldByName('MontoAplicado').AsFloat  := 0;
                Post;
              end;

            wDeudaCliente := wDeudaCliente + MtDocumentos.FieldByName('Saldo').AsFloat;

          end;
      finally
        MtDocumentos.EndBatch;
      end;
    end;

  PuedoCalcular := True;
  PnTotalPendiente.Caption := FormatFloat('###,###,##0.00', wDeudaCliente);
  EdEfectivo.SetFocus;
  MtDocumentos.First;

end;

procedure TForm1.BtDistribuirPagoClick(Sender: TObject);
var
  Marcador : TBookmark;
  MontoRestante : Double;
begin
  MontoRestante := StrToFloat(EdMonto.Text);

  if MontoRestante = 0 then
    begin
      MessageDlg('Debe especificar el monto en la forma de pago.',
      TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);
      EdEfectivo.SetFocus;
      Abort;
    end;

  MtDocumentos.DisableControls;
  try
    Marcador := MtDocumentos.GetBookmark;
    MtDocumentos.First;
    while not MtDocumentos.Eof do
      begin
        if MontoRestante <= 0 then
          Break; // Si ya no queda dinero, salir del bucle.

        MtDocumentos.Edit;

        // Si el monto restante es mayor o igual al monto pendiente, se paga completamente
        if MontoRestante >= MtDocumentos.FieldByName('Saldo').AsFloat then
          begin
            MtDocumentos.FieldByName('MontoAplicado').AsFloat := MtDocumentos.FieldByName('Saldo').AsFloat;
            MontoRestante                                     := MontoRestante - MtDocumentos.FieldByName('Saldo').AsFloat;
            MtDocumentos.FieldByName('Saldo').AsFloat         := 0; // Factura pagada completamente
  //          Facturas[I].Estatus        := 'Pagada';
          end
        else // Si no, se paga solo lo que queda
          begin
            MtDocumentos.FieldByName('MontoAplicado').AsFloat := MontoRestante;
            MtDocumentos.FieldByName('Saldo').AsFloat         := MtDocumentos.FieldByName('Saldo').AsFloat - MontoRestante; // Actualizar monto pendiente
            MontoRestante                                     := 0; // Ya no queda dinero por distribuir
  //          Facturas[I].Estatus        := 'Pendiente';
          end;

        MtDocumentos.Post;

        MtDocumentos.Next;
      end;

  finally
    MtDocumentos.GotoBookmark(Marcador);
    MtDocumentos.FreeBookmark(Marcador);
    MtDocumentos.EnableControls;
  end;

  if (wDeudaCliente - StrToFloat(EdMonto.Text)) > 0 then
    LbDiferencia.Caption:= FormatFloat('###,##,##0.00', wDeudaCliente - StrToFloat(EdMonto.Text))
  else
    LbDiferencia.Caption:= '0.00';

end;

procedure TForm1.EdEfectivoChange(Sender: TObject);
begin
  CampoDelValor := 1;
  ValidarMontoAplicado;
end;

procedure TForm1.EdChequeChange(Sender: TObject);
begin
  CampoDelValor := 2;
  ValidarMontoAplicado;
end;

procedure TForm1.EdTarjetaChange(Sender: TObject);
begin
  CampoDelValor := 3;
  ValidarMontoAplicado;
end;

//AQUI SE DISTRIBUYE EL MONTO APLICADO A TODOS LOS DOCUMENTOS...
procedure TForm1.EdMontoChange(Sender: TObject);
var
  MontoIngresado : Double;
begin
  MontoIngresado := StrToFloat(EdMonto.Text);

  if MontoIngresado >= 0 then
    begin
      RevertirDistribucion;  // Primero revertimos cualquier distribución anterior
      DistribuirPago(MontoIngresado);  // Luego aplicamos la nueva distribución con el monto ingresado
      MontoAnterior   := MontoIngresado; // Guardamos el monto actual como el último monto válido ingresado
      EdConcepto.Text := GenerarConcepto;
    end
  else
    begin
      RevertirDistribucion;  // Si el monto no es válido, revertimos cualquier distribución anterior
      LbDiferencia.Caption := FormatFloat('###,##,##0.00', wDeudaCliente);
      MontoAnterior        := 0;  // Reseteamos el monto anterior a cero, ya que el valor actual no es válido
      EdConcepto.Text      := '';
    end;
end;

procedure TForm1.MtDocumentosBeforePost(DataSet: TDataSet);
begin
  if MtDocumentos.FieldByName('MontoAplicado').AsFloat > MtDocumentos.FieldByName('Pendiente').AsFloat then
    begin
      MessageDlg('El monto aplicado no puede ser mayor que el saldo!!!',
      TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);
      Abort;
    end;
end;

procedure TForm1.ValidarMontoAplicado;
begin
  TotalPagos := StrToFloatDef(EdEfectivo.Text, 0) + StrToFloatDef(EdCheque.Text, 0) + StrToFloatDef(EdTarjeta.Text, 0);

  if TotalPagos > wDeudaCliente then
    begin
      MessageDlg('El monto aplicado no puede ser mayor al balance !!!',
                 TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);

      if CampoDelValor = 1 then
        EdEfectivo.SetFocus
      else
        if CampoDelValor = 2 then
          EdCheque.SetFocus
        else
          if CampoDelValor = 3 then
            EdTarjeta.SetFocus;
      Abort;
    end;

  EdMonto.Text            := FloatToStr(TotalPagos);
  PnTotalAplicado.Caption := FormatFloat('###,###,##0.00', TotalPagos);
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  //COLOREAMOS LOS ROWS ESTILO CEBRA, CADA DOS LINEAS
  if (Sender as TDBGrid).Datasource.Dataset.RecNo mod 2 = 0 then
    (Sender as TDBGrid).Canvas.Brush.Color := $00FEF6FC
  else
    (Sender as TDBGrid).Canvas.Brush.Color := $00FFF9F4;

  //AQUI MANEJAMOS EL COLOR DE LAS CELDAS CUANDO ESTAN SELECCIONADAS CON EL MOUSE
  if (gdSelected in State) then
    begin
       DBGrid1.Canvas.Font.Color  := clLime;
       DBGrid1.Canvas.Brush.Color := $00C56A31;
    end
  else
    DBGrid1.Canvas.Font.Color := clBlack;

  //CAMBIAR EL COLOR DE UNA COLUMNA
  if DataCol = 4 then
    begin
      if (gdSelected in State) then //SI LA SELECCIONAMOS CON EL MOUSE
        begin
           DBGrid1.Canvas.Font.Color  := clLime;
           DBGrid1.Canvas.Brush.Color := $00C56A31;
        end
      else     //DE LO CONTRARIO TENDRA ESTE COLOR
        begin
          DBGrid1.Canvas.Font.Color  := clBlack;
          DBGrid1.Canvas.Brush.Color := clYellow;
        end;
    end;

  //AL PARECER ESTA LINEA HAY QUE PONERLA SIEMPRE AL FINAL
  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TForm1.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin     //NOS DESPLAZAMOS CON LA TECLA ENTER EN EL DBGRID
  if Key = #13 then
    begin
      if DBGrid1.Columns.Grid.SelectedIndex < DBGrid1.Columns.Count - 1 then
        DBGrid1.Columns[DBGrid1.Columns.Grid.SelectedIndex + 1].Field.FocusControl
      else
        begin
          DBGrid1.DataSource.DataSet.Next;
          DBGrid1.Columns[0].Field.FocusControl;
        end;
    end;
end;

procedure TForm1.DistribuirPago(MontoTotal : Double);
var
  Marcador : TBookmark;
  MontoRestante : Double;
begin
  MontoRestante := MontoTotal;

  MtDocumentos.DisableControls;
  try
    Marcador := MtDocumentos.GetBookmark;
    MtDocumentos.First;
    while not MtDocumentos.Eof do
      begin
        if MontoRestante <= 0 then
          Break;    // Si ya no queda dinero, salir del bucle.

        MtDocumentos.Edit;

        // Si el monto restante es mayor o igual al saldo de la factura actual, se paga completamente
        if MontoRestante >= MtDocumentos.FieldByName('Saldo').AsFloat then
          begin
            MtDocumentos.FieldByName('MontoAplicado').AsFloat := MtDocumentos.FieldByName('Saldo').AsFloat;  // Aplicamos todo el saldo pendiente
            MontoRestante                                     := MontoRestante - MtDocumentos.FieldByName('Saldo').AsFloat;  // Reducimos el monto restante
            MtDocumentos.FieldByName('Saldo').AsFloat         := 0;  // Factura pagada completamente
          end
        else
          begin
            // Si el monto restante es menor que el saldo, aplicamos todo lo que queda
            MtDocumentos.FieldByName('MontoAplicado').AsFloat := MontoRestante;
            MtDocumentos.FieldByName('Saldo').AsFloat         := MtDocumentos.FieldByName('Saldo').AsFloat - MontoRestante;  // Reducimos el saldo de la factura
            MontoRestante                                     := 0;  // Ya no queda monto por distribuir
          end;

        MtDocumentos.Post;
        MtDocumentos.Next;
      end;
  finally
    MtDocumentos.GotoBookmark(Marcador);
    MtDocumentos.FreeBookmark(Marcador);
    MtDocumentos.EnableControls;
  end;

  if (wDeudaCliente - MontoTotal) > 0 then
    LbDiferencia.Caption := FormatFloat('###,##,##0.00', wDeudaCliente - MontoTotal)
  else
    LbDiferencia.Caption := '0.00';
end;

procedure TForm1.RevertirDistribucion;
var
  Marcador : TBookmark;
begin
  MtDocumentos.DisableControls;
  try
    Marcador := MtDocumentos.GetBookmark;
    MtDocumentos.First;
    while not MtDocumentos.Eof do
      begin
        MtDocumentos.Edit;

        // Restaura el saldo original sumando el monto aplicado al saldo actual
        MtDocumentos.FieldByName('Saldo').AsFloat := MtDocumentos.FieldByName('Saldo').AsFloat +
                                                     MtDocumentos.FieldByName('MontoAplicado').AsFloat;
        MtDocumentos.FieldByName('MontoAplicado').AsFloat := 0;  // Resetea el monto aplicado a cero
        MtDocumentos.Post;
        MtDocumentos.Next;
      end;
  finally
    MtDocumentos.GotoBookmark(Marcador);
    MtDocumentos.FreeBookmark(Marcador);
    MtDocumentos.EnableControls;
  end;
end;

function TForm1.GenerarConcepto : string;
var
  Marcador : TBookmark;
  Concepto : string;
begin
  Concepto := EmptyStr;

  MtDocumentos.DisableControls;
  Marcador := MtDocumentos.GetBookmark;
  try
    MtDocumentos.First;
    while not MtDocumentos.Eof do
    begin
      if MtDocumentos.FieldByName('MontoAplicado').AsFloat > 0 then
        begin
          if MtDocumentos.FieldByName('Saldo').AsFloat = 0 then
            Concepto := Concepto + 'Saldo ' + MtDocumentos.FieldByName('Documento').AsString + ' nro. ' + MtDocumentos.FieldByName('NroDocumento').AsString + ', '
          else
            Concepto := Concepto + 'Abono ' + MtDocumentos.FieldByName('Documento').AsString + ' nro. ' + MtDocumentos.FieldByName('NroDocumento').AsString + ', ';
        end;

      MtDocumentos.Next;
    end;
  finally
    MtDocumentos.GotoBookmark(Marcador);
    MtDocumentos.FreeBookmark(Marcador);
    MtDocumentos.EnableControls;
  end;

  Result := Copy(Concepto,1, Length(Concepto)-2); //Le quitamos la ultima coma y el espacio

end;


{FUNCION PARA OBTENER EL TOTAL DE UN CAMPO.
 NOTA : SI QUIERES FORMATEAR (FormatFloat) EL RESULTADO APLICAS ESTAS MASCARAS :
 SI EL CAMPO ES DECIMAL '##,##0.00' SI ES ENTERO ',0'
 EJEMPLO :
 Label1.Caption := FormatFloat( '##,##0.00', TotalCampo(UniTable1,'CUADRADO'));
 Label1.Caption := FormatFloat(',0', TotalCampo(UniTable1,'CUADRADO')); }
{function TForm1.TotalCampo(Dataset : TDataSet; Campo : string) : Double;
var
  B : TBookmark;
  Total : Double;
begin
  Result := 0;
  B := Dataset.GetBookmark;
  Dataset.DisableControls;

  //Validamos el tipo de dato del campo
  if not (Dataset.FieldByName(Campo).DataType in [ftFloat, ftCurrency,
          ftBCD, ftInteger, ftSmallint, ftWord, ftByte, ftShortint,
          ftLongWord, ftLargeint]) then
    Exit;

  Total := 0;
   try
     Dataset.First;
     while not Dataset.Eof do
       begin
         Total := Total + Dataset.FieldByName(Campo).AsFloat;
         Dataset.Next;
       end;
   finally
     Dataset.GotoBookmark(B);
     Dataset.EnableControls;
     Dataset.FreeBookmark(B);
   end;
  Result := Total;
end;
}

end.

