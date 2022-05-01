clear,clc,close all

addpath('Funciones')

%CARGAMOS LOS DATOS DE INTERES
rutaFicheros='../01_SeleccionDescriptores/DatosGenerados/';
nombreFichero ='espacio_ccas_circ-trian_cuad.mat';

load([rutaFicheros nombreFichero])


XoIRed = XoI(:,espacioCcas);
YoIRed = YoI;

%% Represnetamos los datos


nombresProblemaOIRed = [];
nombresProblemaOIRed.descriptores = nombreDescriptores(espacioCcas);%solo los 3 que nos interesa
nombresProblemaOIRed.clase = nombreClases;
nombresProblemaOIRed.simbolos= simbolosClases;

funcion_representa_muestras_clasificacion_binaria_con_frontera...
    (XoIRed,YoIRed,nombresProblemaOIRed);

%% Guardamos los datos
save('./DatosGenerados/KNN_circ-trian_cuad.mat','XoIRed','YoIRed','espacioCcas','nombresProblemaOIRed');


