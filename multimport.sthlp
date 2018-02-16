{smcl}
{* *! version 1.0 15feb2018}{...}
{vieweralsosee "[R] areg" "help areg"}{...}
{vieweralsosee "[R] xtreg" "help xtreg"}{...}
{vieweralsosee "[R] ivregress" "help ivregress"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "ivreg2" "help ivreg2"}{...}
{vieweralsosee "ivregress" "help ivregress"}{...}
{vieweralsosee "reg2hdfe" "help reg2hdfe"}{...}
{vieweralsosee "a2reg" "help a2reg"}{...}
{viewerjumpto "Syntax" "multimport##syntax"}{...}
{viewerjumpto "Description" "multimport##description"}{...}
{viewerjumpto "Options" "multimport##options"}{...}
{viewerjumpto "Postestimation Syntax" "multimport##postestimation"}{...}
{viewerjumpto "Remarks" "multimport##remarks"}{...}
{viewerjumpto "Examples" "multimport##examples"}{...}
{viewerjumpto "Stored results" "multimport##results"}{...}
{viewerjumpto "Author" "multimport##contact"}{...}
{viewerjumpto "Updates" "multimport##updates"}{...}
{viewerjumpto "Acknowledgements" "multimport##acknowledgements"}{...}
{viewerjumpto "References" "multimport##references"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{cmd:multimport} {hline 1}}Import and append multiple excel or delimited files{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2} {cmd:multimport}
{cmd:}{it:{help import:import_method}}
{cmd:,} [{opth dir:ectory(dir:filespec)} {opth ext:ension(multimport##extension:ext1 [ext2 ...])} {opth in:clude(filename:file1 [file2 ...])} {help multimport##options:options}] {p_end}

{phang}
{it:import_method} is the method to use for reading non-Stata data into memory (see {helpb import:[D] import}); currently {cmd:delimited} and {cmd:excel} are supported{p_end}

{phang}
{it:filespec} is any valid Mac, Unix, or Windows path (see {helpb dir:[D] dir}){p_end}


{marker opt_summary}{...}
{synoptset 36 tabbed}{...}
{synopthdr}
{synoptline}
{p2coldent:* {opth dir:ectory(dir:filespec)}}directory of files to import; if not specified, it defaults to the current working directory{p_end}
{synopt : {opth ext:ensions(multimport##extension:ext1 [ext2 ...])}}override file extension(s) scanned in {opt directory(filespec)}; if not specified, sensible defaults are inferred from {it:import_method}{p_end}
{p2coldent:* {opth inc:lude(filename:file1 [file2 ...])}}specific filenames to import{p_end}
{synopt : {opth exc:lude(filename:file1 [file2 ...])}}specific filenames to exclude from import{p_end}
{synopt : {opth import:options(import:import_method_opts)}}pass options to {helpb import:[D] import {it:import_method}}{p_end}
{synopt : {opth append:options(append:append_method_opts)}}pass options to {helpb append:[D] append}{p_end}
{synopt :{opt force}}skip user confirmation prompt{p_end}
{synopt :{opt clear}}replace data in memory{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}* {opt directory(filespec)} and/or {opt include(file1 [file2 ...])} are required.{p_end}


{marker description}{...}
{title:Description}

{pstd}
{cmd:multimport} is a simple tool for importing multiple non-Stata data into memory, appending them automatically.
According to the specified {it:import_method}, it works similarly to {help import_delimited:import delimited} or {help import_excel:import excel}.
However, it automatically scans the directory specified in {opt directory(filespec)}, looking for all files with extensions that are inferred from {it:import_method}:{p_end}
{p2col 8 12 12 2: -}{cmd:multimport excel} looks for *.xls and *.xlsx files.{p_end}
{p2col 8 12 12 2: -}{cmd:multimport delimited} looks for *.csv files.{p_end}
{pstd}
These defaults may be overridden with the {opt extensions(ext1 [ext2 ...])} option.

{pstd}
{cmd:multimport} will list all files that will be imported and ask the user for confirmation before continuing, unless the {opt force} option is specified to override this prompt.
The program will import and append all listed files, generating a new variable {cmd:_filename} indicating the source filename.
Additional optiones may be passed to {helpb import:[D] import {it:import_method}} and {helpb append:[D] append} using {opt importoptions(import_method_opts)} and {opt appendoptions(append_opts)}, respectively.

{pstd}
Specific files in {opt directory(filespec)} may be excluded from the import with the {opt exclude(file1 [file2 ...])} option.
Alternatively, a specific list of files to be imported may be indicated with the {opt include(file1 [file2 ...])} option.


{marker options}{...}
{title:Options}

{phang}
{opth dir:ectory(dir:filespec)} directory where files to be imported are located. If not specified, it will default to the current working directory.

{phang}
{opth ext:ensions(multimport##extension:ext1 [ext2 ...])} overrides the default file extensions of files that {cmd:multimport} will import.
By default, {cmd:multimport} scans the directory specified in {opt directory(filespec)}, looking for all files with extensions that are inferred from {it:import_method}:{p_end}

{p2col 8 12 12 2:}{cmd:multimport excel} looks for *.xls and *.xlsx files.{p_end}
{p2col 8 12 12 2:}{cmd:multimport delimited} looks for *.csv files.{p_end}
{pstd}

{pmore}
These default extensions can be modified with the {opth ext:ension(multimport##extension:ext1 [ext2 ...])} option. For example, in order to import delimited files that are stored both as *.csv or *.txt files with{p_end}

{p2col 8 12 12 2:}{cmd:. multimport delimited, extensions(csv txt)}{p_end}

{phang}
{opth res:iduals(newvar)} will save the regression residuals in a new variable.

{pmore}
This is a superior alternative than running {cmd:predict, resid} afterwards as it's faster and doesn't require saving the fixed effects.


{marker examples}{...}
{title:Examples}

{hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Simple case - one fixed effect{p_end}
{phang2}{cmd:. multimport price weight length, absorb(rep78)}{p_end}
{hline}

{pstd}As above, but also compute clustered standard errors{p_end}
{phang2}{cmd:. multimport price weight length, absorb(rep78) vce(cluster rep78)}{p_end}
{hline}

{pstd}Two and three sets of fixed effects{p_end}
{phang2}{cmd:. webuse nlswork}{p_end}
{phang2}{cmd:. multimport ln_w grade age ttl_exp tenure not_smsa south , absorb(idcode year)}{p_end}
{phang2}{cmd:. multimport ln_w grade age ttl_exp tenure not_smsa south , absorb(idcode year occ)}{p_end}
{hline}

{title:Advanced examples}

{pstd}Save the FEs as variables{p_end}
{phang2}{cmd:. multimport ln_w grade age ttl_exp tenure not_smsa south , absorb(FE1=idcode FE2=year)}{p_end}

{pstd}Report nested F-tests{p_end}
{phang2}{cmd:. multimport ln_w grade age ttl_exp tenure not_smsa south , absorb(idcode year) nested}{p_end}

{pstd}Do AvgE instead of absorb() for one FE{p_end}
{phang2}{cmd:. multimport ln_w grade age ttl_exp tenure not_smsa south , absorb(idcode year) avge(occ)}{p_end}
{phang2}{cmd:. multimport ln_w grade age ttl_exp tenure not_smsa south , absorb(idcode year) avge(AvgByOCC=occ)}{p_end}

{pstd}Check that FE coefs are close to 1.0{p_end}
{phang2}{cmd:. multimport ln_w grade age ttl_exp tenure not_smsa , absorb(idcode year) check}{p_end}

{pstd}Save first mobility group{p_end}
{phang2}{cmd:. multimport ln_w grade age ttl_exp tenure not_smsa , absorb(idcode occ) group(mobility_occ)}{p_end}

{pstd}Factor interactions in the independent variables{p_end}
{phang2}{cmd:. multimport ln_w i.grade#i.age ttl_exp tenure not_smsa , absorb(idcode occ)}{p_end}

{pstd}Interactions in the absorbed variables (notice that only the {it:#} symbol is allowed){p_end}
{phang2}{cmd:. multimport ln_w grade age ttl_exp tenure not_smsa , absorb(idcode#occ)}{p_end}

{pstd}Interactions in both the absorbed and AvgE variables (again, only the {it:#} symbol is allowed){p_end}
{phang2}{cmd:. multimport ln_w grade age ttl_exp not_smsa , absorb(idcode#occ) avge(tenure#occ)}{p_end}

{pstd}IV regression{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. multimport price weight (length=head), absorb(rep78)}{p_end}
{phang2}{cmd:. multimport price weight (length=head), absorb(rep78) first}{p_end}
{phang2}{cmd:. multimport price weight (length=head), absorb(rep78) ivsuite(ivregress)}{p_end}

{pstd}Factorial interactions{p_end}
{phang2}{cmd:. multimport price weight (length=head), absorb(rep78)}{p_end}
{phang2}{cmd:. multimport price weight length, absorb(rep78 turn##c.price)}{p_end}


{marker results}{...}
{title:Stored results}

{pstd}
{cmd:multimport} stores the following in {cmd:r()}:

{synoptset 24 tabbed}{...}
{syntab:Macros}
{synopt:{cmd:r(directory)}}directory as typed{p_end}
{synopt:{cmd:r(files)}}list of imported filenames{p_end}
{p2colreset}{...}


{marker contact}{...}
{title:Author}

{pstd}Alvaro Carril{break}
National Bureau of Economic Research{break}
Email: {browse "mailto:alvaroc@nber.org":alvaroc@nber.org}
{p_end}
