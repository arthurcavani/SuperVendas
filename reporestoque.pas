unit reporestoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, DBCtrls, jpeg, Mask;

type
  TrEstoque = class(TForm)
    effect: TTimer;
    lblproduto: TLabel;
    lblquantidade: TLabel;
    lblgasto: TLabel;
    codproduto: TEdit;
    quantproduto: TEdit;
    gasto: TEdit;
    procuraprod: TButton;
    Concluir: TButton;
    Adicionar: TButton;
    tablistacompra: TDBGrid;
    descricaoitem: TLabel;
    DBNavigator1: TDBNavigator;
    Image1: TImage;
    procurarprod: TPanel;
    addback: TImage;
    tabprod: TDBGrid;
    codprod: TDBEdit;
    nomeprod: TDBEdit;
    add: TButton;
    GroupBox1: TGroupBox;
    buscacliente: TEdit;
    tipopesquisa: TComboBox;
    cancelar: TButton;
    procedure effectTimer(Sender: TObject);
    procedure gastoKeyPress(Sender: TObject; var Key: Char);
    procedure AdicionarClick(Sender: TObject);
    procedure codprodutoChange(Sender: TObject);
    procedure atualizadescTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure codprodutoKeyPress(Sender: TObject; var Key: Char);
    procedure quantprodutoKeyPress(Sender: TObject; var Key: Char);
    procedure ConcluirClick(Sender: TObject);
    procedure cancelarClick(Sender: TObject);
    procedure addClick(Sender: TObject);
    procedure procuraprodClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rEstoque: TrEstoque;

implementation
uses main;

{$R *.dfm}

procedure TrEstoque.addClick(Sender: TObject);
begin
if codprod.Text='' then
abort;
if nomeprod.Text='' then
abort;
codproduto.Text:=codprod.Text;
mainform.adoprodutos.Close;
mainform.adoprodutos.CommandText:='Select * from produtos';
mainform.adoprodutos.Open;
mainform.adoprodutos.Active:=True;
procurarprod.Visible:=false;
end;

procedure TrEstoque.AdicionarClick(Sender: TObject);
var
qnt,pre,fn:real;
finalpre:string;
begin
if codproduto.Text='' then
begin
showmessage('Produto é requerido.');
abort;
end;
if descricaoitem.Caption='Nenhum item encontrado' then
begin
showmessage('Nenhum item encontrado para o Código : '+codproduto.text);
abort;
end;
if quantproduto.Text='' then
begin
showmessage('Quantidade é requerida.');
abort;
end;
if strtoint(quantproduto.Text)<1 then
begin
showmessage('Quantidade maior que 0 é requerida.');
abort;
end;
if gasto.Text='' then
begin
showmessage('Gasto por unidade é requerido.');
abort;
end;
if strtofloat(gasto.Text)=0 then
begin
showmessage('Gasto por unidade maior que 0 é requerido.');
abort;
end;
if codproduto.text='' then
abort;
if quantproduto.text='' then
abort;
if quantproduto.Text='0' then
abort;
qnt:=strtofloat(quantproduto.text);
pre:=strtofloat(gasto.text);
fn:=qnt*pre;
finalpre:=floattostr(fn);
mainform.adolistacompra.Append;
mainform.adolistacompraproduto.AsString:=descricaoitem.caption;
mainform.adolistacompratotal.AsString:=finalpre;
mainform.adolistacomprapreçounidade.AsString:=gasto.text;
mainform.adolistacompraquantidade.AsString:=quantproduto.Text;
mainform.adolistacompra.Post;
mainform.adolistacompra.Refresh;
codproduto.setfocus;
end;

procedure TrEstoque.atualizadescTimer(Sender: TObject);
begin
descricaoitem.Caption:=mainform.descurrentitem.Text;
end;

procedure TrEstoque.cancelarClick(Sender: TObject);
begin
procurarprod.visible:=false;
end;

procedure TrEstoque.codprodutoChange(Sender: TObject);
begin
if codproduto.Text='' then
begin
descricaoitem.Caption:='';
abort;
end;
mainform.adovaloresvenda.Close;
mainform.adovaloresvenda.CommandText:='Select * from produtos where Código LIKE :busca669';
mainform.adovaloresvenda.Parameters.ParamByName('busca669').Value:='%'+codproduto.Text+'%';
mainform.adovaloresvenda.Open;
mainform.adovaloresvenda.Active:=True;
if mainform.descurrentitem.Text='' then
begin
descricaoitem.Caption:='Nenhum item encontrado';
abort;
end;
descricaoitem.Caption:=mainform.descurrentitem.Text;
//reset
mainform.adovaloresvenda.Close;
mainform.adovaloresvenda.CommandText:='Select * from produtos';
mainform.adovaloresvenda.Open;
mainform.adovaloresvenda.Active:=True;
end;

procedure TrEstoque.codprodutoKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
quantproduto.SetFocus;
end;

procedure TrEstoque.ConcluirClick(Sender: TObject);
var
resp:integer;
begin
  Resp := MessageDlg(('Tem certeza que deseja concluir reposição de estoque?'),mtConfirmation,[mbYes,mbNo],0);
  if Resp = mrNo then
  abort;
with mainform.adolistacompra do
begin
disablecontrols;
first;
  While not Eof do
  begin
  //CADASTRO NO HISTÓRICO
mainform.adorelreposicao.Append;
mainform.adorelreposicaoproduto.AsString:=FieldByname('Produto').Text;
mainform.adorelreposicaoquantidade.AsString:=FieldByname('Quantidade').Text;
mainform.adorelreposicaogasto.AsString:=FieldByname('Total').Text;
mainform.adorelreposicaovendedor.AsString:=mainform.activeuser.Caption;
mainform.adorelreposicaodata.AsString:=FormatDateTime('dd/mm/yyyy(hh:mm)',now);
mainform.adorelreposicao.Post;
mainform.adorelreposicao.Refresh;
//BAXA NO ESTOQUE
mainform.adoprodutos.Close;
mainform.adoprodutos.CommandText:='select * from produtos where Descrição='''+FieldByname('Produto').Text+'''';
mainform.adoprodutos.Open;
mainform.adoprodutos.Active:=true;

if mainform.adoprodutos.Locate('Descrição',Mainform.adoprodutosdescrição.AsString,[]) then
      begin
        Mainform.adoprodutos.Edit;
        Mainform.adoprodutosestoque.Value:=Mainform.adoprodutosestoque.Value+strtoint(FieldByname('Quantidade').Text);
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
//ZERA TABELA ADOLISTACOMPRA
With mainform.Adolistacompra do
 While RecordCount > 0 do
Delete;
Close;
end;

procedure TrEstoque.effectTimer(Sender: TObject);
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

procedure TrEstoque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key = vk_F7) then
dbnavigator1.BtnClick(nbDelete);
end;

procedure TrEstoque.gastoKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
adicionar.SetFocus;
if not (Key in['0'..'9',DecimalSeparator,Chr(8)]) then Key:= #0;
end;

procedure TrEstoque.procuraprodClick(Sender: TObject);
begin
procurarprod.Visible:=true;
end;

procedure TrEstoque.quantprodutoKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
gasto.SetFocus;
end;

end.
