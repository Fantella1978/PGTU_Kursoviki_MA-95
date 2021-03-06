unit fconst;

INTERFACE

uses objects, menus, views, dialogs, drivers, msgbox, app;

const
 cmAbout        =201;
 cmChangeVideo  =200;
 cmNewTnagr     =210;
 cmNewDTk       =211;
 cmNewT0        =212;
 cmNewC         =213;
 cmNewT         =214;
 cmNewDTdop     =215;
 cmNewLambda    =216;
 cmNew_A_       =217;
 cmNewDTau      =218;
 cmNewS         =219;
 cmNewH         =220;
 cmNagrev       =221;
 cmNewUzel      =222;
 cmGraphic      =223;
 cmNewTMaxMet   =224;
 cmNewTMaxSv1   =225;
 cmNewModel     =247;
 cmLoadModel    =248;
 cmSaveModel    =249;
 cmSaveModelAs  =250;
 cmCloseModel   =251;
 hcNewModel     =1001;
 hcSaveModel    =1002;
 hcSaveModelAs  =1003;
 hcLoadModel    =1004;
 hcChangeVideo  =1005;
 hcDosShell     =1006;
 hcCloseModel   =1007;
 hcNagrev       =1008;
 hcNewDTau      =1009;
 hcGraphic      =1010;
 hcNewUzel      =1011;
 hcAbout        =1012;
 hcNewT0        =1013;
 hcNewTnagr     =1014;
 hcNewC         =1015;
 hcNewDTdop     =1016;
 hcNewT         =1017;
 hcNewLambda    =1018;
 hcNew_A_       =1019;
 hcNewTMaxMet   =1020;
 hcNewTMaxSv1   =1021;
 hcNewDTk       =1022;
 hcNewS         =1023;
 hcNewH         =1024;

type

  model=record
    _S         ,{�p��� ᫨⪠}
    _H         ,{���� ᫨⪠}
    _T0        ,{⥬������ � 㧫�� � ��砫�� ������ �६���}
    _dh        ,{蠣 �� ���न���}
    _dTau      ,{蠣 �� �६���}
    _Cm        ,{�ਢ������ ����. �����. � ��⮤��᪮� ����}
    _Cc1       ,{�ਢ������ ����. �����. � ᢠ�筮� ���� 1}
    _Cc2       ,{�ਢ������ ����. �����. � ᢠ�筮� ���� 2}
    _Ct        ,{�ਢ������ ����. �����. � ⮬��쭮� ����}
    _Tm        ,{�।��� ⥬������ ����� � ��⮤��᪮� ����}
    _Tc1       ,{�।��� ⥬������ ����� � ᢠ�筮� ���� 1 }
    _Tc2       ,{�।��� ⥬������ ����� � ᢠ�筮� ���� 2 }
    _Tt        ,{�।��� ⥬������ ����� � ⮬��쭮� ����}
    _TMaxMet   ,{⥬��p���p� ���p��� � ��⮤��᪮� ����}
    _TMaxSv1   ,{⥬��p���p� ���p��� � ᢠp�筮� ���� 1 }
    _dTk       ,{�����⨬� ⥬������� ��९�� � ���� ���ॢ�}
    _Tnagr     ,{�������� ⥬������ ���ॢ�}
    _dTdop     ,{�����⨬� ��९�� ⥬������ � ���. ����}
    _a1        ,{�����樥�� �ண����}
    _lambda    ,{����. ⥯���஢������}
    _A_         {����. ⥬�����ய஢������}
    :real;
  end;

  PExtraMenuBar = ^TExtraMenuBar;
  TExtraMenuBar = object(TMenuBar)
     procedure Draw;virtual;
  end;

  PHintStatusLine = ^ THintStatusLine;
  THintStatusLine = object(TStatusLine)
     function Hint(AHelpCtx:Word):String; virtual;
  end;

function MyMessageBox(const Msg:string;Params:Pointer;AOptions:word):word;

IMPLEMENTATION

function MyMessageBoxRect(var R:tRect;const Msg:string;
                          Params:Pointer;AOptions:word):word;
const
  ButtonName:array[0..3]of string[6]=('��','���','����','�⬥��');
  Commands:array[0..3]of word=(cmYes,cmNo,cmOk,cmCancel);
  Titles:array[0..3]of string[11]=
         ('�।�०�.','�訡��','���ଠ��','���⢥ত.');
var
    I,X:Integer;
    Dialog:pDialog;
    Control:pView;
    S:string;
begin
  Dialog:=new(pDialog,Init(R,Titles[AOptions and $3]));
  with Dialog^ do
   begin
    Options:=Options or ofCentered;
    R.Assign(3,2,Size.X-2,Size.y-3);
    FormatStr(S,Msg,Params^);
    Insert(new(pStaticText,Init(R,S)));
    X:=-2;
    R.Assign(0,0,10,2);
    for i:=0 to 3 do
     if AOptions and ($0100 shl i)<>0 then inc(x,R.B.X-R.A.X+2);
    X:=(Size.x-x)shr 1;
    for i:=0 to 3 do
     if AOptions and ($0100 shl i)<>0 then
      begin
       Control:=New(pButton,init(R,ButtonName[i],Commands[i],bfNormal));
       Insert(Control);
       Control^.MoveTo(x,Size.y-3);
       inc(x,Control^.Size.x+2);
      end;
    SelectNext(False);
  end;
  if AOptions and mfInsertInApp=0
   then MyMessageBoxRect:=DeskTop^.ExecView(Dialog)
   else MyMessageboxRect:=Application^.ExecView(Dialog);
  Dispose(Dialog,Done);
end;

function MyMessageBox(const Msg:string;Params:Pointer;AOptions:word):word;
var
  R:tRect;
begin
  R.Assign(0,0,40,9);
  MyMessageBox:=MyMessageBoxRect(R,Msg,Params,AOptions);
end;

procedure TExtraMenuBar.Draw;
begin
TMenuBar.Draw;
WriteStr(0,0,'        ������p������ ���p��� ᫨⪮� � ���p�姮����'+
             ' ��⮤��᪮� ���.        ',$06);
WriteStr(0,1,'                    ���⠢�� ��. �p. ��-95 ���� :'+
             '����� �.�.                     ',$04);
end;

function THintStatusLine.Hint(AHelpCtx:Word):String;
begin
 case AHelpCtx of
  hcNewModel   :Hint:='������� ����� ������.';
  hcSaveModel  :Hint:='������� ������ �� ��� � ⥪�騬 ������.';
  hcSaveModelAs:Hint:='������� ������ �� ��� � ���� ������.';
  hcLoadModel  :Hint:='���p㧨�� ������ � ��᪠.';
  hcChangeVideo:Hint:='�������� ����� p����.';
  hcDosShell   :Hint:='�p������ ��室 � DOS.';
  hcCloseModel :Hint:='���p��� ������.';
  hcExit       :Hint:='��室 �� �p��p����.';
  hcNagrev     :Hint:='�p������� p���� ���p��� ᫨⪠.';
  hcNewDTau    :Hint:='���� ������ ���祭�� 蠣� �� �p�����.';
  hcGraphic    :Hint:='�뢮� �p�䨪�� ��������� ⥬��p���p� � ��p����� 㧫��.';
  hcNewUzel    :Hint:='��p��� 㧫�.';
  hcAbout      :Hint:='�����p�� ���p���� � �p��p����.';
  hcNewT0      :Hint:='���� ��砫쭮� ⥬��p���p� � 㧫��.';
  hcNewTnagr   :Hint:='���� ����筮� �������� ⥬��p���p� ���p���.';
  hcNewC       :Hint:='���� �p��������� �����樥�⮢ ����祭�� ������ ����.';
  hcNewDTdop   :Hint:='���� ���ᨬ��쭮-�����⨬��� ��p����� ⥬��p���p � ᫨⪥.';
  hcNewT       :Hint:='���� ⥬��p���p �p��� ������ ����.';
  hcNewLambda  :Hint:='���� ������ �����樥�� ⥯���p��������.';
  hcNew_A_     :Hint:='���� ������ �����樥�� ⥬��p���p��p��������.';
  hcNewTMaxMet :Hint:='���� ⥬��p���p� ��p�室� � 1-� ᢠp���� ����.';
  hcNewTMaxSv1 :Hint:='���� ⥬��p���p� ��p�室� �� 2-� ᢠp���� ����.';
  hcNewDTk     :Hint:='���� ������ ���祭�� �����⨬��� ����筮�� ��p����� ⥬��p���p.';
  hcNewS       :Hint:='���� ������ ���祭�� �p��� ᫨⪠.';
  hcNewH       :Hint:='���� ������ ���祭�� ����� ᫨⪠.';
 else Hint:='';
 end;
end;


end.
