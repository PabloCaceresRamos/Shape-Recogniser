
addpath('Funciones');
addpath('DatosGenerados');
addpath('../../../../01_GeneracionDatos/DatosGenerados');
load('conjunto_datos_estandarizados.mat');
load('nombresProblemas.mat');

XoI = Z((Y ==1 | Y==2),:);
YoI = Y(Y ==1 | Y==2);

nombreClases([3 4 5 6])=[];
simbolosClases([3 4 5 6])=[];
numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

save('./DatosGenerados/espacio_ccas_Aran_Tuer.mat','XoI','YoI','espacioCcas','nombreClases','nombreDescriptores','simbolosClases')
rmpath('Funciones');
rmpath('DatosGenerados');
rmpath('../../../../01_GeneracionDatos/DatosGenerados');