%% Cargamos los datos

clear,clc,close all

addpath('DatosGenerados')
addpath('Funciones')

load conjunto_datos.mat
load nombresProblemas.mat

[numMuestras, numDescriptores]=size(X);
codifClases=unique(Y);
numClases=length(codifClases);

%% Estandarizacion

medias= mean(X);
desviaciones = std(X);
medias(end)=0; %el descriptor de euler no se coloca porque es todo 1
desviaciones(end)=1;
%ponemos la media y la desviacion de euler 0 y 1 porque al hacer la
%normalizacion da el mismo resultado

Z=X;
for i=1:numDescriptores-1
    Z(:,i)=(X(:,i)-medias(i))/desviaciones(i);
end

%% Guardamos informacion
save('./DatosGenerados/conjunto_datos_estandarizados','Z','Y');
save('./DatosGenerados/datos_estandarizacion','medias','desviaciones');



