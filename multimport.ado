*! 0.1 Alvaro Carril 14feb2018
program define multimport
syntax [using], ///
	DIRectory(string) EXTensions(string) [IMPORToptions(string asis) force]

*-------------------------------------------------------------------------------
* Parse program input
*-------------------------------------------------------------------------------

if "`clear'" != "clear" {

}

*-------------------------------------------------------------------------------
* Parse program options
*-------------------------------------------------------------------------------

// Parse files to import, collecting all files with `extensions' of `directory'
foreach ext of local extensions {
	local add : dir "`directory'" files "*.`ext'", respectcase
	local files `files' `"`add'"' 
}

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

// Create empty dataset

// Import all files
foreach f of local files {
	di as text "importing '`f''"
	import delimited "Data/Raw/Mineduc/Docentes/`f'" , `importoptions'
}

end
