*! 1.0 Alvaro Carril 14feb2018
program define multimport, rclass
syntax [using], ///
	EXTensions(string) ///
	[ ///
		DIRectory(string) ///
		IMPORToptions(string asis) ///
		exclude(string asis) ///
		force clear ///
	]

*-------------------------------------------------------------------------------
* Check valid program input
*-------------------------------------------------------------------------------

// Check that current data is saved or that 'clear' is specified
local clearpos = strpos(`"`importoptions'"', "clear")
if `c(changed)' == 1 & ("`clear'" != "clear" & `clearpos' == 0) {
	di as error "no; data in memory would be lost"
	exit 4
}

// Add 'clear' option to `importoptions' if `clear' is specified
if "`clear'" == "clear" & `clearpos' == 0  {
	local importoptions `importoptions' clear
}

*-------------------------------------------------------------------------------
* Parse program options
*-------------------------------------------------------------------------------

// Parse files to import, collecting all files with `extensions' of `directory'
foreach ext of local extensions {
	local add : dir "`directory'" files "*.`ext'", respectcase
	local files `files' `"`add'"'
}

// Exclude any specific files
local files : list files - exclude

// List files to import and confirm
if "`force'" != "force" {
	di as text "Files to import:"
	foreach f of local files {
		di "`f'"
	}
	di as result "Proceed? (yes/no)" _request(_yesno) // it doesn't produce a local without underscore
	if "`yesno'" != "yes" {
		di as error "cancelled"
		exit
	}
}


*-------------------------------------------------------------------------------
* Import and append
*-------------------------------------------------------------------------------

tempfile something

// Import all files
foreach f of local files {
	di as text "importing '`f''"
	import delimited "Data/Raw/Mineduc/Docentes/`f'" , `importoptions'
	append using `something'
}

end
