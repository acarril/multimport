*! 1.0 Alvaro Carril 14feb2018
program define multimport, rclass
syntax [using], ///
	[ ///
		EXTensions(string) ///
		DIRectory(string) ///
		IMPORToptions(string asis) ///
		APPENDoptions(string asis) ///
		exclude(string asis) ///
		include(string asis) ///
		force clear ///
	]

*-------------------------------------------------------------------------------
* Check valid program input
*-------------------------------------------------------------------------------

// Assert that either extension() or include() are specified
if "`extensions'" == "" & `"`include'"' == "" {
	di as error "you must either specify an extension() or specific files to include()"
	exit 198
}

// Check that current data is saved or that 'clear' is specified
local clearpos = strpos(`"`importoptions'"', "clear")
if `c(changed)' == 1 & ("`clear'" != "clear" & `clearpos' == 0) {
	di as error "no; data in memory would be lost"
	exit 4
}

*-------------------------------------------------------------------------------
* Parse program options
*-------------------------------------------------------------------------------

// Parse files to import, collecting all files with `extensions' of `directory'
foreach ext of local extensions {
	local add : dir "`directory'" files "*.`ext'", respectcase
	local files `files' `"`add'"'
}

// Include any specific files
local files : list files | include

// Exclude any specific files
local files : list files - exclude

// Add final forward slash to directory if not empty and it doesn't have it
local lastdirchar = substr("`directory'", -1, .)
if "`lastdirchar'" != "/" & "`directory'" != "" local directory `directory'/

// List files to import and confirm
if "`force'" != "force" {
	di as text "Files to import:"
	foreach f of local files {
		di "`f'"
	}
	di as result "Proceed? (yes/no)" _request(_yesno) // it doesn't produce a local without underscore
	if "`yesno'" != "yes" exit 1
}

// Add 'clear' option to `importoptions' if `clear' is specified
if "`clear'" == "clear" & `clearpos' == 0  {
	local importoptions `importoptions' clear
}



*-------------------------------------------------------------------------------
* Import and append
*-------------------------------------------------------------------------------

// Create final dataset
clear
tempfile something
qui save `something', emptyok

// Import all files
foreach f of local files {
	di as text "importing '`f''..."
	import delimited "`directory'`f'" , `importoptions'
	append using `something' , `appendoptions'
	qui save `something', replace 
}

end
