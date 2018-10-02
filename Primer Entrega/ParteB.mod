# V: Cantidad de ubicaciones VIP en unidad/m^2
# Vc: Cantidad de ubicaciones VIP comunes en unidad/m^2
# Vp: Cantidad de ubicaciones VIP de protocolo en unidad/m^2
# G: Cantidad de ubicaciones generales en unidad/m^2
# Evc: Cantidad de entradas VIP comun en unidad.
# Evp: Cantidad de entradas VIP de protocolo en unidad.
# Eg: Cantidad de entradas generales en unidad.
# P: Cantidad de paquetes en unidad. 

var V >= 0, integer;
var Vc >= 0, integer;
var Vp >= 0, integer;
var G >= 0, integer;
var Evc >= 0, integer;
var Evp >= 0, integer;
var Eg >= 0, integer;
var P >= 0, integer;

maximize z: 1000 * Evc + 800 * Eg + 0 * Evp - 700 * P;

s.t. predio: V + G <= 8000;
s.t. ubicacionesVip: V = Vc + Vp;
s.t. protocolo: Vp >= 100;
s.t. generales: G >= 500;
s.t. paquetes: P <= 800;
s.t. paqueteVip: 20*P = V;
s.t. paqueteGeneral: 8*P = Eg;
s.t. ubicEntrVipProto: Vp = Evp;
s.t. ubicEntrVipComun: Vc = Evc;
s.t. ubicGeneral: 2*G = Eg; 

end;
