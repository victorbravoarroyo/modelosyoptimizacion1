set CartasEraI;
set CartasEraII;
set CartasEraIII;
set Turnos;

var Ype{i in CartasEraI, j in Turnos} >= 0, binary;
var Yse{i in CartasEraII, j in Turnos} >= 0, binary;
var Yte{i in CartasEraIII, j in Turnos} >= 0, binary;

var Geometricas >= 0, integer;
var Ruedas >= 0, integer;
var Escrituras >= 0, integer;
var SobraPE >= 0, integer;
var SobraSE >= 0, integer;
var SobraTE >= 0, integer;
var puntosMonedas >= 0, integer;

param PuntosCartasEraI{i in CartasEraI};
param PuntosCartasEraII{i in CartasEraII};
param PuntosCartasEraIII{i in CartasEraIII};

maximize z: sum{i in CartasEraI, j in Turnos}PuntosCartasEraI[i]*Ype[i,j] +
			sum{i in CartasEraII, j in Turnos}PuntosCartasEraII[i]*Yse[i,j] +
			sum{i in CartasEraIII, j in Turnos}PuntosCartasEraIII[i]*Yte[i,j];

#maximize z: 	sum{i in CartasEraI}PuntosCartasEraI[i]*Ype[i] + 
#			sum{i in CartasEraII}PuntosCartasEraII[i]*Yse[i] +
# 			sum{i in CartasEraIII}PuntosCartasEraIII[i]*Yte[i] + 
#			Geometricas^2 + Ruedas^2 + Escitrutas^2 + puntosMonedas +
#			simbolos diferentes..... 

#s.t. cartasI: sum{i in CartasEraI}Ype[i] + SobraPE = 6;
#s.t. cartasII: sum{i in CartasEraII}Yse[i] + SobraSE = 6;
#s.t. cartasIII: sum{i in CartasEraIII}Yte[i] + SobraTE = 6;

#ERA I:
#TURNO 1:
s.t. eleccionCartaE1T1: sum{i in CartasEraI}Ype[i,1] = 1;

#TURNO 2:
s.t. eleccionCartaE1T2: sum{i in CartasEraI, j in Turnos : j <= 2}Ype[i,j] = 2;

#TURNO 3:
s.t. eleccionCartaE1T3: sum{i in CartasEraI, j in Turnos : j <= 3}Ype[i,j] = 3;

#TURNO 4:
s.t. eleccionCartaE1T4: sum{i in CartasEraI, j in Turnos : j <= 4}Ype[i,j] = 4;

#TURNO 5:
s.t. eleccionCartaE1T5: sum{i in CartasEraI, j in Turnos : j <= 5}Ype[i,j] = 5;

#TURNO 6:
s.t. eleccionCartaE1T6: sum{i in CartasEraI, j in Turnos : j <= 6}Ype[i,j] = 6;

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
s.t. eleccionCartaE2T1: sum{i in CartasEraII}Yse[i,1] = 1;

#TURNO 2:
s.t. eleccionCartaE2T2: sum{i in CartasEraII, j in Turnos : j <= 2}Yse[i,j] = 2;

#TURNO 3:
s.t. eleccionCartaE2T3: sum{i in CartasEraII, j in Turnos : j <= 3}Yse[i,j] = 3;

#TURNO 4:
s.t. eleccionCartaE2T4: sum{i in CartasEraII, j in Turnos : j <= 4}Yse[i,j] = 4;

#TURNO 5:
s.t. eleccionCartaE2T5: sum{i in CartasEraII, j in Turnos : j <= 5}Yse[i,j] = 5;

#TURNO 6:
s.t. eleccionCartaE2T6: sum{i in CartasEraII, j in Turnos : j <= 6}Yse[i,j] = 6;

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
s.t. eleccionCartaE3T1: sum{i in CartasEraIII}Yte[i,1] = 1;

#TURNO 2:
s.t. eleccionCartaE3T2: sum{i in CartasEraIII, j in Turnos : j <= 2}Yte[i,j] = 2;

#TURNO 3:
s.t. eleccionCartaE3T3: sum{i in CartasEraIII, j in Turnos : j <= 3}Yte[i,j] = 3;

#TURNO 4:
s.t. eleccionCartaE3T4: sum{i in CartasEraIII, j in Turnos : j <= 4}Yte[i,j] = 4;

#TURNO 5:
s.t. eleccionCartaE3T5: sum{i in CartasEraIII, j in Turnos : j <= 5}Yte[i,j] = 5;

#TURNO 6:
s.t. eleccionCartaE3T6: sum{i in CartasEraIII, j in Turnos : j <= 6}Yte[i,j] = 6;

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


#s.t. noUsarse: sum{i in CartasEraI, j in Turnos, k in Turnos : j>k}(Ype[i,j]-(1 - Ype[i,k])) <= 0;
#s.t. cantGeometricas: Geometricas;
#s.t. cantGeometricas: Geometricas;
#s.t. cantGeometricas: Geometricas;


end; 
