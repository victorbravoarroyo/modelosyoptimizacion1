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

s.t. soloUnaCarta1E1: sum{j in Turnos}Ype[1,j] <= 1;
s.t. soloUnaCarta2E1: sum{j in Turnos}Ype[2,j] <= 1;
s.t. soloUnaCarta3E1: sum{j in Turnos}Ype[3,j] <= 1;
s.t. soloUnaCarta4E1: sum{j in Turnos}Ype[4,j] <= 1;
s.t. soloUnaCarta5E1: sum{j in Turnos}Ype[5,j] <= 1;
s.t. soloUnaCarta6E1: sum{j in Turnos}Ype[6,j] <= 1;
s.t. soloUnaCarta7E1: sum{j in Turnos}Ype[7,j] <= 1;
s.t. soloUnaCarta8E1: sum{j in Turnos}Ype[8,j] <= 1;
s.t. soloUnaCarta9E1: sum{j in Turnos}Ype[9,j] <= 1;
s.t. soloUnaCarta10E1: sum{j in Turnos}Ype[10,j] <= 1;
s.t. soloUnaCarta11E1: sum{j in Turnos}Ype[11,j] <= 1;
s.t. soloUnaCarta12E1: sum{j in Turnos}Ype[12,j] <= 1;
s.t. soloUnaCarta13E1: sum{j in Turnos}Ype[13,j] <= 1;
s.t. soloUnaCarta14E1: sum{j in Turnos}Ype[14,j] <= 1;
s.t. soloUnaCarta15E1: sum{j in Turnos}Ype[15,j] <= 1;
s.t. soloUnaCarta16E1: sum{j in Turnos}Ype[16,j] <= 1;
s.t. soloUnaCarta17E1: sum{j in Turnos}Ype[17,j] <= 1;
s.t. soloUnaCarta18E1: sum{j in Turnos}Ype[18,j] <= 1;
s.t. soloUnaCarta19E1: sum{j in Turnos}Ype[19,j] <= 1;
s.t. soloUnaCarta20E1: sum{j in Turnos}Ype[20,j] <= 1;
s.t. soloUnaCarta21E1: sum{j in Turnos}Ype[21,j] <= 1;
s.t. soloUnaCarta22E1: sum{j in Turnos}Ype[22,j] <= 1;
s.t. soloUnaCarta23E1: sum{j in Turnos}Ype[23,j] <= 1;
s.t. soloUnaCarta24E1: sum{j in Turnos}Ype[24,j] <= 1;


#ERA II:
#TURNO 1:
s.t. mondedasE2T1: monedasDisponibles[2,1] = monedasDisponibles[1,6] - gastoMonedas[1,6];
s.t. eleccionCartaE2T1: sum{i in CartasEraII}Yse[i,1] = 1;
s.t. gastoMonedaE2T1: sum{i in CartasEraII}(Yse[i,1] * CostosEraII[i,'MON']) <= monedasDisponibles[2,1];

#TURNO 2:
s.t. mondedasE2T2: monedasDisponibles[2,2] = monedasDisponibles[2,1] - gastoMonedas[2,1];
s.t. eleccionCartaE2T2: sum{i in CartasEraII, j in Turnos : j <= 2}Yse[i,j] = 2;
s.t. gastoMonedaE2T2: sum{i in CartasEraII}(Yse[i,2] * CostosEraII[i,'MON']) <= monedasDisponibles[2,2];

#TURNO 3:
s.t. mondedasE2T3: monedasDisponibles[2,3] = monedasDisponibles[2,2] - gastoMonedas[2,2];
s.t. eleccionCartaE2T3: sum{i in CartasEraII, j in Turnos : j <= 3}Yse[i,j] = 3;
s.t. gastoMonedaE2T3: sum{i in CartasEraII}(Yse[i,3] * CostosEraII[i,'MON']) <= monedasDisponibles[2,3];

#TURNO 4:
s.t. mondedasE2T4: monedasDisponibles[2,4] = monedasDisponibles[2,3] - gastoMonedas[2,3];
s.t. eleccionCartaE2T4: sum{i in CartasEraII, j in Turnos : j <= 4}Yse[i,j] = 4;
s.t. gastoMonedaE2T4: sum{i in CartasEraII}(Yse[i,4] * CostosEraII[i,'MON']) <= monedasDisponibles[2,4];

#TURNO 5:
s.t. mondedasE2T5: monedasDisponibles[2,5] = monedasDisponibles[2,4] - gastoMonedas[2,4];
s.t. eleccionCartaE2T5: sum{i in CartasEraII, j in Turnos : j <= 5}Yse[i,j] = 5;
s.t. gastoMonedaE2T5: sum{i in CartasEraII}(Yse[i,5] * CostosEraII[i,'MON']) <= monedasDisponibles[2,5];

#TURNO 6:
s.t. mondedasE2T6: monedasDisponibles[2,6] = monedasDisponibles[2,5] - gastoMonedas[2,5];
s.t. eleccionCartaE2T6: sum{i in CartasEraII, j in Turnos : j <= 6}Yse[i,j] = 6;
s.t. gastoMonedaE2T6: sum{i in CartasEraII}(Yse[i,6] * CostosEraII[i,'MON']) <= monedasDisponibles[2,6];

s.t. soloUnaCarta1E2: sum{j in Turnos}Yse[1,j] <= 1;
s.t. soloUnaCarta2E2: sum{j in Turnos}Yse[2,j] <= 1;
s.t. soloUnaCarta3E2: sum{j in Turnos}Yse[3,j] <= 1;
s.t. soloUnaCarta4E2: sum{j in Turnos}Yse[4,j] <= 1;
s.t. soloUnaCarta5E2: sum{j in Turnos}Yse[5,j] <= 1;
s.t. soloUnaCarta6E2: sum{j in Turnos}Yse[6,j] <= 1;
s.t. soloUnaCarta7E2: sum{j in Turnos}Yse[7,j] <= 1;
s.t. soloUnaCarta8E2: sum{j in Turnos}Yse[8,j] <= 1;
s.t. soloUnaCarta9E2: sum{j in Turnos}Yse[9,j] <= 1;
s.t. soloUnaCarta10E2: sum{j in Turnos}Yse[10,j] <= 1;
s.t. soloUnaCarta11E2: sum{j in Turnos}Yse[11,j] <= 1;
s.t. soloUnaCarta12E2: sum{j in Turnos}Yse[12,j] <= 1;
s.t. soloUnaCarta13E2: sum{j in Turnos}Yse[13,j] <= 1;
s.t. soloUnaCarta14E2: sum{j in Turnos}Yse[14,j] <= 1;
s.t. soloUnaCarta15E2: sum{j in Turnos}Yse[15,j] <= 1;
s.t. soloUnaCarta16E2: sum{j in Turnos}Yse[16,j] <= 1;
s.t. soloUnaCarta17E2: sum{j in Turnos}Yse[17,j] <= 1;
s.t. soloUnaCarta18E2: sum{j in Turnos}Yse[18,j] <= 1;
s.t. soloUnaCarta19E2: sum{j in Turnos}Yse[19,j] <= 1;
s.t. soloUnaCarta20E2: sum{j in Turnos}Yse[20,j] <= 1;
s.t. soloUnaCarta21E2: sum{j in Turnos}Yse[21,j] <= 1;


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

s.t. soloUnaCarta1E3: sum{j in Turnos}Yte[1,j] <= 1;
s.t. soloUnaCarta2E3: sum{j in Turnos}Yte[2,j] <= 1;
s.t. soloUnaCarta3E3: sum{j in Turnos}Yte[3,j] <= 1;
s.t. soloUnaCarta4E3: sum{j in Turnos}Yte[4,j] <= 1;
s.t. soloUnaCarta5E3: sum{j in Turnos}Yte[5,j] <= 1;
s.t. soloUnaCarta6E3: sum{j in Turnos}Yte[6,j] <= 1;
s.t. soloUnaCarta7E3: sum{j in Turnos}Yte[7,j] <= 1;
s.t. soloUnaCarta8E3: sum{j in Turnos}Yte[8,j] <= 1;
s.t. soloUnaCarta9E3: sum{j in Turnos}Yte[9,j] <= 1;
s.t. soloUnaCarta10E3: sum{j in Turnos}Yte[10,j] <= 1;
s.t. soloUnaCarta11E3: sum{j in Turnos}Yte[11,j] <= 1;
s.t. soloUnaCarta12E3: sum{j in Turnos}Yte[12,j] <= 1;
s.t. soloUnaCarta13E3: sum{j in Turnos}Yte[13,j] <= 1;
s.t. soloUnaCarta14E3: sum{j in Turnos}Yte[14,j] <= 1;
s.t. soloUnaCarta15E3: sum{j in Turnos}Yte[15,j] <= 1;
s.t. soloUnaCarta16E3: sum{j in Turnos}Yte[16,j] <= 1;
s.t. soloUnaCarta17E3: sum{j in Turnos}Yte[17,j] <= 1;

#s.t. cantGeometricas: Geometricas;
#s.t. cantGeometricas: Geometricas;
#s.t. cantGeometricas: Geometricas;

#RECOLECCION DE PUNTOS:


end; 
