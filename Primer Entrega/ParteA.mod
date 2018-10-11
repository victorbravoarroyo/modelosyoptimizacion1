set Eras;
set CartasEraI;
set CartasEraII;
set CartasEraIII;
set Turnos;
set TiposDeCosto;
set TiposDeEspecialidad;
set MateriaPrima;
set ProductosManufacturados;

set ModoDeCarta;

#set TiposDeCosto := MON CEM TEL CER PAP MAD LAD ORO;
#set TiposDeEspecialidad := 'CEM' 'TEL' 'CER' 'PAP' 'MAD' 'LAD' 'ORO' 'PTO' 'GEO' 'RUE' 'ESC';

var Ype{i in CartasEraI, j in Turnos, k in ModoDeCarta} >= 0, binary;
var Yse{i in CartasEraII, j in Turnos, k in ModoDeCarta} >= 0, binary;
var Yte{i in CartasEraIII, j in Turnos, k in ModoDeCarta} >= 0, binary;

#Monedas
var monedasDisponibles{i in Eras, j in Turnos} >= 0, integer;
var gastoMonedas{i in Eras, j in Turnos} >= 0, integer;

#Recursos
var recursosDisponibles{i in Eras, j in Turnos, k in TiposDeCosto: k<>'MON'} >= 0, integer;
var recursosComprados{i in Eras, j in Turnos, k in TiposDeCosto: k<>'MON'} >= 0, integer;
var recursosRealizados{i in Eras, j in Turnos, k in TiposDeCosto: k<>'MON'} >= 0, integer;

#Puntos
var puntosMonedas >= 0, integer;
var PuntosSimbolosIguales >= 0, integer;

#Simbolos
var Geometricas >= 0, integer;
var Ruedas >= 0, integer;
var Escrituras >= 0, integer;

#Costos por Era:
param CostosEraI{i in CartasEraI, j in TiposDeCosto};
param CostosEraII{i in CartasEraII, j in TiposDeCosto};
param CostosEraIII{i in CartasEraIII, j in TiposDeCosto};

#Especialidades por Era:
param EspecialidadesEraI{i in CartasEraI, j in TiposDeEspecialidad};
param EspecialidadesEraII{i in CartasEraII, j in TiposDeEspecialidad};
param EspecialidadesEraIII{i in CartasEraIII, j in TiposDeEspecialidad};


maximize z: sum{i in CartasEraI, j in Turnos}EspecialidadesEraI[i,'PTO']*Ype[i,j,'NOR'] +
			sum{i in CartasEraII, j in Turnos}EspecialidadesEraII[i,'PTO']*Yse[i,j,'NOR'];# +
#			sum{i in CartasEraIII, j in Turnos}EspecialidadesEraIII[i, 'PTO']*Yte[i,j,'NOR'];

#ERA I:
s.t. eleccionCartaE1T{j in Turnos}: sum{i in CartasEraI, k in ModoDeCarta}Ype[i,j,k] = 1; #SOLO UNA CARTA POR TURNO
s.t. soloUnaCartaEra1{i in CartasEraI}: sum{j in Turnos,k in ModoDeCarta}Ype[i,j,k] <= 1; #SOLO UNA CARTA DE ESE TIPO POR ERA o NINGUNA
s.t. utilizMonedas{i in CartasEraI, j in Turnos}: CostosEraI[i,'MON']*Ype[i,j,'NOR'] <= monedasDisponibles[1,j]; #CALCULO POR TURNO DE POSIBIL.
s.t. monedasUsadasE1T{i in CartasEraI, j in Turnos}: gastoMonedas[1,j] = CostosEraI[i,'MON']*Ype[i,j,'NOR']; #CALCULO DE MONEDAS USADAS


#TURNO 1:
s.t. monedasIniciales: monedasDisponibles[1,1] = 3;
s.t. dispRecursosIniciales{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[1,1,k] = 0;
s.t. utilizRec{i in CartasEraI, k in TiposDeCosto: k<>'MON'}: CostosEraI[i,k]*Ype[i,1,'NOR'] <= recursosDisponibles[1,1,k] + recursosComprados[1,1,k]; 


#desarrollar maravillas..................


#TURNO 2:
s.t. dispRecE1T2{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[1,2,k] = recursosDisponibles[1,1,k] + sum{i in CartasEraI}(EspecialidadesEraI[i,k]*Ype[i,1,'NOR']);
s.t. utilizRecE1T2{i in CartasEraI, k in TiposDeCosto: k<>'MON'}: CostosEraI[i,k]*Ype[i,2,'NOR'] <= recursosDisponibles[1,2,k] + recursosComprados[1,2,k]; 
s.t. monedasDisponiblesE1T2: monedasDisponibles[1,2] = monedasDisponibles[1,1] - gastoMonedas[1,1] + sum{i in CartasEraI: i >= 19}3*Ype[i,1,'NOR'];

#TURNO 3:
s.t. dispRecE1T3{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[1,3,k] = recursosDisponibles[1,2,k] + sum{i in CartasEraI}(EspecialidadesEraI[i,k]*Ype[i,2,'NOR']);
s.t. utilizRecE1T3{i in CartasEraI, k in TiposDeCosto: k<>'MON'}: CostosEraI[i,k]*Ype[i,3,'NOR'] <= recursosDisponibles[1,3,k] + recursosComprados[1,3,k];
s.t. monedasDisponiblesE1T3: monedasDisponibles[1,3] = monedasDisponibles[1,2] - gastoMonedas[1,2] + sum{i in CartasEraI: i >= 19}3*Ype[i,2,'NOR'];

#TURNO 4:
s.t. dispRecE1T4{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[1,4,k] = recursosDisponibles[1,3,k] + sum{i in CartasEraI}(EspecialidadesEraI[i,k]*Ype[i,3,'NOR']);
s.t. utilizRecE1T4{i in CartasEraI, k in TiposDeCosto: k<>'MON'}: CostosEraI[i,k]*Ype[i,4,'NOR'] <= recursosDisponibles[1,4,k] + recursosComprados[1,4,k];
s.t. monedasDisponiblesE1T4: monedasDisponibles[1,4] = monedasDisponibles[1,3] - gastoMonedas[1,3] + sum{i in CartasEraI: i >= 19}3*Ype[i,3,'NOR'];


#TURNO 5:
s.t. dispRecE1T5{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[1,5,k] = recursosDisponibles[1,4,k] + sum{i in CartasEraI}(EspecialidadesEraI[i,k]*Ype[i,4,'NOR']);
s.t. utilizRecE1T5{i in CartasEraI, k in TiposDeCosto: k<>'MON'}: CostosEraI[i,k]*Ype[i,5,'NOR'] <= recursosDisponibles[1,5,k] + recursosComprados[1,5,k];
s.t. monedasDisponiblesE1T5: monedasDisponibles[1,5] = monedasDisponibles[1,4] - gastoMonedas[1,4] + sum{i in CartasEraI: i >= 19}3*Ype[i,4,'NOR'];


#TURNO 6:
s.t. dispRecE1T6{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[1,6,k] = recursosDisponibles[1,5,k] + sum{i in CartasEraI}(EspecialidadesEraI[i,k]*Ype[i,5,'NOR']);
s.t. utilizRecE1T6{i in CartasEraI, k in TiposDeCosto: k<>'MON'}: CostosEraI[i,k]*Ype[i,6,'NOR'] <= recursosDisponibles[1,6,k] + recursosComprados[1,6,k];
s.t. monedasDisponiblesE1T6: monedasDisponibles[1,6] = monedasDisponibles[1,5] - gastoMonedas[1,5] + sum{i in CartasEraI: i >= 19}3*Ype[i,5,'NOR'];



#ERA II:
s.t. eleccionCartaE2T{j in Turnos}: sum{i in CartasEraII, k in ModoDeCarta}Yse[i,j,k] = 1; #SOLO UNA CARTA POR TURNO
s.t. soloUnaCartaEra2{i in CartasEraII}: sum{j in Turnos,k in ModoDeCarta}Yse[i,j,k] <= 1; #SOLO UNA CARTA DE ESE TIPO POR ERA o NINGUNA
s.t. utilizMonedasE2{i in CartasEraII, j in Turnos}: CostosEraII[i,'MON']*Yse[i,j,'NOR'] <= monedasDisponibles[2,j]; #CALCULO POR TURNO DE POSIBIL.
s.t. monedasUsadasE2T{i in CartasEraII, j in Turnos}: gastoMonedas[2,j] = CostosEraII[i,'MON']*Yse[i,j,'NOR']; #CALCULO DE MONEDAS USADAS

s.t. utilizRecE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[13,k]*Yse[13,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k];

s.t. AqueductE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[8,k]*Yse[8,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[13,i,'NOR']; #GASTO DE AQUEDUCT

s.t. TempleE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[9,k]*Yse[9,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[12,i,'NOR']; #GASTO DE TEMPLE

s.t. StatueE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[10,k]*Yse[10,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[15,i,'NOR']; #GASTO DE STATUE

s.t. CourthouseE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[11,k]*Yse[11,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[18,i,'NOR']; #GASTO DE COURTHOUSE

s.t. DispensaryE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[12,k]*Yse[12,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[16,i,'NOR']; #GASTO DE DISPENSARY

s.t. LaboratoryE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[14,k]*Yse[14,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[17,i,'NOR']; #GASTO DE LABORATORY

s.t. LibraryE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[15,k]*Yse[15,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[18,i,'NOR']; #GASTO DE LIBRARY

#TURNO 1:
s.t. dispRecE2T1{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[2,1,k] = recursosDisponibles[1,6,k] + sum{i in CartasEraI}(EspecialidadesEraI[i,k]*Ype[i,6,'NOR']);
s.t. utilizRecE2T1{i in CartasEraII, k in TiposDeCosto: i<=7 and k<>'MON'}: CostosEraII[i,k]*Yse[i,1,'NOR'] <= recursosDisponibles[2,1,k] + recursosComprados[2,1,k]; 
s.t. monedasDisponiblesE2T1: monedasDisponibles[2,1] = monedasDisponibles[1,6] - gastoMonedas[1,6] + sum{i in CartasEraI: i >= 19}3*Ype[i,6,'NOR'];


#desarrollar maravillas..................


#TURNO 2:
s.t. dispRecE2T2{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[2,2,k] = recursosDisponibles[2,1,k] + sum{i in CartasEraII}(EspecialidadesEraII[i,k]*Yse[i,1,'NOR']);
s.t. utilizRecE2T2{i in CartasEraII, k in TiposDeCosto: i<=7 and k<>'MON'}: CostosEraII[i,k]*Yse[i,2,'NOR'] <= recursosDisponibles[2,2,k] + recursosComprados[2,2,k]; 
s.t. monedasDisponiblesE2T2: monedasDisponibles[2,2] = monedasDisponibles[2,1] - gastoMonedas[2,1] + sum{i in CartasEraII: i >= 16}3*Yse[i,1,'NOR'];
 

#TURNO 3:
s.t. dispRecE2T3{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[2,3,k] = recursosDisponibles[2,2,k] + sum{i in CartasEraII}(EspecialidadesEraII[i,k]*Yse[i,2,'NOR']);
s.t. utilizRecE2T3{i in CartasEraII, k in TiposDeCosto: i<=7 and k<>'MON'}: CostosEraII[i,k]*Yse[i,3,'NOR'] <= recursosDisponibles[2,3,k] + recursosComprados[2,3,k];
s.t. monedasDisponiblesE2T3: monedasDisponibles[2,3] = monedasDisponibles[2,2] - gastoMonedas[2,2] + sum{i in CartasEraII: i >= 16}3*Yse[i,2,'NOR'];

#TURNO 4:
s.t. dispRecE2T4{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[2,4,k] = recursosDisponibles[2,3,k] + sum{i in CartasEraII}(EspecialidadesEraII[i,k]*Yse[i,3,'NOR']);
s.t. utilizRecE2T4{i in CartasEraII, k in TiposDeCosto: i<=7 and k<>'MON'}: CostosEraII[i,k]*Yse[i,4,'NOR'] <= recursosDisponibles[2,4,k] + recursosComprados[2,4,k];
s.t. monedasDisponiblesE2T4: monedasDisponibles[2,4] = monedasDisponibles[2,3] - gastoMonedas[2,3] + sum{i in CartasEraII: i >= 16}3*Yse[i,3,'NOR'];


#TURNO 5:
s.t. dispRecE2T5{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[2,5,k] = recursosDisponibles[2,4,k] + sum{i in CartasEraII}(EspecialidadesEraII[i,k]*Yse[i,4,'NOR']);
s.t. utilizRecE2T5{i in CartasEraII, k in TiposDeCosto: i<=7 and k<>'MON'}: CostosEraII[i,k]*Yse[i,5,'NOR'] <= recursosDisponibles[2,5,k] + recursosComprados[2,5,k];
s.t. monedasDisponiblesE2T5: monedasDisponibles[2,5] = monedasDisponibles[2,4] - gastoMonedas[2,4] + sum{i in CartasEraII: i >= 16}3*Yse[i,4,'NOR'];


#TURNO 6:
s.t. dispRecE2T6{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[2,6,k] = recursosDisponibles[2,5,k] + sum{i in CartasEraII}(EspecialidadesEraII[i,k]*Yse[i,5,'NOR']);
s.t. utilizRecE2T6{i in CartasEraII, k in TiposDeCosto: i<=7 and k<>'MON'}: CostosEraII[i,k]*Yse[i,6,'NOR'] <= recursosDisponibles[2,6,k] + recursosComprados[2,6,k];
s.t. monedasDisponiblesE2T6: monedasDisponibles[2,6] = monedasDisponibles[2,5] - gastoMonedas[2,5] + sum{i in CartasEraII: i >= 16}3*Yse[i,5,'NOR'];


#ERA III:
s.t. eleccionCartaE3T{j in Turnos}: sum{i in CartasEraIII, k in ModoDeCarta}Yte[i,j,k] = 1; #SOLO UNA CARTA POR TURNO
s.t. soloUnaCartaEra3{i in CartasEraIII}: sum{j in Turnos,k in ModoDeCarta}Yte[i,j,k] <= 1; #SOLO UNA CARTA DE ESE TIPO POR ERA o NINGUNA
s.t. utilizMonedasE3{i in CartasEraIII, j in Turnos}: CostosEraIII[i,'MON']*Yte[i,j,'NOR'] <= monedasDisponibles[3,j]; #CALCULO POR TURNO DE POSIBIL.
s.t. monedasUsadasE3T{i in CartasEraIII, j in Turnos}: gastoMonedas[3,j] = CostosEraIII[i,'MON']*Yte[i,j,'NOR']; #CALCULO DE MONEDAS USADAS


#TURNO 1:
s.t. dispRecE3T1{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[3,1,k] = recursosDisponibles[2,6,k] + sum{i in CartasEraII}(EspecialidadesEraII[i,k]*Yse[i,6,'NOR']);
s.t. utilizRecE3T1{i in CartasEraIII, k in TiposDeCosto: i<=2 and k<>'MON'}: CostosEraIII[i,k]*Yte[i,1,'NOR'] <= recursosDisponibles[3,1,k] + recursosComprados[3,1,k]; 
s.t. monedasDisponiblesE3T1: monedasDisponibles[3,1] = monedasDisponibles[2,6] - gastoMonedas[2,6] + sum{i in CartasEraII: i >= 16}3*Yse[i,6,'NOR'];


#desarrollar maravillas..................


#TURNO 2:
s.t. dispRecE3T2{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[3,2,k] = recursosDisponibles[3,1,k] + sum{i in CartasEraIII}(EspecialidadesEraIII[i,k]*Yte[i,1,'NOR']);
s.t. utilizRecE3T2{i in CartasEraIII, k in TiposDeCosto: i<=2 and k<>'MON'}: CostosEraIII[i,k]*Yte[i,2,'NOR'] <= recursosDisponibles[3,2,k] + recursosComprados[3,2,k]; 
s.t. monedasDisponiblesE3T2: monedasDisponibles[3,2] = monedasDisponibles[3,1] - gastoMonedas[3,1] + sum{i in CartasEraIII: i >= 12}3*Yte[i,1,'NOR'];

#TURNO 3:
s.t. dispRecE3T3{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[3,3,k] = recursosDisponibles[3,2,k] + sum{i in CartasEraIII}(EspecialidadesEraIII[i,k]*Yte[i,2,'NOR']);
s.t. utilizRecE3T3{i in CartasEraIII, k in TiposDeCosto: i<=2 and k<>'MON'}: CostosEraIII[i,k]*Yte[i,3,'NOR'] <= recursosDisponibles[3,3,k] + recursosComprados[3,3,k];
s.t. monedasDisponiblesE3T3: monedasDisponibles[3,3] = monedasDisponibles[3,2] - gastoMonedas[3,2] + sum{i in CartasEraIII: i >= 12}3*Yte[i,2,'NOR'];

#TURNO 4:
s.t. dispRecE3T4{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[3,4,k] = recursosDisponibles[3,3,k] + sum{i in CartasEraIII}(EspecialidadesEraIII[i,k]*Yte[i,3,'NOR']);
s.t. utilizRecE3T4{i in CartasEraIII, k in TiposDeCosto: i<=2 and k<>'MON'}: CostosEraIII[i,k]*Yte[i,4,'NOR'] <= recursosDisponibles[3,4,k] + recursosComprados[3,4,k];
s.t. monedasDisponiblesE3T4: monedasDisponibles[3,4] = monedasDisponibles[3,3] - gastoMonedas[3,3] + sum{i in CartasEraIII: i >= 12}3*Yte[i,3,'NOR'];


#TURNO 5:
s.t. dispRecE3T5{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[3,5,k] = recursosDisponibles[3,4,k] + sum{i in CartasEraIII}(EspecialidadesEraIII[i,k]*Yte[i,4,'NOR']);
s.t. utilizRecE3T5{i in CartasEraIII, k in TiposDeCosto: i<=2 and k<>'MON'}: CostosEraIII[i,k]*Yte[i,5,'NOR'] <= recursosDisponibles[3,5,k] + recursosComprados[3,5,k];
s.t. monedasDisponiblesE3T5: monedasDisponibles[3,5] = monedasDisponibles[3,4] - gastoMonedas[3,4] + sum{i in CartasEraIII: i >= 12}3*Yte[i,4,'NOR'];


#TURNO 6:
s.t. dispRecE3T6{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[3,6,k] = recursosDisponibles[3,5,k] + sum{i in CartasEraIII}(EspecialidadesEraIII[i,k]*Yte[i,5,'NOR']);
s.t. utilizRecE3T6{i in CartasEraIII, k in TiposDeCosto: i<=2 and k<>'MON'}: CostosEraIII[i,k]*Yte[i,6,'NOR'] <= recursosDisponibles[3,6,k] + recursosComprados[3,6,k];
s.t. monedasDisponiblesE3T6: monedasDisponibles[3,6] = monedasDisponibles[3,5] - gastoMonedas[3,5] + sum{i in CartasEraIII: i >= 12}3*Yte[i,5,'NOR'];


end;
