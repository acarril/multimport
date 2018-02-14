cap program drop multimport
program define multimport
syntax [using], DIRectory(string) EXTension(string) [importoptions(string asis)]

local files : dir "`directory'" files "*.`extension'", respectcase
foreach f of local files {
	import delimited "Data/Raw/Mineduc/Docentes/`f'" , `importopts'
}

end
