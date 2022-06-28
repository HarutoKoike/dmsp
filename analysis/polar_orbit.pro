


PRO polar_orbit


d_mlt  = 0.5
d_mlat = 0.5
n_mlt  = (24. - 0.) / d_mlt
n_mlat = (90. - 70.) / d_mlat
;
mlt_grid  = FINDGEN(n_mlt + 1) / n_mlt * (18. - 6.) + 6.
mlat_grid = FINDGEN(n_mlat + 1)  / n_mlat * (90. - 70.)  + 70.


counter      = LONARR(n_mlt, n_mlat)


f = 16
FOR yr = 2010, 2020 DO BEGIN  	
	;
	FOR mon = 1, 12 DO BEGIN
	;
		FOREACH dy, dayarr(yr, mon) DO BEGIN
      ;
      d = dmsp_load(f, yr, mon, dy) 
      IF ISA(d, 'INT') THEN CONTINUE
      ;
      idx_polar = WHERE(d.mlat GE 70., count) 
      IF count EQ 0 THEN CONTINUE
			;
			start_polar = idx_polar[WHERE([idx_polar, 0] - [0, idx_polar] GE 4000.) ]
			end_polar   = idx_polar[WHERE([idx_polar, 0] - [0, idx_polar] GE 4000.) - 1]
			start_polar = [idx_polar[0], start_polar]
			end_polar   = [end_polar, idx_polar[-1]]
			;
			FOR i = 0, N_ELEMENTS(start_polar) - 1 DO BEGIN
				mlt  = d.mlt[start_polar[i]:end_polar[i]]
				mlat = d.mlat[start_polar[i]:end_polar[i]]
				;
        count_buff = INTARR(n_mlt, n_mlat)
				FOR j = 0, n_mlt - 1 DO BEGIN
					FOR k = 0, n_mlat - 1 DO BEGIN
						dum = WHERE( mlt GE mlt_grid[j] AND mlt LT mlt_grid[j+1] AND $
						             mlat GE mlat_grid[k] AND mlat LT mlat_grid[k+1], count)
						count_buff[j, k] = count 						 
					ENDFOR
				ENDFOR
				count_buff = count_buff GE 1
				counter += count_buff
				;
			ENDFOR
			;
		ENDFOREACH
		;
	ENDFOR
	;
ENDFOR


fn = 'f' + string(f, format='(i02)') + '.sav'
save, counter, 'f16_all.sav'


END



