set Eras;
set CartasEraI;
set CartasEraII;
set CartasEraIII;
set Turnos;
set TiposDeCosto;
set TiposDeEspecialidad;

#set TiposDeCosto := MON CEM TEL CER PAP MAD LAD ORO;
#set TiposDeEspecialidad := 'CEM' 'TEL' 'CER' 'PAP' 'MAD' 'LAD' 'ORO' 'PTO' 'SIM';

var Ype{i in CartasEraI, j in Turnos} >= 0, binary;
var Yse{i in CartasEraII, j in Turnos} >= 0, binary;
var Yte{i in CartasEraIII, j in Turnos} >= 0, binary;

#Monedas
var monedasDisponibles{i in Eras, j in Turnos} >= 0, integer;
var gastoMonedas{i in Eras, j in Turnos} >= 0, integer;

#Cemento
var cementosDisponibles{i in Eras, j in Turnos} >= 0, integer;

#Puntos
var puntosMonedas >= 0, integer;
var PuntosSimbolosIguales >= 0, integer;

#Simbolos
var Geometricas >= 0, integer;
var Ruedas >= 0, integer;
var Escrituras >= 0, integer;

param PuntosCartasEraI{i in CartasEraI};
param PuntosCartasEraII{i in CartasEraII};
param PuntosCartasEraIII{i in CartasEraIII};

#Costos por Era:
param CostosEraI{i in CartasEraI, j in TiposDeCosto};
param CostosEraII{i in CartasEraII, j in TiposDeCosto};
param CostosEraIII{i in CartasEraIII, j in TiposDeCosto};

#Especialidades por Era:
param EspecialidadesEraI{i in CartasEraI, j in TiposDeEspecialidad};
param EspecialidadesEraII{i in CartasEraII, j in TiposDeEspecialidad};
param EspecialidadesEraIII{i in CartasEraIII, j in TiposDeEspecialidad};


maximize z: sum{i in CartasEraI, j in Turnos}EspecialidadesEraI[i, 'PTO']*Ype[i,j] +
			sum{i in CartasEraII, j in Turnos}EspecialidadesEraII[i, 'PTO']*Yse[i,j] +
			sum{i in CartasEraIII, j in Turnos}EspecialidadesEraIII[i, 'PTO']*Yte[i,j];

#ERA I:
#TURNO 1:
s.t. monedasIniciales: monedasDisponibles[1,1] = 3;
s.t. cementoInicial: cementosDisponibles[1,1] = 0;
s.t. eleccionCartaE1T1: sum{i in CartasEraI}Ype[i,1] = 1;
s.t. gastoMonedaE1T1: sum{i in CartasEraI}(Ype[i,1] * CostosEraI[i,'MON']) <= monedasDisponibles[1,1];
s.t. utilizacionCementoE1T1: sum{i in CartasEraI}(Ype[i,1] * CostosEraI[i,'CEM']) <= cementosDisponibles[1,1];

#TURNO 2:
s.t. mondedasE1T2: monedasDisponibles[1,2] = monedasDisponibles[1,1] - gastoMonedas[1,1];
s.t. cementoDisp: cementosDisponibles[1,2] = cementosDisponibles[1,1] + 1*Ype[2,1];
s.t. eleccionCartaE1T2: sum{i in CartasEraI, j in Turnos : j <= 2}Ype[i,j] = 2;
s.t. gastoMonedaE1T2: sum{i in CartasEraI}(Ype[i,2] * CostosEraI[i,'MON']) <= monedasDisponibles[1,2];
s.t. utilizacionCementoE1T2: sum{i in CartasEraI}(Ype[i,2] * CostosEraI[i,'CEM']) <= cementosDisponibles[1,2];

#TURNO 3:
s.t. mondedasE1T3: monedasDisponibles[1,3] = monedasDisponibles[1,2] - gastoMonedas[1,2];
s.t. eleccionCartaE1T3: sum{i in CartasEraI, j in Turnos : j <= 3}Ype[i,j] = 3;
s.t. gastoMonedaE1T3: sum{i in CartasEraI}(Ype[i,3] * CostosEraI[i,'MON']) <= monedasDisponibles[1,3];
s.t. utilizacionCementoE1T3: sum{i in CartasEraI}(Ype[i,3] * CostosEraI[i,'CEM']) <= cementosDisponibles[1,3];

#TURNO 4:
s.t. mondedasE1T4: monedasDisponibles[1,4] = monedasDisponibles[1,3] - gastoMonedas[1,3];
s.t. eleccionCartaE1T4: sum{i in CartasEraI, j in Turnos : j <= 4}Ype[i,j] = 4;
s.t. gastoMonedaE1T4: sum{i in CartasEraI}(Ype[i,4] * CostosEraI[i,'MON']) <= monedasDisponibles[1,4];
s.t. utilizacionCementoE1T4: sum{i in CartasEraI}(Ype[i,4] * CostosEraI[i,'CEM']) <= cementosDisponibles[1,4];

#TURNO 5:
s.t. mondedasE1T5: monedasDisponibles[1,5] = monedasDisponibles[1,4] - gastoMonedas[1,4];
s.t. eleccionCartaE1T5: sum{i in CartasEraI, j in Turnos : j <= 5}Ype[i,j] = 5;
s.t. gastoMonedaE1T5: sum{i in CartasEraI}(Ype[i,5] * CostosEraI[i,'MON']) <= monedasDisponibles[1,5];
s.t. utilizacionCementoE1T5: sum{i in CartasEraI}(Ype[i,5] * CostosEraI[i,'CEM']) <= cementosDisponibles[1,5];

#TURNO 6:
s.t. mondedasE1T6: monedasDisponibles[1,6] = monedasDisponibles[1,5] - gastoMonedas[1,5];
s.t. eleccionCartaE1T6: sum{i in CartasEraI, j in Turnos : j <= 6}Ype[i,j] = 6;
s.t. gastoMonedaE1T6: sum{i in CartasEraI}(Ype[i,6] * CostosEraI[i,'MON']) <= monedasDisponibles[1,6];
s.t. utilizacionCementoE1T6: sum{i in CartasEraI}(Ype[i,6] * CostosEraI[i,'CEM']) <= cementosDisponibles[1,6];

s.t. soloUnaCartaEra1{i in CartasEraI}: sum{j in Turnos}Ype[i,j] <= 1;

#ERA II:

s.t. gastoMonedaE2T{j in Turnos}: sum{i in CartasEraII}(Yse[i,j] * CostosEraII[i,'MON']) <= monedasDisponibles[2,j];
s.t. eleccionCartaE2T{k in Turnos}: sum{i in CartasEraII, j in Turnos : j <= k}Yse[i,j] = k;

#TURNO 1:
s.t. mondedasE2T1: monedasDisponibles[2,1] = monedasDisponibles[1,6] - gastoMonedas[1,6];

#TURNO 2:
s.t. mondedasE2T2: monedasDisponibles[2,2] = monedasDisponibles[2,1] - gastoMonedas[2,1];

#TURNO 3:
s.t. mondedasE2T3: monedasDisponibles[2,3] = monedasDisponibles[2,2] - gastoMonedas[2,2];

#TURNO 4:
s.t. mondedasE2T4: monedasDisponibles[2,4] = monedasDisponibles[2,3] - gastoMonedas[2,3];

#TURNO 5:
s.t. mondedasE2T5: monedasDisponibles[2,5] = monedasDisponibles[2,4] - gastoMonedas[2,4];

#TURNO 6:
s.t. mondedasE2T6: monedasDisponibles[2,6] = monedasDisponibles[2,5] - gastoMonedas[2,5];

s.t. soloUnaCartaEra2{i in CartasEraII}: sum{j in Turnos}Ype[i,j] <= 1;


#ERA III:
#TURNO 1:
s.t. mondedasE3T1: monedasDisponibles[3,1] = monedasDisponibles[2,6] - gastoMonedas[2,6];
s.t. eleccionCartaE3T1: sum{i in CartasEraIII}Yte[i,1] = 1;
s.t. gastoMonedaE3T1: sum{i in CartasEraIII}(Yte[i,1] * CostosEraIII[i,'MON']) <= monedasDisponibles[3,1];

#TURNO 2:
s.t. mondedasE3T2: monedasDisponibles[3,2] = monedasDisponibles[3,1] - gastoMonedas[3,1];
s.t. eleccionCartaE3T2: sum{i in CartasEraIII, j in Turnos : j <= 2}Yte[i,j] = 2;
s.t. gastoMonedaE3T2: sum{i in CartasEraIII}(Yte[i,2] * CostosEraIII[i,'MON']) <= monedasDisponibles[3,2];

#TURNO 3:
s.t. mondedasE3T3: monedasDisponibles[3,3] = monedasDisponibles[3,2] - gastoMonedas[3,2];
s.t. eleccionCartaE3T3: sum{i in CartasEraIII, j in Turnos : j <= 3}Yte[i,j] = 3;
s.t. gastoMonedaE3T3: sum{i in CartasEraIII}(Yte[i,3] * CostosEraIII[i,'MON']) <= monedasDisponibles[3,3];

#TURNO 4:
s.t. mondedasE3T4: monedasDisponibles[3,4] = monedasDisponibles[3,3] - gastoMonedas[3,3];
s.t. eleccionCartaE3T4: sum{i in CartasEraIII, j in Turnos : j <= 4}Yte[i,j] = 4;
s.t. gastoMonedaE3T4: sum{i in CartasEraIII}(Yte[i,4] * CostosEraIII[i,'MON']) <= monedasDisponibles[3,4];

#TURNO 5:
s.t. mondedasE3T5: monedasDisponibles[3,5] = monedasDisponibles[3,4] - gastoMonedas[3,4];
s.t. eleccionCartaE3T5: sum{i in CartasEraIII, j in Turnos : j <= 5}Yte[i,j] = 5;
s.t. gastoMonedaE3T5: sum{i in CartasEraIII}(Yte[i,5] * CostosEraIII[i,'MON']) <= monedasDisponibles[3,5];

#TURNO 6:
s.t. mondedasE3T6: monedasDisponibles[3,6] = monedasDisponibles[3,5] - gastoMonedas[3,5];
s.t. eleccionCartaE3T6: sum{i in CartasEraIII, j in Turnos : j <= 6}Yte[i,j] = 6;
s.t. gastoMonedaE3T6: sum{i in CartasEraIII}(Yte[i,6] * CostosEraIII[i,'MON']) <= monedasDisponibles[3,6];

s.t. soloUnaCartaEra3{i in CartasEraIII}: sum{j in Turnos}Ype[i,j] <= 1;


#s.t. cantGeometricas: Geometricas;
#s.t. cantGeometricas: Geometricas;
#s.t. cantGeometricas: Geometricas;

#RECOLECCION DE PUNTOS:


end; 
