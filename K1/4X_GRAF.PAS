Program pech;

uses
	crt, graph;

Const
	N      = 20;           {�᫮ ��१��� �� ���஥ ࠧ��� ⥫�}
	_T0    = 293;          {⥬������ � 㧫�� � ��砫�� ������ �६���}
	S_     = 1;            {�����樥�� ࠧ���⭮� ��பᨬ�樨}
	dX     = 0.18 / N;     {蠣 �� ���न��� dX=S/N}
	dTau   = 10;           {蠣 �� �६���}
	_Cm    = 5.67 * 0.607; {�ਢ������ ����. �����. � ��⮤��᪮� ����}
	_Cc1   = 5.67 * 0.657; {�ਢ������ ����. �����. � ᢠ�筮� ���� 1}
	_Cc2   = 5.67 * 0.657; {�ਢ������ ����. �����. � ᢠ�筮� ���� 2}
	_Ct    = 5.67 * 0.6;   {�ਢ������ ����. �����. � ⮬��쭮� ����}
	_Tm    = 1473;         {�।��� ⥬������ ����� � ��⮤��᪮� ����}
	_Tc1   = 1623;         {�।��� ⥬������ ����� � ᢠ�筮� ���� 1 }
	_Tc2   = 1623;         {�।��� ⥬������ ����� � ᢠ�筮� ���� 2 }
	_Tt    = 1513;         {�।��� ⥬������ ����� � ⮬��쭮� ����}
	_dTk   = 45;           {������� ⥬������� ��९�� � ���� ���ॢ�}
	_Tnagr = 1473;         {�������� ⥬������ ���ॢ�}
	_dTdop = 150;          {�����⨬� ��९�� ⥬������ � ���. ����}
	_a1    = 1;            {�����樥�� �ண����}
	lamda  = 35.8;         {����. ⥯���஢������}
	_A_    = 6.39e-6;      {����. ⥬�����ய஢������}

var
	C1, C2: real;          {�ਢ������ �����樥��� ����祭�� � ��⥬�}
	Tr1, Tr2: real;
	Tuh, Tm, Tmin, Tsredn: real;
	TauM, TauC1, TauC2, TauT: real; {�६� ���ॢ� � ������ ����}
	TauN: real;
	n_, i: integer;
	T: array[0..N] of real; {���ᨢ ⥬������}
	T0_, Tmin_: array[1..5000] of real;
	temp: string[5];
	gm, gd, j: integer;

label
   1, 2;

Procedure NAGREV;
var
    B_: array[1..N] of real; {���� �⮥}
    A_: array[1..N] of real; {���� �⮥}
    A, B, F: real;
    i: integer;				 {蠣 横��}
    M2: real;
begin
	A := S_ * _A_ * dTau / sqr(dX);
	B := 2 * A + 1;
	A_[1] := _a1;
	i := 0;
	B_[1] := dX * C1 * (sqr(Tr1 / 100) * sqr(Tr1 / 100) - sqr(T[0] / 100) * sqr(T[0] / 100)) / lamda;
	repeat
		i := i + 1;
		F := T[i] + (1 - S_) * _A_ * dTau * (T[i + 1] + T[i - 1] - 2 * T[i]) / sqr(dX);
		A_[i + 1] := A / (B - A * A_[i]);
		B_[i + 1] := (A * B_[i] + F) / (B - A * A_[i]);
	until i >= N - 1;
	M2 := dX * C2 * (sqr(Tr2 / 100) * sqr(Tr2 / 100) - sqr(T[N] / 100) * sqr(T[N] / 100)) / lamda;
	T[N] := (M2 + B_[N]) / (1 - A_[N]);
	repeat
		T[i] := A_[i + 1] * T[i + 1] + B_[i + 1];
		i := i - 1;
	until i < 0;
end;

Procedure Show_Res;
var
	i: integer;
	Tau: real;
begin
	Tmin := T[0];
	for i := 0 to N do
		if T[i] < Tmin
			then Tmin := T[i];
	Tau := n_ * dTau + TauM + TauC1 + TauC2 + TauT;
	writeln('Tau = ', Tau:7:2, '  T[0] = ', T[0]:7:5, '  Tmin = ', Tmin:7:5);
end;

BEGIN
	clrscr;
	Tr1 := _Tm;
	Tr2 := _Tm;
	C1 := _Cm;
	C2 := _Cm;
	1:	for i := 0 to N do T[i] := _T0;
		n_ := 0;
		repeat
			NAGREV;
			n_ := n_ + 1;
			Tmin := T[0];
			for i := 0 to N do
				if T[i] < Tmin then Tmin := T[i];
			if Tmin >= 773 then goto 2;
		until (T[0] - Tmin) >= _dTdop;
		Tr1 := Tr1 - 10;
		Tr2 := Tr2 - 10;
		goto 1;
	2:	Tm := Tr1;
		TauM := dTau * n_;
		Tuh := sqr(Tm) / _Tc1;
		{*****************************}
		writeln('TauM = ', TauM:10:9);
		writeln('Tuh  = ', Tuh:10:9);
		writeln('Tm   = ', Tm:10:9);
		{*****************************}
		readln;
		for i := 0 to N do T[i] := _T0;
		TauM := 0;
		TauC1 := 0;
		TauC2 := 0;
		TauT := 0;
		j := 1;
		{��⮤��᪠� ����}
		n_ := 0;
		Tr1 := Tm;
		Tr2 := Tm;
		C1 := _Cm;
		C2 := _Cm;
		Repeat
			NAGREV;
			T0_[j] := T[0];
			Tmin_[j] := Tmin;
			inc(j);
			inc(n_);
			Show_Res;
		Until Tmin >= 773;
		TauM := n_ * dTau;
		{����筠� ���� 1}
		n_ := 0;
		Tr1 := _Tc1;
		Tr2 := _Tc1;
		C1 := _Cc1;
		C2 := _Cc1;
		Repeat
			NAGREV;
			T0_[j] := T[0];
			Tmin_[j] := Tmin;
			inc(j);
			inc(n_);
			Show_Res;
		Until T[0] >= _Tnagr - 200;
		TauC1 := n_ * dTau;
		{����筠� ���� 2}
		n_ := 0;
		Tsredn := 0;
		Tr1 := _Tc2;
		Tr2 := _Tc2;
		C1 := _Cc2;
		C2 := _Cc2;
		Repeat
			NAGREV;
			T0_[j] := T[0];
			Tmin_[j] := Tmin;
			inc(j);
			inc(n_);
			Show_Res;
			for i := 0 to N do Tsredn := Tsredn + T[i];
			Tsredn := Tsredn / (N + 1);
		Until Tsredn >= _Tnagr;
		TauC2 := n_ * dTau;
		{�����쭠� ����}
		n_ := 0;
		Tr1 := _Tt;
		Tr2 := _Tt;
		C1 := _Ct;
		C2 := 0;
		Repeat
			NAGREV;
			T0_[j] := T[0];
			Tmin_[j] := Tmin;
			inc(j);
			inc(n_);
			Show_Res;
		Until (T[0] - Tmin) <= _dTk;
		TauT := n_ * dTau;
		TauN := TauM + TauC1 + TauC2 + TauT;
		writeln('**********************************');
		writeln('TauN  = ', TauN:7:2);
		writeln('TauM  = ', TauM:7:2);
		writeln('TauC1 = ', TauC1:7:2);
		writeln('TauC2 = ', TauC2:7:2);
		writeln('TauT  = ', TauT:7:2);
		writeln('T��   = ', Tuh:7:5);
		writeln('Tm    = ', Tm:7:5);
		if abs(T[0] - _Tnagr) > 5
		then
			begin
				writeln('����� �� 㤮���⢮��� �������� �筮��, ����室���');
				writeln('�������� ⥬������� ⮬��쭮� ����.');
			end;
		readln;
		clrscr;
		initgraph(gd, gm, 'd:\tp-7\bgi');
		j := j - 1;
		if GraphResult = 0
		then
			begin
				line(100, 410, 100, 10);
				line(100, 410, 600, 410);
				outtextxy(10, 10, 'T,K');
				outtextxy(601, 406, 't,c');
				for i := 0 to round(j * dTau / 1000) do
				begin
					line(100 + round(i * 500 / (j * dTau / 1000)), 408, 100 + round(i * 500 / (j * dTau / 1000)), 412);
					str(i * 1000:5, temp);
					settextstyle(0, 1, 0);
					outtextxy(104 + round(i * 500 / (j * dTau / 1000)), 420, temp);
				end;
				settextstyle(0,0,0);
				for i := 1 to 17 do
				begin
					setlinestyle(0, 0, 0);
					line(98, 408 - round(i * 23.3), 102, 408 - round(i * 23.3));
					setlinestyle(2, 0, 0);
					line(104, 408 - round(i * 23.3), 600, 408 - round(i * 23.3));
					str(i * 100:5, temp);
					outtextxy(55, 404 - round(i * 23.3), temp);
				end;
				setlinestyle(2, 0, 3);
				line(round(100 + (500 / j) * (0 / dTau)), round(410 - 400 * Tuh / 1700),
					round(100 + (500 / j) * (TauM / dTau)), round(410 - 400 * _TC1 / 1700));
				setlinestyle(0, 0, 3);
				line(round(100 + (500 / j) * (0 / dTau)), round(410 - 400 * Tm / 1700),
					round(100 + (500 / j) * (TauM / dTau)), round(410 - 400 * Tm / 1700));
				line(round(100 + (500 / j) * (TauM / dTau)), round(410 - 400 * Tm / 1700),
					round(100 + (500 / j) * (TauM / dTau)), round(410 - 400 * _TC1 / 1700));
				line(round(100 + (500 / j) * (TauM / dTau)), round(410 - 400 * _TC1 / 1700),
					round(100 + (500 / j) * ((TauM + TauC1) / dTau)), round(410 - 400 * _TC1 / 1700));
				LINE(round(100 + (500 / j) * ((TauM + TauC1) / dTau)), round(410 - 400 * _TC1 / 1700),
					round(100 + (500 / j) * ((TauM + TauC1) / dTau)), round(410 - 400 * _TC2 / 1700));
				line(round(100 + (500 / j) * ((TauM + TauC1) / dTau)), round(410 - 400 * _TC2 / 1700),
					round(100 + (500 / j) * ((TauM + TauC1 + TauC2) / dTau)),
					round(410 - 400 * _TC2 / 1700));
				line(round(100 + (500 / j) * ((TauM + TauC1 + TauC2) / dTau)),
					round(410 - 400 * _TC2 / 1700),
					round(100 + (500 / j) * ((TauM + TauC1 + TauC2) / dTau)), round(410 - 400 * _Tt / 1700));
				line(round(100 + (500 / j) * ((TauM + TauC1 + TauC2) / dTau)), round(410 - 400 * _Tt / 1700),
					round(100 + (500 / j) * ((TauM + TauC1 + TauC2 + TauT) / dTau)),
					round(410 - 400 * _Tt / 1700));
				setlinestyle(0, 0, 3);
				for i := 3 to j do
				begin
					line(round(100 + 500 / j * i), round(410 - 400 * T0_[i - 1] / 1700),
						round(100 + 500 / j * i), round(410 - 400 * T0_[i] / 1700));
					line(round(100 + 500 / j * i), round(410 - 400 * Tmin_[i - 1] / 1700),
						round(100 + 500 / j * i), round(410 - 400 * Tmin_[i] / 1700));
					line(round(100 + 500 / j * i), round(410 - 400 * (T0_[i - 1] - Tmin_[i - 1]) / 1700),
						round(100 + 500 / j * i), round(410 - 400 * (T0_[i] - Tmin_[i]) / 1700));
				end;
				readln;
				closeGraph;
			end;
END.
