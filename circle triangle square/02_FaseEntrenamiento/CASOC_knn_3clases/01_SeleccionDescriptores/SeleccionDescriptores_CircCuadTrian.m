
addpath('Funciones');
addpath('DatosGenerados');
addpath('../../../01_GeneracionDatos/DatosGenerados');
load('conjunto_datos_estandarizados.mat');
load('nombresProblemas.mat');

XoI = Z;
YoI = Y;


numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

save('./DatosGenerados/espacio_ccas_circ_cuad_trian.mat','XoI','YoI','espacioCcas','nombreClases','nombreDescriptores','simbolosClases')
