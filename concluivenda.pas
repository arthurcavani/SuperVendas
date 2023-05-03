unit concluivenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, Mask, DBCtrls, Grids, DBGrids, inifiles;

type
  Tvendaconclui = class(TForm)
    background: TImage;
    lblCliente: TLabel;
    nomecliente: TEdit;
    procuracliente: TButton;
    cadastro: TButton;
    lblpagamento: TLabel;
    metodopagamento: TComboBox;
    lbldesconto: TLabel;
    desconto: TEdit;
    lblporcento: TLabel;
    lblrecebido: TLabel;
    recebido: TEdit;
    lbltroco: TLabel;
    troco: TLabel;
    conclui: TButton;
    lblvendedor: TLabel;
    procurarcliente: TPanel;
    codigocliente: TEdit;
    addback: TImage;
    tabclientesadd: TDBGrid;
    codigoclienteadd: TDBEdit;
    nomeclienteadd: TDBEdit;
    addcliente: TButton;
    GroupBox1: TGroupBox;
    buscacliente: TEdit;
    tipopesquisa: TComboBox;
    cancelar: TButton;
    cadcliente: TPanel;
    Image1: TImage;
    cadastrarcliente: TButton;
    cancelacad: TButton;
    lblnome: TLabel;
    nomeadd: TEdit;
    rgcpf: TLabel;
    rgcpfadd: TEdit;
    Label1: TLabel;
    endereçoadd: TEdit;
    Label2: TLabel;
    telefoneadd: TEdit;
    emailadd: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    notasadd: TMemo;
    Label5: TLabel;
    effect: TTimer;
    procedure recebidoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure buscaclienteChange(Sender: TObject);
    procedure tipopesquisaChange(Sender: TObject);
    procedure cancelarClick(Sender: TObject);
    procedure addclienteClick(Sender: TObject);
    procedure procuraclienteClick(Sender: TObject);
    procedure cancelacadClick(Sender: TObject);
    procedure cadastrarclienteClick(Sender: TObject);
    procedure cadastroClick(Sender: TObject);
    procedure codigoclienteKeyPress(Sender: TObject; var Key: Char);
    procedure nomeclienteKeyPress(Sender: TObject; var Key: Char);
    procedure metodopagamentoKeyPress(Sender: TObject; var Key: Char);
    procedure descontoKeyPress(Sender: TObject; var Key: Char);
    procedure nomeaddKeyPress(Sender: TObject; var Key: Char);
    procedure rgcpfaddKeyPress(Sender: TObject; var Key: Char);
    procedure endereçoaddKeyPress(Sender: TObject; var Key: Char);
    procedure telefoneaddKeyPress(Sender: TObject; var Key: Char);
    procedure emailaddKeyPress(Sender: TObject; var Key: Char);
    procedure descontoChange(Sender: TObject);
    procedure metodopagamentoChange(Sender: TObject);
    procedure recebidoChange(Sender: TObject);
    procedure concluiClick(Sender: TObject);
    procedure effectTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  vendaconclui: Tvendaconclui;
  fnl:real;

implementation
uses main;
procedure EnDecryptFile(INFName, OutFName : String; Chave : Word);
var
InMS, OutMS : TMemoryStream;
I : Integer;
C : byte;
begin
  InMS := TMemoryStream.Create;
  OutMS := TMemoryStream.Create;
  try
  InMS.LoadFromFile(INFName);
  InMS.Position := 0;
  for I := 0 to InMS.Size - 1 do
  begin
    InMS.Read(C, 1);
    C := (C xor not(ord(chave shr I)));
    OutMS.Write(C,1);
  end;
  OutMS.SaveToFile(OutFName);
  finally
  InMS.Free;
  OutMS.Free;
end;
end;

{$R *.dfm}

procedure Tvendaconclui.addclienteClick(Sender: TObject);
begin
if codigoclienteadd.Text='' then
abort;
if nomeclienteadd.Text='' then
abort;
codigocliente.Text:=codigoclienteadd.Text;
nomecliente.Text:=nomeclienteadd.Text;
mainform.adoclientes.Close;
mainform.adoclientes.CommandText:='Select * from clientes';
mainform.adoclientes.Open;
mainform.adoclientes.Active:=True;
procurarcliente.Visible:=false;
end;

procedure Tvendaconclui.buscaclienteChange(Sender: TObject);
begin
mainform.adoclientes.Close;
mainform.adoclientes.CommandText:='Select * from clientes where '+tipopesquisa.text+' LIKE :busca9';
mainform.adoclientes.Parameters.ParamByName('busca9').Value:='%'+buscacliente.Text+'%';
mainform.adoclientes.Open;
mainform.adoclientes.Active:=True;
end;

procedure Tvendaconclui.cadastrarclienteClick(Sender: TObject);
begin
if nomeadd.Text='' then
begin
  showmessage('Nome é requerido');
  abort;
end;
mainform.adoclientes.Append;
mainform.adoclientesnome.AsString:=nomeadd.text;
mainform.adoclientesrgcpf.AsString:=rgcpfadd.text;
mainform.adoclientesendereço.AsString:=endereçoadd.Text;
mainform.adoclientestelefone.AsString:=telefoneadd.Text;
mainform.adoclientesEMail.AsString:=emailadd.Text;
mainform.adoclientesobservações.AsString:=notasadd.Text;
mainform.adoclientes.Post;
mainform.adoclientes.Refresh;
//Procura o código do novo cliente
mainform.adoclientes.Close;
mainform.adoclientes.CommandText:='Select * from clientes where Nome='''+(nomeadd.text)+'''';
mainform.adoclientes.Open;
mainform.adoclientes.Active:=True;
codigocliente.Text:=mainform.adoclientes.FieldByname('Código').Text;
nomecliente.Text:=nomeadd.Text;
mainform.adoclientes.Close;
mainform.adoclientes.CommandText:='select * from clientes';
mainform.adoclientes.Open;
mainform.adoclientes.Active:=True;
cadcliente.Visible:=false;
end;

procedure Tvendaconclui.cadastroClick(Sender: TObject);
begin
nomeadd.Clear;
rgcpfadd.Clear;
endereçoadd.Clear;
telefoneadd.clear;
emailadd.Clear;
notasadd.Clear;
cadcliente.Visible:=true;
nomeadd.SetFocus;
end;

procedure Tvendaconclui.cancelacadClick(Sender: TObject);
begin
cadcliente.Visible:=false;
end;

procedure Tvendaconclui.cancelarClick(Sender: TObject);
begin
mainform.adoclientes.Close;
mainform.adoclientes.CommandText:='Select * from clientes';
mainform.adoclientes.Open;
mainform.adoclientes.Active:=True;
procurarcliente.Visible:=false;
end;

procedure Tvendaconclui.codigoclienteKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
nomecliente.SetFocus;
end;

procedure Tvendaconclui.concluiClick(Sender: TObject);
var
resp:integer;
begin
  Resp := MessageDlg(('Tem certeza que deseja concluir a venda?'),mtConfirmation,[mbYes,mbNo],0);
  if Resp = mrNo then
  abort;
if nomecliente.Text='' then
begin
showmessage('Cliente é requerido.');
abort;
end;
if metodopagamento.ItemIndex<0 then
begin
showmessage('Método de pagamento é requerido.');
abort;
end;
if strtoint(desconto.Text)<0 then
desconto.Text:='0';
if strtoint(desconto.Text)>100 then
desconto.Text:='0';
if desconto.Text='' then
desconto.Text:='0';
with mainform.adolista do
begin
disablecontrols;
first;
  While not Eof do
  begin
  //CADASTRO NO HISTÓRICO
mainform.adorelvendas.Append;
mainform.adorelvendasproduto.AsString:=FieldByname('Descrição').Text;
mainform.adorelvendasquantidade.AsString:=FieldByname('Quantidade').Text;
mainform.adorelvendasPreço.AsString:=floattostr(strtofloat(FieldByname('Preço').Text)/strtofloat(FieldByname('Quantidade').Text));
mainform.adorelvendasdesconto.AsString:=desconto.Text+'%';
mainform.adorelvendasvendedor.AsString:=mainform.activeuser.Caption;
mainform.adorelvendasdata.AsString:=FormatDateTime('dd/mm/yyyy(hh:mm)',now);
mainform.adorelvendascliente.AsString:=nomecliente.text;
mainform.adorelvendaspagamento.AsString:=metodopagamento.Text;
mainform.adorelvendas.Post;
mainform.adorelvendas.Refresh;
//BAXA NO ESTOQUE
mainform.adoprodutos.Close;
mainform.adoprodutos.CommandText:='select * from produtos where Descrição='''+FieldByname('Descrição').Text+'''';
mainform.adoprodutos.Open;
mainform.adoprodutos.Active:=true;

if mainform.adoprodutos.Locate('Descrição',Mainform.adoprodutosdescrição.AsString,[]) then
      begin
        Mainform.adoprodutos.Edit;
        Mainform.adoprodutosestoque.Value:=Mainform.adoprodutosestoque.Value-strtoint(FieldByname('Quantidade').Text);
        Mainform.adoprodutos.Post;
        Mainform.adoprodutos.Refresh;
      end;
  Next;
end;
enablecontrols;
end;
mainform.adoprodutos.Close;
mainform.adoprodutos.CommandText:='select * from produtos';
mainform.adoprodutos.Open;
mainform.adoprodutos.Active:=true;
mainform.adovendas.Refresh;
//ZERA TABELA ADOLISTA
With mainform.Adolista do
 While RecordCount > 0 do
Delete;
mainform.listatotal.Caption:='0,00';
Close;
end;

procedure Tvendaconclui.descontoChange(Sender: TObject);
VAR
p1,p2,p3,p4,tr:real;
fn,pr:string;
begin
if desconto.Text='' then
begin
label5.Caption:='De : R$'+mainform.listatotal.Caption+' Por : R$'+mainform.listatotal.Caption;
if strtofloat(recebido.text)<strtofloat(mainform.listatotal.Caption) then
troco.Caption:='0,00'
else
begin
tr:=strtofloat(recebido.text)-strtofloat(mainform.listatotal.Caption);
pr:=FormatFloat('0.00',tr);
troco.Caption:=pr;
end;
abort;
end;
if desconto.Text='100' then
begin
label5.Caption:='De : R$'+mainform.listatotal.Caption+' Por : R$0,00';
troco.Caption:=recebido.Text;
abort;
end;
if strtoint(desconto.Text)>100 then
begin
label5.Caption:='De : R$'+mainform.listatotal.Caption+' Por : R$0,00';
troco.Caption:=recebido.Text;
abort;
end;
p1:=strtofloat(mainform.listatotal.caption);
p2:=p1/100;
p3:=p2*strtoint(desconto.text);
p4:=strtofloat(mainform.listatotal.Caption)-p3;
fn:=FormatFloat('0.00',p4);
fnl:=strtofloat(fn);
//recalcula troco
if strtofloat(recebido.text)<fnl then
troco.Caption:='0,00'
else
begin
tr:=strtofloat(recebido.text)-fnl;
pr:=FormatFloat('0.00',tr);
troco.Caption:=pr;
end;
 //verifica casas
if Frac(fnl) = 0.00 then
begin
label5.Caption:='De : R$'+mainform.listatotal.Caption+' Por : R$'+floattostr(fnl)+',00';
abort;
end;
//verifica casas
if Frac(fnl*10) = 0.00 then
begin
label5.Caption:='De : R$'+mainform.listatotal.Caption+' Por : R$'+floattostr(fnl)+'0';
abort;
end;

label5.Caption:='De : R$'+mainform.listatotal.Caption+' Por : R$'+floattostr(fnl);
end;

procedure Tvendaconclui.descontoKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
if recebido.Enabled=true then
recebido.SetFocus
else
conclui.setfocus;
end;

procedure Tvendaconclui.effectTimer(Sender: TObject);
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

procedure Tvendaconclui.emailaddKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
notasadd.SetFocus;
end;

procedure Tvendaconclui.endereçoaddKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
telefoneadd.SetFocus;
end;

procedure Tvendaconclui.FormClose(Sender: TObject; var Action: TCloseAction);
begin
vendaconclui.free;
end;

procedure Tvendaconclui.FormCreate(Sender: TObject);
var
dir:string;
arq:tinifile;
dscontos:string;
begin
label5.Caption:='De : R$'+mainform.listatotal.Caption+' Por : R$'+mainform.listatotal.Caption;
lblvendedor.Caption:='Vendedor : '+mainform.activeuser.Caption;
FNL:=strtofloat(mainform.listatotal.Caption);
dir:=extractfilepath(application.exename);
if fileexists('vend.shp') then
 EnDecryptFile('vend.shp','tempdata.shp',43)
 else
 begin
 showmessage('Não foi possível ler permissões por falta de arquivo de definições.');
 desconto.Enabled:=false;
 end;
arq:=tinifile.Create(''+(dir)+'\tempdata.shp');
if arq.ReadString(mainform.activeuser.caption,'drDescontos','n')='n' then
desconto.Enabled:=false;
deletefile('tempdata.shp');
end;

procedure Tvendaconclui.metodopagamentoChange(Sender: TObject);
begin
if metodopagamento.Text<>'Dinheiro' then
recebido.Enabled:=false
else
recebido.Enabled:=true;
end;

procedure Tvendaconclui.metodopagamentoKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
desconto.SetFocus;
end;

procedure Tvendaconclui.nomeaddKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
rgcpfadd.SetFocus;
end;

procedure Tvendaconclui.nomeclienteKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
metodopagamento.SetFocus;
end;

procedure Tvendaconclui.procuraclienteClick(Sender: TObject);
begin
procurarcliente.Visible:=true;
end;

procedure Tvendaconclui.recebidoChange(Sender: TObject);
var
tr:real;
pr:string;
begin
if recebido.Text='' then
abort;
if strtofloat(recebido.text)<fnl then
begin
troco.Caption:='0,00';
abort;
end;
tr:=strtofloat(recebido.text)-fnl;
pr:=FormatFloat('0.00',tr);
troco.Caption:=pr;
end;

procedure Tvendaconclui.recebidoKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
conclui.SetFocus;
if not (Key in['0'..'9',DecimalSeparator,Chr(8)]) then Key:= #0;
end;

procedure Tvendaconclui.rgcpfaddKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
endereçoadd.SetFocus;
end;

procedure Tvendaconclui.telefoneaddKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
emailadd.SetFocus;
end;

procedure Tvendaconclui.tipopesquisaChange(Sender: TObject);
begin
mainform.adoclientes.Close;
mainform.adoclientes.CommandText:='Select * from clientes where '+tipopesquisa.text+' LIKE :busca9';
mainform.adoclientes.Parameters.ParamByName('busca9').Value:='%'+buscacliente.Text+'%';
mainform.adoclientes.Open;
mainform.adoclientes.Active:=True;
end;

end.
