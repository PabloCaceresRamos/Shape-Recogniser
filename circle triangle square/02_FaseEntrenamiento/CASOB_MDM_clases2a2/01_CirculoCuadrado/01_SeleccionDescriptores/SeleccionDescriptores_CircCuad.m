
addpath('Funciones');
addpath('DatosGenerados');
addpath('../../../../01_GeneracionDatos/DatosGenerados');
load('conjunto_datos_estandarizados.mat');
load('nombresProblemas.mat');

XoI = Z((Y ~=3),1:22);% quitamos los triangulos, y el ultimo esciptor
YoI = Y(Y~=3);% quitamos los triangulos de Y

nombreClases(3)=[];
nombreDescriptores(end)=[];
simbolosClases(end)=[];
numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

save('./DatosGenerados/espacio_ccas_circ_cuad.mat','XoI','YoI','espacioCcas','nombreClases','nombreDescriptores','simbolosClases')
