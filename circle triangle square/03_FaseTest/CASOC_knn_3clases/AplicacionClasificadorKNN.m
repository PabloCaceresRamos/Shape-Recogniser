
addpath('Funciones')
addpath('../../Imagenes/Test')
addpath('../../01_GeneracionDatos/DatosGenerados');
addpath('../../02_FaseEntrenamiento/CASOC_knn_3clases/02_DisegnoClasificador/DatosGenerados')
addpath('../../02_FaseEntrenamiento/CASOC_knn_3clases/02_DisegnoClasificador/DatosGenerados')
addpath('../../02_FaseEntrenamiento/CASOC_knn_3clases/02_DisegnoClasificador/DatosGenerados')
%% Sacamos los descriptores de cada figura

X=[];

   nombreImagen='Test2.jpg';
   
  I=imread(nombreImagen);
   
   umbral=graythresh(I);%%%%%%%%%%%%%%%%%%%%puede pedir que la cambiemos en el examen
   
   Ibin=I<255*umbral;
   
   IbinFilt =funcion_elimina_regiones_ruidosas(Ibin);
   
   if sum(IbinFilt(:))>0
      
       [Ietiq,N]=bwlabel(IbinFilt);
       %esta funcion va a devolver los descriptores
       X=funcion_calcula_descriptores_imagenes(Ietiq,N);
       
   end
   
%% Estandarizamos los datos
%Cargamos los datos que utilizamos para entandarizar los descriptores
load('datos_estandarizacion.mat');
%Utilizamos esos datos para estandarizar los descriptores de los datos de
%test
Z=X;
[numMuestras, numDescriptores]=size(X);
for i=1:numDescriptores-1
    Z(:,i)=(X(:,i)-medias(i))/desviaciones(i);
end

%% Cargamos la infromacion para los clasificadores

load('KNN_circ_cuad_trian.mat');

espacioCcasCircCuadTrian= espacioCcas;
nombresProblemaCircCuadTrian= nombresProblemaOIRed;
XoIRedCircCuadTrian= XoIRed;
YoIRedCircCuadTrian=YoIRed;


%% Aplicamos el clasificador para el reconocimiento de cada objeto
%Hago el clasificador para cada caso y luego voy mirando los resultados
%para ver de que tipo es y lo guardo en la variable Y.
[numMuestras, numDescriptores]=size(Z);


ZoI=Z(:,espacioCcasCircCuadTrian);
Y=funcion_knn(ZoI,XoIRedCircCuadTrian,YoIRedCircCuadTrian,5,'Mahalanobis');


%% Representacion de los resultados

[numMuestras, numDescriptores]=size(Z);
nombre{1}='Circulo';
nombre{2}='Cuadrado';
nombre{3}='Triangulo';
for i=1: numMuestras
%Dibujamos la imagen con la figura destacada
figure;
subplot(1,2,1), imshow(nombreImagen), title(nombre(Y(i)));
hold on
[fy,fx]=find(Ietiq ==i);
plot(fx,fy);
hold off

%dibujamos la grafica
subplot(1,2,2), funcion_representa_muestras_clasificacion_binaria_con_frontera...
(XoIRedCircCuadTrian,YoIRedCircCuadTrian,nombresProblemaCircCuadTrian)
XoI=Z(i,espacioCcasCircCuadTrian);
    %Dibujamos la figura que evaluamos en la grafica
hold on 
plot3(XoI(1),XoI(2),XoI(3),'ok') 
hold off

end







    
