
addpath('Funciones');
addpath('DatosGenerados');
addpath('../../../../01_GeneracionDatos/DatosGenerados');
load('conjunto_datos_estandarizados.mat');
load('nombresProblemas.mat');

XoI = Z;
YoI = Y;
YoI(YoI==3) = 1; %Los triangulos lo tratamos como circulos

nombreClases(3)=[];
nombreClases(1)={'Circulo-Triangulo'}
nombreDescriptores(end)=[];
simbolosClases(end)=[];

numDescriptoresOI = 9;
[espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);

save('./DatosGenerados/espacio_ccas_circ-trian_cuad.mat','XoI','YoI','espacioCcas','nombreClases','nombreDescriptores','simbolosClases')
