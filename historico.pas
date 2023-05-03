unit historico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, jpeg, StdCtrls, ComCtrls;

type
  TfrmHistorico = class(TForm)
    Image1: TImage;
    tabrel: TDBGrid;
    boxconsulta: TGroupBox;
    pesquisa95: TEdit;
    effect: TTimer;
    tipo: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    tabrelreposicoes: TDBGrid;
    procedure effectTimer(Sender: TObject);
    procedure pesquisa95Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tipoChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHistorico: TfrmHistorico;

implementation
uses main;

{$R *.dfm}

procedure TfrmHistorico.Button1Click(Sender: TObject);
begin
mainform.adorelvendas.Close;
mainform.adorelvendas.CommandText:='Select * from relvendas where '+tipo.text+' LIKE :busca0';
mainform.adorelvendas.Parameters.ParamByName('busca0').Value:='%'+pesquisa95.Text+'%';
mainform.adorelvendas.Open;
mainform.adorelvendas.Active:=True;
end;

procedure TfrmHistorico.effectTimer(Sender: TObject);
begin
  if alphablendvalue=255 then
begin
effect.Enabled:=false;
abort;
end;
if alphablendvalue=254 then
begin
alphablendvalue:=alphablendvalue+1;
effect.Enabled:=false;
abort;
end;
alphablendvalue:=alphablendvalue+2;
end;

procedure TfrmHistorico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
frmhistorico.free;
end;

procedure TfrmHistorico.PageControl1Change(Sender: TObject);
begin
if pagecontrol1.ActivePage=TabSheet1 then
begin
 tipo.Items.Clear;
tipo.Items.Add('Produto');
tipo.Items.Add('Quantidade');
tipo.Items.Add('Preço');
tipo.Items.Add('Desconto');
tipo.Items.Add('Vendedor');
tipo.Items.Add('Data');
tipo.Items.Add('Cliente');
tipo.Items.Add('Pagamento');
tipo.ItemIndex:=0;
end;
if pagecontrol1.ActivePage=TabSheet2 then
begin
tipo.Items.Clear;
tipo.Items.Add('Produto');
tipo.Items.Add('Quantidade');
tipo.Items.Add('Gasto');
tipo.Items.Add('Vendedor');
tipo.Items.Add('Data');
tipo.ItemIndex:=0;
end;
end;

procedure TfrmHistorico.pesquisa95Change(Sender: TObject);
begin
if pagecontrol1.ActivePage=TabSheet1 then
begin
mainform.adorelvendas.Close;
mainform.adorelvendas.CommandText:='Select * from relvendas where '+tipo.text+' LIKE :busca0';
mainform.adorelvendas.Parameters.ParamByName('busca0').Value:='%'+pesquisa95.Text+'%';
mainform.adorelvendas.Open;
mainform.adorelvendas.Active:=True;
end
else
if pagecontrol1.ActivePage=TabSheet2 then
begin
 mainform.adorelreposicao.Close;
mainform.adorelreposicao.CommandText:='Select * from relreposicao where '+tipo.text+' LIKE :busca474';
mainform.adorelreposicao.Parameters.ParamByName('busca474').Value:='%'+pesquisa95.Text+'%';
mainform.adorelreposicao.Open;
mainform.adorelreposicao.Active:=True;
end;
end;

procedure TfrmHistorico.tipoChange(Sender: TObject);
begin
if pagecontrol1.ActivePage=TabSheet1 then
begin
mainform.adorelvendas.Close;
mainform.adorelvendas.CommandText:='Select * from relvendas where '+tipo.text+' LIKE :busca0';
mainform.adorelvendas.Parameters.ParamByName('busca0').Value:='%'+pesquisa95.Text+'%';
mainform.adorelvendas.Open;
mainform.adorelvendas.Active:=True;
end
else
if pagecontrol1.ActivePage=TabSheet2 then
begin
 mainform.adorelreposicao.Close;
mainform.adorelreposicao.CommandText:='Select * from relreposicao where '+tipo.text+' LIKE :busca474';
mainform.adorelreposicao.Parameters.ParamByName('busca474').Value:='%'+pesquisa95.Text+'%';
mainform.adorelreposicao.Open;
mainform.adorelreposicao.Active:=True;
end;
end;

end.
