Problem:    parteb
Rows:       6
Columns:    3
Non-zeros:  12
Status:     OPTIMAL
Objective:  z = 19000 (MAXimum)

   No.   Row name   St   Activity     Lower bound   Upper bound    Marginal
------ ------------ -- ------------- ------------- ------------- -------------
     1 z            B          19000                             
     2 disp_metal   NU           100                         100           100 
     3 disp_plastico
                    B            110                         120 
     4 disp_trabajo_operario
                    NU            70                          70           200 
     5 demanda_cort B             20            20               
     6 demanda_av   NL            25            25                        -200 

   No. Column name  St   Activity     Lower bound   Upper bound    Marginal
------ ------------ -- ------------- ------------- ------------- -------------
     1 cort_b       B             20             0               
     2 av_f         B             25             0               
     3 metal        B             15             0               

Karush-Kuhn-Tucker optimality conditions:

KKT.PE: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.PB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

KKT.DE: max.abs.err = 0.00e+00 on column 0
        max.rel.err = 0.00e+00 on column 0
        High quality

KKT.DB: max.abs.err = 0.00e+00 on row 0
        max.rel.err = 0.00e+00 on row 0
        High quality

End of output
