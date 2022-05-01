addpath('Funciones');
addpath('DatosGenerados');
addpath('../../../../01_GeneracionDatos/DatosGenerados');
load('conjunto_datos_estandarizados.mat');
load('nombresProblemas.mat');

XoI = Z((Y ==5 | Y==6),1:22);
YoI = Y(Y ==5 | Y==6);

nombreClases([1 2 3 4])=[];
nombreDescriptores(end)=[];
simbolosClases([1 2 3 4])=[];

espacioCcas=[13 15 21];

save('./DatosGenerados/espacio_ccas_TornH_R.mat','XoI','YoI','espacioCcas','nombreClases','nombreDescriptores','simbolosClases')

rmpath('Funciones');
rmpath('DatosGenerados');
rmpath('../../../../01_GeneracionDatos/DatosGenerados');