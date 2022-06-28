

path = GETENV('DMSP_PROGRAM_PATH')
IF ~STRMATCH(path, '*/') THEN $
	SETENV, 'DMSP_PROGRAM_PATH=' + path + '/'

path = GETENV('DMSP_DATA_PATH')
IF ~STRMATCH(path, '*/') THEN $
	SETENV, 'DMSP_DATA_PATH=' + path + '/'


.r dmsp__define
.r dmsp::fileurl
.r dmsp::filename
.r dmsp::file_test
.r dmsp::download
.r dmsp::load_ssj
.r dmsp::load_ssm
.r dmsp::itemize
.r dmsp::tplotvar
.r dmsp_load

 
