set Eras;
set CartasEraI;
set CartasEraII;
set CartasEraIII;
set Turnos;
set TiposDeCosto;
set TiposDeEspecialidad;
set MateriaPrima;
set ProductosManufacturados;
set MilitaresEra1;
set MilitaresEra2;
set MilitaresEra3;

set ModoDeCarta;
set NivelesDeDesarrollo; #1 2 3

#set TiposDeCosto := MON CEM TEL CER PAP MAD LAD ORO;
#set TiposDeEspecialidad := 'MON' 'CEM' 'TEL' 'CER' 'PAP' 'MAD' 'LAD' 'ORO' 'PTO' 'MIL';

var Ype{i in CartasEraI, j in Turnos, k in ModoDeCarta} >= 0, binary;
var Yse{i in CartasEraII, j in Turnos, k in ModoDeCarta} >= 0, binary;
var Yte{i in CartasEraIII, j in Turnos, k in ModoDeCarta} >= 0, binary;

#Monedas
var monedasDisponibles{i in Eras, j in Turnos} >= 0, integer;
var gastoMonedas{i in Eras, j in Turnos} >= 0, integer;
var monedasSobrantes >= 0, integer;

#Cantidad de Cartas
var cantidadMateriasPrima{i in Eras, j in Turnos} >= 0, integer;
var cantidadManufacturas{i in Eras, j in Turnos} >= 0, integer;
var cantidadComerciales{i in Eras, j in Turnos} >= 0, integer;

#Recursos
var recursosDisponibles{i in Eras, j in Turnos, k in TiposDeCosto: k<>'MON'} >= 0, integer;
var recursosComprados{i in Eras, j in Turnos, k in TiposDeCosto: k<>'MON'} >= 0, integer;
var recursosRealizados{i in Eras, j in Turnos, k in TiposDeCosto: k<>'MON'} >= 0, integer;

#Puntos
var puntosMonedas >= 0, integer;


#Simbolos
var Geometricas >= 0, integer;
var Yg1 >= 0, binary;
var Yg2 >= 0, binary;
var Yg3 >= 0, binary;
var Yg4 >= 0, binary;

var Ruedas >= 0, integer;
var Yr1 >= 0, binary;
var Yr2 >= 0, binary;
var Yr3 >= 0, binary;
var Yr4 >= 0, binary;

var Escrituras >= 0, integer;
var Ye1 >= 0, binary;
var Ye2 >= 0, binary;
var Ye3 >= 0, binary;
var Ye4 >= 0, binary;
var Ye5 >= 0, binary;

#Cantidad de Trios de Simbolos
var TrioDeSimbolos >= 0, integer;


#Desarrollo de Maravilla:
var desarrollo >= 0, integer;
var nivel{i in NivelesDeDesarrollo} >= 0 binary;

#Costos por Era:
param CostosEraI{i in CartasEraI, j in TiposDeCosto};
param CostosEraII{i in CartasEraII, j in TiposDeCosto};
param CostosEraIII{i in CartasEraIII, j in TiposDeCosto};

#CostoDeMaravilla:
var CostosMaravilla{i in NivelesDeDesarrollo, k in TiposDeCosto: k <> 'MON'} >= 0, integer;
#----- PRUEBA DE COSTOS <>Marav -----#
param CostosMaravillaGiza{i in NivelesDeDesarrollo, k in TiposDeCosto: k <> 'MON'};
param CostosMaravillaArtemisa{i in NivelesDeDesarrollo, k in TiposDeCosto: k <> 'MON'};
param CostosMaravillaRodas{i in NivelesDeDesarrollo, k in TiposDeCosto: k <> 'MON'};

#Especialidades por Era:
param EspecialidadesEraI{i in CartasEraI, j in TiposDeEspecialidad};
param EspecialidadesEraII{i in CartasEraII, j in TiposDeEspecialidad};
param EspecialidadesEraIII{i in CartasEraIII, j in TiposDeEspecialidad};

#Desarrollo de conflicto
var YGano{i in Eras} >= 0, binary;
var YPerdio{i in Eras} >= 0, binary;
var YEmpate{i in Eras} >= 0, binary;
var Exc{i in Eras} >= 0, integer;
var Def{i in Eras} >= 0, integer;

#Diferentes tableros
set Tableros;
var YTablero{i in Tableros} >= 0, binary;
var Exctab{i in Tableros} >= 0, integer;
var Deftab{i in Tableros} >= 0, integer;
var YTabmay{i in Tableros} >= 0, binary;
var YTabmen{i in Tableros} >= 0, binary;
var YTabNivel2{i in Tableros} >= 0, binary;

#Efectos Edificios Comerciales
var MonedasRecibidasVineyard{j in Turnos} >= 0, integer;
var MonedasRecibidasBazar{j in Turnos} >= 0, integer;

maximize z: sum{i in CartasEraI, j in Turnos}EspecialidadesEraI[i,'PTO']*Ype[i,j,'NOR'] +
			sum{i in CartasEraII, j in Turnos}EspecialidadesEraII[i,'PTO']*Yse[i,j,'NOR'] +
			sum{i in CartasEraIII, j in Turnos}EspecialidadesEraIII[i, 'PTO']*Yte[i,j,'NOR'] +
			1*(Yg1 + Yr1 + Ye1) + 4*(Yg2 + Yr2 + Ye2) + 9*(Yg3 + Yr3 + Ye3) + 16*(Yg4 + Yr4 + Ye4) +
			25*Ye5 + puntosMonedas + 7*TrioDeSimbolos + 3*nivel[1] + 5*YTabNivel2['GIZ'] + 7*nivel[3] +
			+ 1*YGano[1] + 3*YGano[2] + 5*YGano[3] - 1*(sum{i in Eras}YPerdio[i]);


#Desarrollo de Maravilla:
s.t. nivelesMaximos: desarrollo <= 3;
s.t. nivelesDesarrollo: desarrollo = sum{i in NivelesDeDesarrollo}nivel[i];
s.t. desarrolloMaravillas: sum{i in CartasEraI, j in Turnos}Ype[i,j,'MAR']
	+ sum{k in CartasEraII, l in Turnos}Yse[k,l,'MAR']
	+ sum{m in CartasEraIII, n in Turnos}Yte[m,n,'MAR'] = desarrollo;
s.t. ordenDesarrollo1: nivel[2] <= nivel[1];
s.t. ordenDesarrollo2: nivel[3] <= nivel[2];
s.t. costoMaravilla{n in NivelesDeDesarrollo, k in TiposDeCosto: k <> 'MON'}: CostosMaravilla[n,k] = CostosMaravillaGiza[n,k]*YTablero['GIZ'] + CostosMaravillaArtemisa[n,k]*YTablero['ART'] + CostosMaravillaRodas[n,k]*YTablero['ROD']; 

#ERA I:
s.t. eleccionCartaE1T{j in Turnos}: sum{i in CartasEraI, k in ModoDeCarta}Ype[i,j,k] = 1; #SOLO UNA CARTA POR TURNO
s.t. soloUnaCartaEra1{i in CartasEraI}: sum{j in Turnos,k in ModoDeCarta}Ype[i,j,k] <= 1; #SOLO UNA CARTA DE ESE TIPO POR ERA o NINGUNA
s.t. utilizMonedas{i in CartasEraI, j in Turnos}: CostosEraI[i,'MON']*Ype[i,j,'NOR'] <= monedasDisponibles[1,j]; #CALCULO POR TURNO DE POSIBIL.
s.t. monedasUsadasE1T{j in Turnos}: gastoMonedas[1,j] = sum{i in CartasEraI}(CostosEraI[i,'MON']*Ype[i,j,'NOR']) +
		sum{m in MateriaPrima}(2*recursosComprados[1,j,m]) +
		sum{p in ProductosManufacturados}(2*recursosComprados[1,j,p]); #CALCULO DE MONEDAS USADAS

s.t. cantMatPrimasE1T1: cantidadMateriasPrima[1,1] = sum{i in CartasEraI: i <= 8}Ype[i,1,'NOR'];
s.t. cantMatPrimasE1T{j in Turnos: j > 1}: cantidadMateriasPrima[1,j] = cantidadMateriasPrima[1,j-1] + sum{i in CartasEraI: i <= 8}Ype[i,j,'NOR'];

s.t. cantManufacturasE1T1: cantidadManufacturas[1,1] = Ype[9,1,'NOR'] + Ype[10,1,'NOR'] + Ype[11,1,'NOR'];
s.t. cantManufacturasE1T{j in Turnos: j > 1}: cantidadManufacturas[1,j] = cantidadManufacturas[1,j-1] + Ype[9,j,'NOR'] + Ype[10,j,'NOR'] + Ype[11,j,'NOR'];

s.t. cantComercialesE1T1: cantidadComerciales[1,1] = Ype[9,1,'NOR'] + Ype[10,1,'NOR'] + Ype[11,1,'NOR'];
s.t. cantComercialesE1T{j in Turnos: j > 1}: cantidadComerciales[1,j] = cantidadComerciales[1,j-1] + Ype[22,j,'NOR'] + Ype[23,j,'NOR'] + Ype[24,j,'NOR'];


#TURNO 1:
s.t. monedasIniciales: monedasDisponibles[1,1] = 3;
s.t. dispRecursosIniciales{k in TiposDeCosto: k<>'MON' and k<>'CEM'}: recursosDisponibles[1,1,k] = 0;
s.t. cementoInicial: recursosDisponibles[1,1,'CEM'] = 1;
s.t. utilizRec{i in CartasEraI, k in TiposDeCosto: k<>'MON'}: CostosEraI[i,k]*Ype[i,1,'NOR'] <= recursosDisponibles[1,1,k] + recursosComprados[1,1,k];

#s.t. utiliRecMarE1T1{i in CartasEraI, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Ype[i,1,'MAR'] <= recursosDisponibles[1,1,k] + recursosComprados[1,1,k];

s.t. utiliRecMarE1T1{i in CartasEraI, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Ype[i,1,'MAR']) <= recursosDisponibles[1,1,k] + recursosComprados[1,1,k];

#TURNO 2:
s.t. dispRecE1T2{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[1,2,k] = recursosDisponibles[1,1,k] + sum{i in CartasEraI}(EspecialidadesEraI[i,k]*Ype[i,1,'NOR']);# + recursosComprados[1,1,k];
s.t. utilizRecE1T2{i in CartasEraI, k in TiposDeCosto: k<>'MON'}: CostosEraI[i,k]*Ype[i,2,'NOR'] <= recursosDisponibles[1,2,k] + recursosComprados[1,2,k];
s.t. monedasDisponiblesE1T2: monedasDisponibles[1,2] = monedasDisponibles[1,1] - gastoMonedas[1,1] + sum{i in CartasEraI: i >= 19}3*Ype[i,1,'NOR'];

#s.t. utiliRecMarE1T2{i in CartasEraI, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Ype[i,2,'MAR'] <= recursosDisponibles[1,2,k] + recursosComprados[1,2,k];
s.t. utiliRecMarE1T2{i in CartasEraI, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Ype[i,2,'MAR']) <= recursosDisponibles[1,2,k] + recursosComprados[1,2,k];

#TURNO 3:
s.t. dispRecE1T3{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[1,3,k] = recursosDisponibles[1,2,k] + sum{i in CartasEraI}(EspecialidadesEraI[i,k]*Ype[i,2,'NOR']);# + recursosComprados[1,2,k];
s.t. utilizRecE1T3{i in CartasEraI, k in TiposDeCosto: k<>'MON'}: CostosEraI[i,k]*Ype[i,3,'NOR'] <= recursosDisponibles[1,3,k] + recursosComprados[1,3,k];
s.t. monedasDisponiblesE1T3: monedasDisponibles[1,3] = monedasDisponibles[1,2] - gastoMonedas[1,2] + sum{i in CartasEraI: i >= 19}3*Ype[i,2,'NOR'];

#s.t. utiliRecMarE1T3{i in CartasEraI, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Ype[i,3,'MAR'] <= recursosDisponibles[1,3,k] + recursosComprados[1,3,k];
s.t. utiliRecMarE1T3{i in CartasEraI, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Ype[i,3,'MAR']) <= recursosDisponibles[1,3,k] + recursosComprados[1,3,k];

#TURNO 4:
s.t. dispRecE1T4{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[1,4,k] = recursosDisponibles[1,3,k] + sum{i in CartasEraI}(EspecialidadesEraI[i,k]*Ype[i,3,'NOR']);# + recursosComprados[1,3,k];
s.t. utilizRecE1T4{i in CartasEraI, k in TiposDeCosto: k<>'MON'}: CostosEraI[i,k]*Ype[i,4,'NOR'] <= recursosDisponibles[1,4,k] + recursosComprados[1,4,k];
s.t. monedasDisponiblesE1T4: monedasDisponibles[1,4] = monedasDisponibles[1,3] - gastoMonedas[1,3] + sum{i in CartasEraI: i >= 19}3*Ype[i,3,'NOR'];

#s.t. utiliRecMarE1T4{i in CartasEraI, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Ype[i,4,'MAR'] <= recursosDisponibles[1,4,k] + recursosComprados[1,4,k];
s.t. utiliRecMarE1T4{i in CartasEraI, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Ype[i,4,'MAR']) <= recursosDisponibles[1,4,k] + recursosComprados[1,4,k];

#TURNO 5:
s.t. dispRecE1T5{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[1,5,k] = recursosDisponibles[1,4,k] + sum{i in CartasEraI}(EspecialidadesEraI[i,k]*Ype[i,4,'NOR']);# + recursosComprados[1,4,k];
s.t. utilizRecE1T5{i in CartasEraI, k in TiposDeCosto: k<>'MON'}: CostosEraI[i,k]*Ype[i,5,'NOR'] <= recursosDisponibles[1,5,k] + recursosComprados[1,5,k];
s.t. monedasDisponiblesE1T5: monedasDisponibles[1,5] = monedasDisponibles[1,4] - gastoMonedas[1,4] + sum{i in CartasEraI: i >= 19}3*Ype[i,4,'NOR'];

#s.t. utiliRecMarE1T5{i in CartasEraI, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Ype[i,5,'MAR'] <= recursosDisponibles[1,5,k] + recursosComprados[1,5,k];
s.t. utiliRecMarE1T5{i in CartasEraI, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Ype[i,5,'MAR']) <= recursosDisponibles[1,5,k] + recursosComprados[1,5,k];


#TURNO 6:
s.t. dispRecE1T6{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[1,6,k] = recursosDisponibles[1,5,k] + sum{i in CartasEraI}(EspecialidadesEraI[i,k]*Ype[i,5,'NOR']);# + recursosComprados[1,5,k];
s.t. utilizRecE1T6{i in CartasEraI, k in TiposDeCosto: k<>'MON'}: CostosEraI[i,k]*Ype[i,6,'NOR'] <= recursosDisponibles[1,6,k] + recursosComprados[1,6,k];
s.t. monedasDisponiblesE1T6: monedasDisponibles[1,6] = monedasDisponibles[1,5] - gastoMonedas[1,5] + sum{i in CartasEraI: i >= 19}3*Ype[i,5,'NOR'];

#s.t. utiliRecMarE1T6{i in CartasEraI, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Ype[i,6,'MAR'] <= recursosDisponibles[1,6,k] + recursosComprados[1,6,k];
s.t. utiliRecMarE1T6{i in CartasEraI, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Ype[i,6,'MAR']) <= recursosDisponibles[1,6,k] + recursosComprados[1,6,k];


#ERA II:
s.t. eleccionCartaE2T{j in Turnos}: sum{i in CartasEraII, k in ModoDeCarta}Yse[i,j,k] = 1; #SOLO UNA CARTA POR TURNO
s.t. soloUnaCartaEra2{i in CartasEraII}: sum{j in Turnos,k in ModoDeCarta}Yse[i,j,k] <= 1; #SOLO UNA CARTA DE ESE TIPO POR ERA o NINGUNA
s.t. utilizMonedasE2{i in CartasEraII, j in Turnos}: CostosEraII[i,'MON']*Yse[i,j,'NOR'] <= monedasDisponibles[2,j]; #CALCULO POR TURNO DE POSIBIL.
s.t. monedasUsadasE2T{j in Turnos}: gastoMonedas[2,j] = sum{i in CartasEraII}(CostosEraII[i,'MON']*Yse[i,j,'NOR']) + sum{m in MateriaPrima}(2*recursosComprados[2,j,m]) + sum{p in ProductosManufacturados}(2*recursosComprados[2,j,p]); #CALCULO DE MONEDAS USADAS

s.t. utilizRecE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[13,k]*Yse[13,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k];

s.t. AqueductE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[8,k]*Yse[8,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[13,i,'NOR']; #GASTO DE AQUEDUCT

s.t. TempleE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[9,k]*Yse[9,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[12,i,'NOR']; #GASTO DE TEMPLE

s.t. StatueE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[10,k]*Yse[10,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[15,i,'NOR']; #GASTO DE STATUE

s.t. CourthouseE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[11,k]*Yse[11,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + sum{i in Turnos}(5000*Ype[18,i,'NOR']); #GASTO DE COURTHOUSE

s.t. DispensaryE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[12,k]*Yse[12,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[16,i,'NOR']; #GASTO DE DISPENSARY

s.t. LaboratoryE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[14,k]*Yse[14,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[17,i,'NOR']; #GASTO DE LABORATORY

s.t. LibraryE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[15,k]*Yse[15,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[18,i,'NOR']; #GASTO DE LIBRARY

s.t. ArcheryE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[16,k]*Yse[16,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[17,i,'NOR']; #GASTO DE ARCHERY RANGE

s.t. TrainingGroundE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[17,k]*Yse[17,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k]; #GASTO DE TRAINING GROUND

s.t. WallsE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[18,k]*Yse[18,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k]; #GASTO DE WALLS

s.t. StablesE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[19,k]*Yse[19,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[16,i,'NOR']; #GASTO DE STABLES

s.t. ForumE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[20,k]*Yse[20,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[23,i,'NOR']; #GASTO DE FORUM

s.t. VineyardE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[21,k]*Yse[21,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k]; #GASTO DE VINEYARD

s.t. BazarE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[22,k]*Yse[22,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k]; #GASTO DE BAZAR

s.t. CaravanseryE2T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraII[23,k]*Yse[23,j,'NOR'] <= recursosDisponibles[2,j,k] + recursosComprados[2,j,k] + 5000*sum{i in Turnos}Ype[24,i,'NOR']; #GASTO DE CARAVANSERY


s.t. cantMatPrimasE2T1: cantidadMateriasPrima[2,1] = sum{i in CartasEraII: i <= 4}Yse[i,1,'NOR'];
s.t. cantMatPrimasE2T{j in Turnos: j > 1}: cantidadMateriasPrima[2,j] = cantidadMateriasPrima[2,j-1] + sum{i in CartasEraII: i <= 4}Yse[i,j,'NOR'];

s.t. cantManufacturasE2T1: cantidadManufacturas[2,1] = Yse[5,1,'NOR'] + Yse[6,1,'NOR'] + Yse[7,1,'NOR'];
s.t. cantManufacturasE2T{j in Turnos: j > 1}: cantidadManufacturas[2,j] = cantidadManufacturas[2,j-1] + Yse[5,j,'NOR'] + Yse[6,j,'NOR'] + Yse[7,j,'NOR'];

s.t. cantComercialesE2T1: cantidadComerciales[2,1] = Yse[9,1,'NOR'] + Yse[10,1,'NOR'] + Yse[11,1,'NOR'];
s.t. cantComercialesE2T{j in Turnos: j > 1}: cantidadComerciales[2,j] = cantidadComerciales[2,j-1] + Yse[20,j,'NOR'] + Yse[21,j,'NOR'] + Yse[22,j,'NOR'] + Yse[23,j,'NOR'];


#TURNO 1:
s.t. dispRecE2T1{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[2,1,k] = recursosDisponibles[1,6,k] + sum{i in CartasEraI}(EspecialidadesEraI[i,k]*Ype[i,6,'NOR']);# + recursosComprados[1,6,k];
s.t. utilizRecE2T1{i in CartasEraII, k in TiposDeCosto: i<=7 and k<>'MON'}: CostosEraII[i,k]*Yse[i,1,'NOR'] <= recursosDisponibles[2,1,k] + recursosComprados[2,1,k];
s.t. monedasDisponiblesE2T1: monedasDisponibles[2,1] = monedasDisponibles[1,6] - gastoMonedas[1,6] + sum{i in CartasEraI: i >= 19}3*Ype[i,6,'NOR'];

s.t. monedasVineyardT1: MonedasRecibidasVineyard[1] <= 20*Yse[21,1,'NOR'];
s.t. monedasVineyardT1CotaInf: 1*cantidadMateriasPrima[2,1] - 20*(1 - Yse[21,1,'NOR'])<= MonedasRecibidasVineyard[1];
s.t. monedasVineyardT1CotaSup: MonedasRecibidasVineyard[1] <= 1*cantidadMateriasPrima[2,1];
s.t. monedasBazarT1: MonedasRecibidasBazar[1] <= 20*Yse[22,1,'NOR'];
s.t. monedasBazarT1CotaInf: 2*cantidadManufacturas[2,1] - 20*(1 - Yse[22,1,'NOR'])<= MonedasRecibidasBazar[1];
s.t. monedasBazarT1CotaSup: MonedasRecibidasBazar[1] <= 2*cantidadManufacturas[2,1];

#s.t. utiliRecMarE2T1{i in CartasEraII, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Yse[i,1,'MAR'] <= recursosDisponibles[2,1,k] + recursosComprados[2,1,k];
s.t. utiliRecMarE2T1{i in CartasEraII, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Yse[i,1,'MAR']) <= recursosDisponibles[2,1,k] + recursosComprados[2,1,k];


#TURNO 2:
s.t. dispRecE2T2{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[2,2,k] = recursosDisponibles[2,1,k] + sum{i in CartasEraII}(EspecialidadesEraII[i,k]*Yse[i,1,'NOR']);# + recursosComprados[2,1,k];
s.t. utilizRecE2T2{i in CartasEraII, k in TiposDeCosto: i<=7 and k<>'MON'}: CostosEraII[i,k]*Yse[i,2,'NOR'] <= recursosDisponibles[2,2,k] + recursosComprados[2,2,k];
s.t. monedasDisponiblesE2T2: monedasDisponibles[2,2] = monedasDisponibles[2,1] - gastoMonedas[2,1]  + MonedasRecibidasVineyard[1] + MonedasRecibidasBazar[1] + sum{i in CartasEraII: i >= 16}3*Yse[i,1,'NOR'];

s.t. monedasVineyardT2: MonedasRecibidasVineyard[2] <= 20*Yse[21,2,'NOR'];
s.t. monedasVineyardT2CotaInf: 1*cantidadMateriasPrima[2,2] - 20*(1 - Yse[21,2,'NOR'])<= MonedasRecibidasVineyard[2];
s.t. monedasVineyardT2CotaSup: MonedasRecibidasVineyard[2] <= 1*cantidadMateriasPrima[2,2];
s.t. monedasBazarT2: MonedasRecibidasBazar[2] <= 20*Yse[22,2,'NOR'];
s.t. monedasBazarT2CotaInf: 2*cantidadManufacturas[2,2] - 20*(1 - Yse[22,2,'NOR'])<= MonedasRecibidasBazar[2];
s.t. monedasBazarT2CotaSup: MonedasRecibidasBazar[2] <= 2*cantidadManufacturas[2,2];

#s.t. utiliRecMarE2T2{i in CartasEraII, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Yse[i,2,'MAR'] <= recursosDisponibles[2,2,k] + recursosComprados[2,2,k];
s.t. utiliRecMarE2T2{i in CartasEraII, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Yse[i,2,'MAR']) <= recursosDisponibles[2,2,k] + recursosComprados[2,2,k];


#TURNO 3:
s.t. dispRecE2T3{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[2,3,k] = recursosDisponibles[2,2,k] + sum{i in CartasEraII}(EspecialidadesEraII[i,k]*Yse[i,2,'NOR']);# + recursosComprados[2,2,k];
s.t. utilizRecE2T3{i in CartasEraII, k in TiposDeCosto: i<=7 and k<>'MON'}: CostosEraII[i,k]*Yse[i,3,'NOR'] <= recursosDisponibles[2,3,k] + recursosComprados[2,3,k];
s.t. monedasDisponiblesE2T3: monedasDisponibles[2,3] = monedasDisponibles[2,2] - gastoMonedas[2,2] + MonedasRecibidasVineyard[2] + MonedasRecibidasBazar[2] + sum{i in CartasEraII: i >= 16}3*Yse[i,2,'NOR'];

s.t. monedasVineyardT3: MonedasRecibidasVineyard[3] <= 20*Yse[21,3,'NOR'];
s.t. monedasVineyardT3CotaInf: 1*cantidadMateriasPrima[2,3] - 20*(1 - Yse[21,3,'NOR'])<= MonedasRecibidasVineyard[3];
s.t. monedasVineyardT3CotaSup: MonedasRecibidasVineyard[3] <= 1*cantidadMateriasPrima[2,3];
s.t. monedasBazarT3: MonedasRecibidasBazar[3] <= 20*Yse[22,3,'NOR'];
s.t. monedasBazarT3CotaInf: 2*cantidadManufacturas[2,3] - 20*(1 - Yse[22,3,'NOR'])<= MonedasRecibidasBazar[3];
s.t. monedasBazarT3CotaSup: MonedasRecibidasBazar[3] <= 2*cantidadManufacturas[2,3];


#s.t. utiliRecMarE2T3{i in CartasEraII, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Yse[i,3,'MAR'] <= recursosDisponibles[2,3,k] + recursosComprados[2,3,k];
s.t. utiliRecMarE2T3{i in CartasEraII, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Yse[i,3,'MAR']) <= recursosDisponibles[2,3,k] + recursosComprados[2,3,k];


#TURNO 4:
s.t. dispRecE2T4{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[2,4,k] = recursosDisponibles[2,3,k] + sum{i in CartasEraII}(EspecialidadesEraII[i,k]*Yse[i,3,'NOR']);# + recursosComprados[2,3,k];
s.t. utilizRecE2T4{i in CartasEraII, k in TiposDeCosto: i<=7 and k<>'MON'}: CostosEraII[i,k]*Yse[i,4,'NOR'] <= recursosDisponibles[2,4,k] + recursosComprados[2,4,k];
s.t. monedasDisponiblesE2T4: monedasDisponibles[2,4] = monedasDisponibles[2,3] - gastoMonedas[2,3] + MonedasRecibidasVineyard[3] + MonedasRecibidasBazar[3] + sum{i in CartasEraII: i >= 16}3*Yse[i,3,'NOR'];


s.t. monedasVineyardT4: MonedasRecibidasVineyard[4] <= 20*Yse[21,4,'NOR'];
s.t. monedasVineyardT4CotaInf: 1*cantidadMateriasPrima[2,4] - 20*(1 - Yse[21,4,'NOR'])<= MonedasRecibidasVineyard[4];
s.t. monedasVineyardT4CotaSup: MonedasRecibidasVineyard[4] <= 1*cantidadMateriasPrima[2,4];
s.t. monedasBazarT4: MonedasRecibidasBazar[4] <= 20*Yse[22,4,'NOR'];
s.t. monedasBazarT4CotaInf: 2*cantidadManufacturas[2,4] - 20*(1 - Yse[22,4,'NOR'])<= MonedasRecibidasBazar[4];
s.t. monedasBazarT4CotaSup: MonedasRecibidasBazar[4] <= 2*cantidadManufacturas[2,4];

#s.t. utiliRecMarE2T4{i in CartasEraII, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Yse[i,4,'MAR'] <= recursosDisponibles[2,4,k] + recursosComprados[2,4,k];
s.t. utiliRecMarE2T4{i in CartasEraII, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Yse[i,4,'MAR']) <= recursosDisponibles[2,4,k] + recursosComprados[2,4,k];


#TURNO 5:
s.t. dispRecE2T5{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[2,5,k] = recursosDisponibles[2,4,k] + sum{i in CartasEraII}(EspecialidadesEraII[i,k]*Yse[i,4,'NOR']);# + recursosComprados[2,4,k];
s.t. utilizRecE2T5{i in CartasEraII, k in TiposDeCosto: i<=7 and k<>'MON'}: CostosEraII[i,k]*Yse[i,5,'NOR'] <= recursosDisponibles[2,5,k] + recursosComprados[2,5,k];
s.t. monedasDisponiblesE2T5: monedasDisponibles[2,5] = monedasDisponibles[2,4] - gastoMonedas[2,4] + MonedasRecibidasVineyard[4] + MonedasRecibidasBazar[4] + sum{i in CartasEraII: i >= 16}3*Yse[i,4,'NOR'];


s.t. monedasVineyardT5: MonedasRecibidasVineyard[5] <= 20*Yse[21,5,'NOR'];
s.t. monedasVineyardT5CotaInf: 1*cantidadMateriasPrima[2,5] - 20*(1 - Yse[21,5,'NOR'])<= MonedasRecibidasVineyard[5];
s.t. monedasVineyardT5CotaSup: MonedasRecibidasVineyard[5] <= 1*cantidadMateriasPrima[2,5];
s.t. monedasBazarT5: MonedasRecibidasBazar[5] <= 20*Yse[22,5,'NOR'];
s.t. monedasBazarT5CotaInf: 2*cantidadManufacturas[2,5] - 20*(1 - Yse[22,5,'NOR'])<= MonedasRecibidasBazar[5];
s.t. monedasBazarT5CotaSup: MonedasRecibidasBazar[5] <= 2*cantidadManufacturas[2,5];


#s.t. utiliRecMarE2T5{i in CartasEraII, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Yse[i,5,'MAR'] <= recursosDisponibles[2,5,k] + recursosComprados[2,5,k];
s.t. utiliRecMarE2T5{i in CartasEraII, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Yse[i,5,'MAR']) <= recursosDisponibles[2,5,k] + recursosComprados[2,5,k];


#TURNO 6:
s.t. dispRecE2T6{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[2,6,k] = recursosDisponibles[2,5,k] + sum{i in CartasEraII}(EspecialidadesEraII[i,k]*Yse[i,5,'NOR']);# + recursosComprados[2,5,k];
s.t. utilizRecE2T6{i in CartasEraII, k in TiposDeCosto: i<=7 and k<>'MON'}: CostosEraII[i,k]*Yse[i,6,'NOR'] <= recursosDisponibles[2,6,k] + recursosComprados[2,6,k];
s.t. monedasDisponiblesE2T6: monedasDisponibles[2,6] = monedasDisponibles[2,5] - gastoMonedas[2,5] + MonedasRecibidasVineyard[5] + MonedasRecibidasBazar[5] + sum{i in CartasEraII: i >= 16}3*Yse[i,5,'NOR'];


s.t. monedasVineyardT6: MonedasRecibidasVineyard[6] <= 20*Yse[21,6,'NOR'];
s.t. monedasVineyardT6CotaInf: 1*cantidadMateriasPrima[2,6] - 20*(1 - Yse[21,6,'NOR'])<= MonedasRecibidasVineyard[6];
s.t. monedasVineyardT6CotaSup: MonedasRecibidasVineyard[6] <= 1*cantidadMateriasPrima[2,6];
s.t. monedasBazarT6: MonedasRecibidasBazar[6] <= 20*Yse[22,6,'NOR'];
s.t. monedasBazarT6CotaInf: 2*cantidadManufacturas[2,6] - 20*(1 - Yse[22,6,'NOR'])<= MonedasRecibidasBazar[6];
s.t. monedasBazarT6CotaSup: MonedasRecibidasBazar[6] <= 2*cantidadManufacturas[2,6];

#s.t. utiliRecMarE2T6{i in CartasEraII, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Yse[i,6,'MAR'] <= recursosDisponibles[2,6,k] + recursosComprados[2,6,k];
s.t. utiliRecMarE2T6{i in CartasEraII, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Yse[i,6,'MAR']) <= recursosDisponibles[2,6,k] + recursosComprados[2,6,k];


#ERA III:
s.t. eleccionCartaE3T{j in Turnos}: sum{i in CartasEraIII, k in ModoDeCarta}Yte[i,j,k] = 1; #SOLO UNA CARTA POR TURNO
s.t. soloUnaCartaEra3{i in CartasEraIII}: sum{j in Turnos,k in ModoDeCarta}Yte[i,j,k] <= 1; #SOLO UNA CARTA DE ESE TIPO POR ERA o NINGUNA
s.t. utilizMonedasE3{i in CartasEraIII, j in Turnos}: CostosEraIII[i,'MON']*Yte[i,j,'NOR'] <= monedasDisponibles[3,j]; #CALCULO POR TURNO DE POSIBIL.
s.t. monedasUsadasE3T{j in Turnos}: gastoMonedas[3,j] = sum{i in CartasEraIII}(CostosEraIII[i,'MON']*Yte[i,j,'NOR']) + sum{m in MateriaPrima}(2*recursosComprados[3,j,m]) + sum{p in ProductosManufacturados}(2*recursosComprados[3,j,p]); #CALCULO DE MONEDAS USADAS


s.t. SenateE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[3,k]*Yte[3,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[15,i,'NOR']; #GASTO DE SENATE

s.t. PantheonE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[4,k]*Yte[4,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[9,i,'NOR']; #GASTO DE PANTHEON

s.t. GardensE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[5,k]*Yte[5,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[10,i,'NOR']; #GASTO DE GARDENS

s.t. UniversityE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[6,k]*Yte[6,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[15,i,'NOR']; #GASTO DE UNIVERSITY

s.t. ObserbatoryE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[7,k]*Yte[7,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[14,i,'NOR']; #GASTO DE OBSERVATORY

s.t. StudyE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[8,k]*Yte[8,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[13,i,'NOR']; #GASTO DE STUDY

s.t. AcademyE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[9,k]*Yte[9,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[13,i,'NOR']; #GASTO DE ACADEMY

s.t. LodgeE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[10,k]*Yte[10,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[12,i,'NOR']; #GASTO DE LODGE

s.t. University2E3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[11,k]*Yte[11,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[15,i,'NOR']; #GASTO DE UNIVERSITY2

s.t. Arsenal2E3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[12,k]*Yte[12,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k]; #GASTO DE ARSENAL

s.t. CircusE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[13,k]*Yte[13,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[17,i,'NOR']; #GASTO DE CIRCUS

s.t. SiegeWorkshopE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[14,k]*Yte[14,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[14,i,'NOR']; #GASTO DE SIEGE WORKSHOP

s.t. FortificationsE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[15,k]*Yte[15,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[18,i,'NOR']; #GASTO DE FORTIFICATIONS

s.t. HavenE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[16,k]*Yte[16,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[20,i,'NOR']; #GASTO DE HAVEN

s.t. ChamberOfCommerce2E3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[17,k]*Yte[17,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k]; #GASTO DE CHAMBER OF COMMERCE

s.t. LighthouseE3T{j in Turnos, k in TiposDeCosto: k<>'MON'}: CostosEraIII[18,k]*Yte[18,j,'NOR'] <= recursosDisponibles[3,j,k] + recursosComprados[3,j,k] + 5000*sum{i in Turnos}Yse[23,i,'NOR']; #GASTO DE LIGHTHOUSE

s.t. cantMatPrimasE3T{j in Turnos}: cantidadMateriasPrima[3,j] = 0;

s.t. cantManufacturasE3T{j in Turnos}: cantidadManufacturas[2,j] = 0;

s.t. cantComercialesE3T1: cantidadComerciales[3,1] = Yte[16,1,'NOR'] + Yte[17,1,'NOR'] + Yte[18,1,'NOR'];
s.t. cantComercialesE3T{j in Turnos: j > 1}: cantidadComerciales[3,j] = cantidadComerciales[3,j-1] + Yte[16,j,'NOR'] + Yte[17,j,'NOR'] + Yte[18,j,'NOR'];


#TURNO 1:
s.t. dispRecE3T1{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[3,1,k] = recursosDisponibles[2,6,k] + sum{i in CartasEraII}(EspecialidadesEraII[i,k]*Yse[i,6,'NOR']);# + recursosComprados[2,6,k];
s.t. utilizRecE3T1{i in CartasEraIII, k in TiposDeCosto: i<=2 and k<>'MON'}: CostosEraIII[i,k]*Yte[i,1,'NOR'] <= recursosDisponibles[3,1,k] + recursosComprados[3,1,k];
s.t. monedasDisponiblesE3T1: monedasDisponibles[3,1] = monedasDisponibles[2,6] - gastoMonedas[2,6] + MonedasRecibidasVineyard[6] + MonedasRecibidasBazar[6] + sum{i in CartasEraII: i >= 16}3*Yse[i,6,'NOR'];


#s.t. utiliRecMarE3T1{i in CartasEraIII, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Yte[i,1,'MAR'] <= recursosDisponibles[3,1,k] + recursosComprados[3,1,k];
s.t. utiliRecMarE3T1{i in CartasEraIII, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Yte[i,1,'MAR']) <= recursosDisponibles[3,1,k] + recursosComprados[3,1,k];

#TURNO 2:
s.t. dispRecE3T2{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[3,2,k] = recursosDisponibles[3,1,k] + sum{i in CartasEraIII}(EspecialidadesEraIII[i,k]*Yte[i,1,'NOR']);# + recursosComprados[3,1,k];
s.t. utilizRecE3T2{i in CartasEraIII, k in TiposDeCosto: i<=2 and k<>'MON'}: CostosEraIII[i,k]*Yte[i,2,'NOR'] <= recursosDisponibles[3,2,k] + recursosComprados[3,2,k];
s.t. monedasDisponiblesE3T2: monedasDisponibles[3,2] = monedasDisponibles[3,1] - gastoMonedas[3,1] + sum{i in CartasEraIII: i >= 12}3*Yte[i,1,'NOR'];

#s.t. utiliRecMarE3T2{i in CartasEraIII, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Yte[i,2,'MAR'] <= recursosDisponibles[3,2,k] + recursosComprados[3,2,k];
s.t. utiliRecMarE3T2{i in CartasEraIII, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Yte[i,2,'MAR']) <= recursosDisponibles[3,2,k] + recursosComprados[3,2,k];

#TURNO 3:
s.t. dispRecE3T3{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[3,3,k] = recursosDisponibles[3,2,k] + sum{i in CartasEraIII}(EspecialidadesEraIII[i,k]*Yte[i,2,'NOR']);# + recursosComprados[3,2,k];
s.t. utilizRecE3T3{i in CartasEraIII, k in TiposDeCosto: i<=2 and k<>'MON'}: CostosEraIII[i,k]*Yte[i,3,'NOR'] <= recursosDisponibles[3,3,k] + recursosComprados[3,3,k];
s.t. monedasDisponiblesE3T3: monedasDisponibles[3,3] = monedasDisponibles[3,2] - gastoMonedas[3,2] + sum{i in CartasEraIII: i >= 12}3*Yte[i,2,'NOR'];

#s.t. utiliRecMarE3T3{i in CartasEraIII, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Yte[i,3,'MAR'] <= recursosDisponibles[3,3,k] + recursosComprados[3,3,k];
s.t. utiliRecMarE3T3{i in CartasEraIII, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Yte[i,3,'MAR']) <= recursosDisponibles[3,3,k] + recursosComprados[3,3,k];

#TURNO 4:
s.t. dispRecE3T4{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[3,4,k] = recursosDisponibles[3,3,k] + sum{i in CartasEraIII}(EspecialidadesEraIII[i,k]*Yte[i,3,'NOR']);# + recursosComprados[3,3,k];
s.t. utilizRecE3T4{i in CartasEraIII, k in TiposDeCosto: i<=2 and k<>'MON'}: CostosEraIII[i,k]*Yte[i,4,'NOR'] <= recursosDisponibles[3,4,k] + recursosComprados[3,4,k];
s.t. monedasDisponiblesE3T4: monedasDisponibles[3,4] = monedasDisponibles[3,3] - gastoMonedas[3,3] + sum{i in CartasEraIII: i >= 12}3*Yte[i,3,'NOR'];

#s.t. utiliRecMarE3T4{i in CartasEraIII, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Yte[i,4,'MAR'] <= recursosDisponibles[3,4,k] + recursosComprados[3,4,k];
s.t. utiliRecMarE3T4{i in CartasEraIII, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Yte[i,4,'MAR']) <= recursosDisponibles[3,4,k] + recursosComprados[3,4,k];

#TURNO 5:
s.t. dispRecE3T5{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[3,5,k] = recursosDisponibles[3,4,k] + sum{i in CartasEraIII}(EspecialidadesEraIII[i,k]*Yte[i,4,'NOR']);# + recursosComprados[3,4,k];
s.t. utilizRecE3T5{i in CartasEraIII, k in TiposDeCosto: i<=2 and k<>'MON'}: CostosEraIII[i,k]*Yte[i,5,'NOR'] <= recursosDisponibles[3,5,k] + recursosComprados[3,5,k];
s.t. monedasDisponiblesE3T5: monedasDisponibles[3,5] = monedasDisponibles[3,4] - gastoMonedas[3,4] + sum{i in CartasEraIII: i >= 12}3*Yte[i,4,'NOR'];

#s.t. utiliRecMarE3T5{i in CartasEraIII, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Yte[i,5,'MAR'] <= recursosDisponibles[3,5,k] + recursosComprados[3,5,k];
s.t. utiliRecMarE3T5{i in CartasEraIII, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Yte[i,5,'MAR']) <= recursosDisponibles[3,5,k] + recursosComprados[3,5,k];

#TURNO 6:
s.t. dispRecE3T6{k in TiposDeCosto: k<>'MON'}: recursosDisponibles[3,6,k] = recursosDisponibles[3,5,k] + sum{i in CartasEraIII}(EspecialidadesEraIII[i,k]*Yte[i,5,'NOR']);# + recursosComprados[3,5,k];
s.t. utilizRecE3T6{i in CartasEraIII, k in TiposDeCosto: i<=2 and k<>'MON'}: CostosEraIII[i,k]*Yte[i,6,'NOR'] <= recursosDisponibles[3,6,k] + recursosComprados[3,6,k];
s.t. monedasDisponiblesE3T6: monedasDisponibles[3,6] = monedasDisponibles[3,5] - gastoMonedas[3,5] + sum{i in CartasEraIII: i >= 12}3*Yte[i,5,'NOR'];


#s.t. utiliRecMarE3T6{i in CartasEraIII, k in MateriaPrima}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]*Yte[i,6,'MAR'] <= recursosDisponibles[3,6,k] + recursosComprados[3,6,k];
s.t. utiliRecMarE3T6{i in CartasEraIII, k in TiposDeCosto: k <> 'MON'}: sum{n in NivelesDeDesarrollo}CostosMaravilla[n,k]- 7*(1 - Yte[i,6,'MAR']) <= recursosDisponibles[3,6,k] + recursosComprados[3,6,k];

s.t. monedasSob: monedasSobrantes = monedasDisponibles[3,6] - gastoMonedas[3,6] + sum{i in CartasEraIII: i >= 12}3*Yte[i,6,'NOR'];

#RECOLECCION DE PUNTOS:
s.t. cantidadGeometricas: Geometricas = sum{j in Turnos}(Yte[9,j,'NOR'] + Yte[10,j,'NOR'] + Yse[12,j,'NOR'] + Ype[16,j,'NOR']);
s.t. geometricas: Geometricas = Yg1 + 2*Yg2 + 3*Yg3 + 4*Yg4;
s.t. soloUnValorGeom: Yg1 + Yg2 + Yg3 + Yg4 <= 1;

s.t. cantidadRuedas: Ruedas = sum{j in Turnos}(Yte[7,j,'NOR'] + Yte[8,j,'NOR'] + Yse[14,j,'NOR'] + Ype[17,j,'NOR']);
s.t. ruedas: Ruedas = Yr1 + 2*Yr2 + 3*Yr3 + 4*Yr4;
s.t. soloUnValorRued: Yr1 + Yr2 + Yr3 + Yr4 <= 1;

s.t. cantidadEscituras: Escrituras = sum{j in Turnos}(Yte[6,j,'NOR'] + Yte[11,j,'NOR'] + Yse[13,j,'NOR'] + Yse[15,j,'NOR'] + Ype[18,j,'NOR']);
s.t. escrituras: Escrituras = Ye1 + 2*Ye2 + 3*Ye3 + 4*Ye4 + 5*Ye5;
s.t. soloUnValorEsc: Ye1 + Ye2 + Ye3 + Ye4 + Ye5 <= 1;

s.t. puntosPorMonedas: puntosMonedas <= (1/3)*monedasSobrantes;

s.t. trioDeSimbolos: TrioDeSimbolos <= 4;
s.t. minGeometricas: TrioDeSimbolos <= Geometricas;
s.t. minRuedas: TrioDeSimbolos <= Ruedas;
s.t. minEscrituras: TrioDeSimbolos <= Escrituras;


#Desarrollo de conflicto al final de cada era.
# 1, 3, 5 es el poder militar del oponente.
# Si tiene tablero ROD (Coloso de Rodas) en nivel 2 tiene +2 en escudos.
# Fin ERA 1
s.t. diferenciaPuntosConflicto1: (sum{i in MilitaresEra1, j in Turnos} EspecialidadesEraI[i,'MIL']*Ype[i, j, 'NOR']) - 1 + 2*YTabNivel2['ROD']= Exc[1] - Def[1];
# Fin ERA 2
s.t. diferenciaPuntosConflicto2: (sum{i in MilitaresEra2, j in Turnos} EspecialidadesEraII[i,'MIL']*Yse[i, j, 'NOR']) - 3 + 2*YTabNivel2['ROD'] = Exc[2] - Def[2];
# Fin ERA 3
s.t. diferenciaPuntosConflicto3: (sum{i in MilitaresEra3, j in Turnos} EspecialidadesEraIII[i,'MIL']*Yte[i, j, 'NOR']) - 5 + 2*YTabNivel2['ROD']= Exc[3] - Def[3];

s.t. minYGano{i in Eras}: 0.001*YGano[i] <= Exc[i];
s.t. maxYGano{i in Eras}: 1000*YGano[i] >= Exc[i];
s.t. minYPerdio{i in Eras}: 0.001*YPerdio[i] <= Def[i];
s.t. maxYPerdio{i in Eras}: 1000*YPerdio[i] >= Def[i];
s.t. unicoResultadoConflicto{i in Eras}: YGano[i] + YPerdio[i] + YEmpate[i] = 1;

#Seleccion de tablero
s.t. unUnicoTablero: sum{i in Tableros} YTablero[i] = 1;

# Verificacion de si el tablero seleccionado alcanzo el nivel 2.
s.t. tableroEnNivel2{i in Tableros}: nivel[2] + YTablero[i] - 2 = Exctab[i] - Deftab[i];
s.t. excesoTablero1{i in Tableros}: 0.01*YTabmay[i] <= Exctab[i];
s.t. excesoTablero2{i in Tableros}: 1000*YTabmay[i] >= Exctab[i];
s.t. defectoTablero1{i in Tableros}: 0.01*YTabmen[i] <= Deftab[i];
s.t. defectoTablero2{i in Tableros}: 1000*YTabmen[i] >= Deftab[i];
s.t. unicaCondicion{i in Tableros}: YTabmen[i] + YTabmay[i] + YTabNivel2[i] = 1;

end;
