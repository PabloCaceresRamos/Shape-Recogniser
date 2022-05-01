%% Vamos a calcular los descriptores de Hu y el descriptor Exten independiente de la rotacion

addpath('Funciones')
addpath('DatosGenerados')

%%  Generacion variables y nombresProblemas
nombreDescriptores{1}='Compacticidad';
nombreDescriptores{2}='Excentricidad';
nombreDescriptores{3}='Solidez';
nombreDescriptores{4}='Extension';
nombreDescriptores{5}='Extension Invariante Rotacion';
nombreDescriptores{6}='Hu Numero 1';
nombreDescriptores{7}='Hu Numero 2';
nombreDescriptores{8}='Hu Numero 3';
nombreDescriptores{9}='Hu Numero 4';
nombreDescriptores{10}='Hu Numero 5';
nombreDescriptores{11}='Hu Numero 6';
nombreDescriptores{12}='Hu Numero 7';
nombreDescriptores{13}='DF Numero 1';
nombreDescriptores{14}='DF Numero 2';
nombreDescriptores{15}='DF Numero 3';
nombreDescriptores{16}='DF Numero 4';
nombreDescriptores{17}='DF Numero 5';
nombreDescriptores{18}='DF Numero 6';
nombreDescriptores{19}='DF Numero 7';
nombreDescriptores{20}='DF Numero 8';
nombreDescriptores{21}='DF Numero 9';
nombreDescriptores{22}='DF Numero 10';
nombreDescriptores{23}='Numero de Euler';
   
nombreClases{1}='Arandelas';
nombreClases{2}='Tuercas';
nombreClases{3}='Alcayatas-Lisas';
nombreClases{4}='Alcayatas-Roscadas';
nombreClases{5}='Tornillos-Cabeza_Hexagonal';
nombreClases{6}='Tornillos-Roscados';
simbolosClases={'*r','*b','*g','*y','*k','*c'};

%% 3.- Guardar conjunto de datos y nombres del problema

save('./DatosGenerados/nombresProblemas','nombreClases','nombreDescriptores','simbolosClases');
