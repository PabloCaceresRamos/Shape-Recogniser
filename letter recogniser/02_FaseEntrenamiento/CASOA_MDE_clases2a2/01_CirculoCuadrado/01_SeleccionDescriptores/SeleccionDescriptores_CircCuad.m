
addpath('Funciones');
addpath('DatosGenerados');
addpath('../../../../01_GeneracionDatos/DatosGenerados');
load('conjunto_datos_estandarizados.mat');
load('nombresProblemas.mat');

XoI = Z(Y==3,:);
XoI = [XoI; Z(Y==5,:)];
YoI = Y;
YoI(Y~=3 & Y ~=5)= [];

nombreClases=nombreClases([3 5]);
simbolosClases=simbolosClases([3 5]);

numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

save('./DatosGenerados/espacio_ccas_C_E.mat','XoI','YoI','espacioCcas','nombreClases','nombreDescriptores','simbolosClases')
