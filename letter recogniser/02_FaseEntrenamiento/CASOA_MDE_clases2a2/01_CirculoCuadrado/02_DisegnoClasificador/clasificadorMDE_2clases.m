clear,clc,close all

addpath('Funciones')

%CARGAMOS LOS DATOS DE INTERES
rutaFicheros='../01_SeleccionDescriptores/DatosGenerados/';
nombreFichero ='espacio_ccas_C_E.mat';

load([rutaFicheros nombreFichero])

%% PREPARAMOS LA INFORMACIÓN LEIDA

XoIRed = XoI(:,espacioCcas);
YoIRed = YoI;

%% Represnetamos muestras para escoger clasificador

nombresProblemaOIRed = [];
nombresProblemaOIRed.descriptores = nombreDescriptores(espacioCcas);%solo los 3 que nos interesa
nombresProblemaOIRed.clase = nombreClases;
nombresProblemaOIRed.simbolos= simbolosClases;

funcion_representa_muestras_clasificacion_binaria_con_frontera...
    (XoIRed,YoIRed,nombresProblemaOIRed);
%% CLASIFICADOR MDE
%como las muestras estan muy lejos, da igual que clasificador utilicemos

[d1, d2, d12, coeficientes_d12, M]=...
funcion_calcula_funciones_decision_MDE_clasificacion_binaria(XoIRed,YoIRed);

%% Represnetamos muestras y plano del clasificador

funcion_representa_muestras_clasificacion_binaria_con_frontera...
    (XoIRed,YoIRed,nombresProblemaOIRed,coeficientes_d12);
%% Guardamos los datos
save('./DatosGenerados/MDE_C_E.mat','XoIRed','YoIRed','espacioCcas','nombresProblemaOIRed','coeficientes_d12','d12');





