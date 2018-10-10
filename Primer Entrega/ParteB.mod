# V: Cantidad de ubicaciones VIP en m^2
# Vc: Cantidad de ubicaciones VIP comunes en m^2
# Vp: Cantidad de ubicaciones VIP de protocolo en m^2
# G: Cantidad de ubicaciones generales en m^2
# Evc: Cantidad de entradas VIP comun en unidad.
# Evp: Cantidad de entradas VIP de protocolo en unidad.
# Eg: Cantidad de entradas generales en unidad.
# P: Cantidad total de paquetes en unidad.
# Pv: Cantidad de paquetes destinados a ubicaciones VIP.
# Pg: Cantidad de paquetes destinados a ubicaciones Generales.

var V >= 0, integer;
var Vc >= 0, integer;
var Vp >= 0, integer;
var G >= 0, integer;
var Evc >= 0, integer;
var Evp >= 0, integer;
var Eg >= 0, integer;
var P >= 0, integer;
var Pv >= 0, integer;
var Pg >= 0, integer;

maximize z: 1500 * Evc + 800 * Eg - 700 * P;

s.t. predio: V + G <= 8000; #Capacidad m^2
s.t. ubicacionesVip: V = Vc + Vp;
s.t. minProtocolo: Vp >= 100;
s.t. minGenerales: G >= 500;
s.t. maxPaquetes: P <= 800;
s.t. paquetesTotales: P = Pv + Pg;
s.t. paqueteVip: 20*Pv >= V;
s.t. paqueteGeneral: 8*Pg >= Eg;
s.t. ubicEntrVipProto: Vp = Evp;
s.t. ubicEntrVipComun: Vc = Evc;
s.t. ubicGeneral: 2*G = Eg;

end;
