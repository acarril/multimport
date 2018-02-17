// Paths
if "`c(hostname)'" == "xps15" {
  cd "/home/alvaro/GDrive/TeacherQuality"
  adopath ++ ~/ado/personal/multimport
}
if "`c(hostname)'" == "DigitalStorm-PC" cd "C:\Users\alvaro\Google Drive\TeacherQuality"

discard 

//
multimport delimited, dir(Data/Raw/Mineduc/Docentes/Publica)
