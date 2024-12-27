unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;


type
  TFactura = record
    ID             : Integer;
    MontoPendiente : Double;
    MontoPagado    : Double;
    Estatus        : string;
  end;

type
  TForm1 = class(TForm)
    Button1: TButton;
    EdMontoPagar: TLabeledEdit;
    ListBox1: TListBox;
    ListBox2: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Facturas : array[0..2] of TFactura;
    procedure DistribuirPago(var Facturas : array of TFactura; MontoTotal : Double);
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  MontoTotal : Double;
  I : Integer;
begin
  // Monto total a pagar
  MontoTotal := StrToFloat(EdMontoPagar.Text);

  // Llamada a la función para distribuir el pago
  DistribuirPago(Facturas, MontoTotal);

  // Mostrar resultados
//  for I := 0 to High(Facturas) do
//  begin
//    ShowMessage(Format('Factura %d: Monto pagado = %.2f', [Facturas[I].ID, Facturas[I].MontoPagado]));
//  end;

  ListBox2.Items.Clear;
  for I := 0 to High(Facturas) do
    begin
      ListBox2.Items.Add('Factura : ' + IntToStr(Facturas[I].ID) +'   Monto Pagado : '+
      FloatToStr(Facturas[I].MontoPagado) + '  Monto Pendiente : ' + FloatToStr(Facturas[I].MontoPendiente) + '  Estatus : ' + Facturas[I].Estatus);
    end;

end;

procedure TForm1.FormShow(Sender: TObject);
var
  I : Integer;
begin
  // Ejemplo de facturas
  Facturas[0].ID             := 1;
  Facturas[0].MontoPendiente := 100.0;
  Facturas[0].MontoPagado    := 0;
  Facturas[0].Estatus        := 'Pendiente';

  Facturas[1].ID             := 2;
  Facturas[1].MontoPendiente := 150.0;
  Facturas[1].MontoPagado    := 0;
  Facturas[1].Estatus        := 'Pendiente';

  Facturas[2].ID             := 3;
  Facturas[2].MontoPendiente := 200.0;
  Facturas[2].MontoPagado    := 0;
  Facturas[2].Estatus        := 'Pendiente';

  ListBox1.Items.Clear;
  for I := 0 to High(Facturas) do
    begin
      ListBox1.Items.Add('Factura : ' + IntToStr(Facturas[I].ID) +'   Monto Pendiente : '+
      FloatToStr(Facturas[I].MontoPendiente) + '  Estatus : ' + Facturas[I].Estatus);
    end;

end;

procedure TForm1.DistribuirPago(var Facturas : array of TFactura; MontoTotal : Double);
var
  I : Integer;
  MontoRestante : Double;
begin
  MontoRestante := MontoTotal;

  for I := 0 to High(Facturas) do
    begin
      if MontoRestante <= 0 then
        Break; // Si ya no queda dinero, salir del bucle.

      // Si el monto restante es mayor o igual al monto pendiente, se paga completamente
      if MontoRestante >= Facturas[I].MontoPendiente then
        begin
          Facturas[I].MontoPagado    := Facturas[I].MontoPendiente;
          MontoRestante              := MontoRestante - Facturas[I].MontoPendiente;
          Facturas[I].MontoPendiente := 0; // Factura pagada completamente
          Facturas[I].Estatus        := 'Pagada';
        end
      else // Si no, se paga solo lo que queda
        begin
          Facturas[I].MontoPagado    := MontoRestante;
          Facturas[I].MontoPendiente := Facturas[I].MontoPendiente - MontoRestante; // Actualizar monto pendiente
          MontoRestante              := 0; // Ya no queda dinero por distribuir
          Facturas[I].Estatus        := 'Pendiente';
        end;
    end;
end;


end.
