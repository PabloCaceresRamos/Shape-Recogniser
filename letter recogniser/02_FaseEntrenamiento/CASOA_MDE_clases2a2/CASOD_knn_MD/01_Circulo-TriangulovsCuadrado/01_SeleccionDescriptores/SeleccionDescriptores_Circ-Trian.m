
addpath('Funciones');
addpath('DatosGenerados');
addpath('../../../../01_GeneracionDatos/DatosGenerados');
load('conjunto_datos_estandarizados.mat');
load('nombresProblemas.mat');

XoI = Z(Y==1,:);
XoI = [XoI; Z(Y==4,:)];
YoI = Y;
YoI(Y~=1 & Y ~=4)= [];

nombreClases=nombreClases([1 4]);
simbolosClases=simbolosClases([1 4]);

%numDescriptoresOI = 9;
%[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);
espacioCcas=[5 6 7];
save('./DatosGenerados/espacio_ccas_A_D.mat','XoI','YoI','espacioCcas','nombreClases','nombreDescriptores','simbolosClases')
