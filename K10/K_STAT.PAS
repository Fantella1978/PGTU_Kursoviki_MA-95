Program K_STAT;

uses crt;

var
 G_izv  :real; {���� ������, �                         }
 G_ph   :real; {���� ����������� 诠�, �               }
 G_c    :real; {���� ��㭠, �                          }
 G_r    :real; {���� �������� p��, �                   }
 G_l    :real; {���� ����, �                            }
 G_st   :real; {���� �⠫�, �                           }
 V_o2   :real; {������⢮ ��᫮p��� �� ������, �3       }
 _O2_d  :real; {����� �孨�᪮�� ��᫮p���, %        }
 _Si_c  :real; {����p����� �p����� � ��㭥, %           }
 _Mn_c  :real; {����p����� ��p���� � ��㭥, %          }
 _P_c   :real; {ᮤ�p����� ���p� � ��㭥, %           }
 _C_c   :real; {����p����� 㣫�p��� � ��㭥, %          }
 _Mn_st :real; {����p����� ��p���� � �⠫�, %           }
 _P_st  :real; {����p����� ���p� � �⠫�, %            }
 _C_st  :real; {����p����� 㣫�p��� � �⠫�, %           }
 T_c    :real; {�����p���p� ��㭠, �                    }
 T_st   :real; {�����p���p� �⠫�, �                     }
 Fe2o3_r:real; {����p����� Fe2o3 � p㤥, %               }
 Feo_r  :real; {����p����� Feo � p㤥, %                 }
 _SiO2_r:real; {����p����� �p�������� � �������� p㤥, % }
 _CaO   :real; {ᮤ�p����� ��� � ������, %              }
 B      :real; {�᭮������ 諠��                         }
 Gama   :real; {�⥯��� �᢮���� ������ 諠���          }
 Qp     :real; {���p� ⥯�� �p�� ���p����, ����       }
 L      :real; {������⢮ ���᢮������ ��᫮p���, �3    }

Const
 dFe =3.5    ; {������⢮ ���᫥�襣��� ������, %       }

 mas1:array[1..21]of string[40]=
    ('���� ����������� 诠�',
     '���� ��㭠',
     '���� ����',
     '����� �孨�᪮�� ��᫮p���',
     '����p����� �p����� � ��㭥',
     '����p����� ��p���� � ��㭥',
     'C���p����� ���p� � ��㭥',
     '����p����� 㣫�p��� � ��㭥',
     '����p����� ��p���� � �⠫�',
     '����p����� ���p� � �⠫�',
     '����p����� 㣫�p��� � �⠫�',
     '�����p���p� ��㭠',
     '�����p���p� �⠫�',
     '����p����� Fe2o3 � p㤥',
     '����p����� Feo � p㤥',
     '����p����� �p�������� � �������� p㤥',
     'C���p����� ��� � ������',
     'O᭮������ 諠��',
     'C⥯��� �᢮���� ������ 諠���',
     '���p� ⥯�� �p�� ���p����',
     'K�����⢮ ���᢮������ ��᫮p���');

 mas2:array[1..21]of string[4]=('�','�','�',
    '%','%','%','%','%','%','%','%','�','�','%','%',
    '%','%',' ',' ','����','�3');

var
  delta_1,delta_2,delta_3,delta:real;
  a1,a2,a3,a4:real;
  b1,b2,b3,b4:real;
  c1,c2,c3,c4:real;
  AA,BB,CC,DD,EE,FF,GG:real; {�p������ ��p������}
  menu:integer;
  mas3:array[1..21] of real;

Procedure Calculate;
begin
 AA:=298*T_st+50000;
 BB:=(15500+200*T_st+27310*_C_st+16730*_Mn_st+75220*_P_st-
     3.27*_C_st*(T_c+T_st))/(100-_C_st-_Mn_st-_P_st);
 CC:=0.7*Fe2o3_r+0.778*Feo_r;
 DD:=1+0.0035*Fe2o3_r;
 EE:=(0.06*_C_st+0.0351*_P_st)/(100-_C_st-_Mn_st-_P_st);
 FF:=(9.33*_C_st+2.04*_Mn_st+9.03*_P_st)/(100-_C_st-_Mn_st-_P_st);
 GG:=G_c*(95-_C_c-_Si_c-_Mn_c-_P_c-dFe);
 a2:=0;
 c1:=0;
 c2:=1;
 c3:=-_SiO2_r*(B/(Gama*_CaO));
 c4:=2.143*G_c*_Si_c*(B/(Gama*_CaO));
 b1:=AA*0.00643*_O2_d/100;
 b2:=AA;
 b3:=12300*Fe2o3_r+8940*Feo_r+BB*CC+AA*DD-AA*EE*CC;
 b4:=G_c*(26000+200*T_c+27310*_C_c+73820*_Si_c+16730*_Mn_c+75220*_P_c+
     11520*dFe-3.27*_C_c*(T_c+T_st))-G_l*(15500+200*T_st)-
     BB*GG-0.21*L*(T_c+T_st)-
     AA*(G_ph-0.00643*L-G_c*(0.06*_C_c+0.03*_Si_c+0.0351*_P_c)-
     EE*GG)+6040*L-Qp;
 a1:=_O2_d/100;
 a3:=FF*CC+2.1*Fe2o3_r+1.55*Feo_r;
 a4:=G_c*(9.33*_C_c+8*_Si_c+2.04*_Mn_c+9.03*_P_c+2*dFe)-
     FF*GG+L;
 delta  :=a1*b2*c3+a3*b1*c2+a2*b3*c1-a3*b2*c1-a1*c2*b3-b1*a2*c3;
 delta_1:=a4*b2*c3+a3*b4*c2+a2*b3*c4-a3*b2*c4-a4*c2*b3-b4*a2*c3;
 delta_2:=a1*b4*c3+a3*b1*c4+a4*b3*c1-a3*b4*c1-a1*c4*b3-b1*a4*c3;
 delta_3:=a1*b2*c4+a4*b1*c2+a2*b4*c1-a4*b2*c1-a1*c2*b4-b1*a2*c4;
 V_o2:=delta_1/delta;
 G_izv:=delta_2/delta;
 G_r:=delta_3/delta;
 clrscr;
 writeln('�������� p���� :');
 writeln(' - ������⢮ ��᫮p��� �� ������ : ',V_o2:9:2,' �3.');
 writeln(' - ���� p�� �� ������           : ',G_r:9:2,' �.');
 writeln(' - ���� ������ �� ������        : ',G_izv:9:2,' �.');
 readln;
end;

Procedure ViewParameters;
var k:integer;
begin
 clrscr;
 for k:=1 to 21 do writeln(k:2,' - ',mas1[k],', ',mas2[k],' : ',mas3[k]:9:2);
 readln;
end;

Procedure InMas_3;
begin
 mas3[1 ]:=G_ph;    mas3[2 ]:=G_c;     mas3[3 ]:=G_l;
 mas3[4 ]:=_O2_d;   mas3[5 ]:=_Si_c;
 mas3[6 ]:=_Mn_c;   mas3[7 ]:=_P_c;    mas3[8 ]:=_C_c;
 mas3[9 ]:=_Mn_st;  mas3[10]:=_P_st;   mas3[11]:=_C_st;
 mas3[12]:=T_c;     mas3[13]:=T_st;    mas3[14]:=Fe2o3_r;
 mas3[15]:=Feo_r;   mas3[16]:=_SiO2_r; mas3[17]:=_CaO;
 mas3[18]:=B;       mas3[19]:=Gama;    mas3[20]:=Qp;
 mas3[21]:=L;
end;

Procedure OutMas_3;
begin
 G_ph:=mas3[1 ];    G_c:=mas3[2 ];     G_l:=mas3[3 ];
 _O2_d:=mas3[4 ];   _Si_c:=mas3[5 ];
 _Mn_c:=mas3[6 ];   _P_c:=mas3[7 ];    _C_c:=mas3[8 ];
 _Mn_st:=mas3[9 ];  _P_st:=mas3[10];   _C_st:=mas3[11];
 T_c:=mas3[12];     T_st:=mas3[13];    Fe2o3_r:=mas3[14];
 Feo_r:=mas3[15];   _SiO2_r:=mas3[16]; _CaO:=mas3[17];
 B:=mas3[18];       Gama:=mas3[19];    Qp:=mas3[20];
 L:=mas3[21];
end;

Procedure ChangeParameters;
var ch_menu,k:integer;
begin
 clrscr;
 Writeln('������ ����p ��p����p� ��� ���������.');
 for k:=1  to 21 do writeln('  ',k:2,' - ',mas1[k]);
 read(ch_menu);
 if ch_menu in [1..25] then
  begin
   clrscr;
   writeln('������:');
   write(mas1[ch_menu],', ',mas2[ch_menu],' (',mas3[ch_menu]:9:2,'):');
   readln(mas3[ch_menu]);
  end;
 OutMas_3;
end;

BEGIN
 { ���祭�� ��p����p�� �� 㬮�砭��}
 G_ph:=0.3;    G_c:=100;    G_l:=30;
 _Si_c:=0.7;   _Mn_c:=0.8;  _P_c:=0.1;
 _C_c:=4.4;    _Mn_st:=0.06 ;  _P_st:=0.08;
 _C_st:=0.08;  Fe2o3_r:=87; Feo_r:=1.2;
 B:=0.9;       _CaO:=85;    _SiO2_r:=10;
 _O2_d:=99.5;  T_c:=1300;   T_st:=1630;
 Qp:=3.5e+6;   Gama:=0.82;  L:=600;
 InMas_3;
 repeat
   clrscr;
   writeln('�롥p�� �⠯ :');
   writeln(' 1 - �p�ᬮ�p ���祭�� ��p����p�� ;');
   writeln(' 2 - ��������� ���祭�� ��p����p�� ;');
   writeln(' 3 - p���� ��p����p��;');
   writeln(' 0 - ��室');
   readln(menu);
   case menu of
    1:ViewParameters;
    2:ChangeParameters;
    3:Calculate;
   end;
 until menu=0;
END.