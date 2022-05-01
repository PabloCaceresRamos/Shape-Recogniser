
addpath('Funciones');
addpath('DatosGenerados');
addpath('../../../01_GeneracionDatos/DatosGenerados');
load('conjunto_datos_estandarizados.mat');
load('nombresProblemas.mat');

XoI = Z((Y ~=1 & Y~=2),1:22);
YoI = Y(Y ~=1 & Y~=2);
YoI(YoI==6)=5;

nombreClases([1 2 6])=[];
nombreClases(3)={'Tornillos'};
nombreDescriptores(end)=[];
simbolosClases([1 2 6])=[];

espacioCcas=[8 18 21];
save('./DatosGenerados/espacio_ccas_AlcaL-R_Torn.mat','XoI','YoI','espacioCcas','nombreClases','nombreDescriptores','simbolosClases')

rmpath('Funciones');
rmpath('DatosGenerados');
rmpath('../../../01_GeneracionDatos/DatosGenerados');
