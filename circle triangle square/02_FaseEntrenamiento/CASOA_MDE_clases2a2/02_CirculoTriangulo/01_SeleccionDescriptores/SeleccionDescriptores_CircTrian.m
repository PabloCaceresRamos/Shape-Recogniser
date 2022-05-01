
addpath('Funciones');
addpath('DatosGenerados');
addpath('../../../../01_GeneracionDatos/DatosGenerados');
load('conjunto_datos_estandarizados.mat');
load('nombresProblemas.mat');

XoI = Z((Y ~=2),1:22);% quitamos los cuadrado, y el ultimo esciptor
YoI = Y(Y~=2);% quitamos los cuadrado de Y

nombreClases(2)=[];
nombreDescriptores(end)=[];
simbolosClases(end)=[];
numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

save('./DatosGenerados/espacio_ccas_circ_trian.mat','XoI','YoI','espacioCcas','nombreClases','nombreDescriptores','simbolosClases')
