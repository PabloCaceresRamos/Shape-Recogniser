
addpath('Funciones')
addpath('../../Imagenes/Test')
addpath('../../01_GeneracionDatos/DatosGenerados');
addpath('../../02_FaseEntrenamiento/02_MDE_clases2a2/01_ArandelasyTuercas/02_DisegnoClasificador/DatosGenerados')
addpath('../../02_FaseEntrenamiento/03_knn_3clases/02_DisegnoClasificador/DatosGenerados')
addpath('../../02_FaseEntrenamiento/04_knn_2clases/01_TornH_R/02_DisegnoClasificador/DatosGenerados')
%% Sacamos los descriptores de cada figura

X=[];

   nombreImagen='Test01.bmp';
   
  I=imread(nombreImagen);
   
   umbral=graythresh(I);%%%%%%%%%%%%%%%%%%%%puede pedir que la cambiemos en el examen
   
   Ibin=I>255*umbral;
   
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

load('KNN_AlcaL-R_Torn.mat');

espacioCcasAlcaLRTorn = espacioCcas;
nombresProblemaAlcaLRTorn = nombresProblemaOIRed;
XoIRedCircAlcaLRTorn = XoIRed;
YoIRedCircAlcaLRTorn =YoIRed;

load('KNN_TornH_R.mat');

espacioCcasTornH_R= espacioCcas;
nombresProblemaTornH_R= nombresProblemaOIRed;
XoIRedTornH_R= XoIRed;
YoIRedTornH_R=YoIRed;



load('MDE_Aran_Tuer.mat');
coeficientesAran_Tuer= coeficientes_d12;
d12Aran_Tuer= d12;
espacioCcasAran_Tuer= espacioCcas;
nombresProblemaAran_Tuer= nombresProblemaOIRed;
XoIRedAran_Tuer= XoIRed;
YoIRedAran_Tuer=YoIRed;


%% Aplicamos el clasificador para el reconocimiento de cada objeto
%Hago el clasificador para cada caso y luego voy mirando los resultados
%para ver de que tipo es y lo guardo en la variable Y.
[numMuestras, numDescriptores]=size(Z);

Y=[];
for i=1: numMuestras
   if(Z(i,end)==0)%miramos si son arandelas o tuercas por el Nº de Euler
   XoI=Z(i,espacioCcasAran_Tuer);
   x1=XoI(1);
   x2=XoI(2);
   x3=XoI(3);
   A=coeficientesAran_Tuer(1); B=coeficientesAran_Tuer(2); C=coeficientesAran_Tuer(3);
   D=coeficientesAran_Tuer(4);
   d12_manual=A*x1+B*x2+C*x3+D;
    if( d12_manual>=0)
       Y=[Y;1];%circulo
   else
       Y=[Y;2];%triangulo
   end
   else
   ZoI=Z(i,espacioCcasAlcaLRTorn);
   YKNN=funcion_knn(ZoI,XoIRedCircAlcaLRTorn,YoIRedCircAlcaLRTorn,3,'Euclidea');
   if(YKNN==3 || YKNN==4)
       Y=[Y;YKNN];
   else
       ZZoI=Z(i,espacioCcasTornH_R);
       YKNN2=funcion_knn(ZZoI,XoIRedTornH_R,YoIRedTornH_R,5,'Mahalanobis');
       Y=[Y;YKNN2];
   end
       
   end
end

%% Representacion de los resultados

[numMuestras, numDescriptores]=size(Z);
nombreClases{1}='Arandelas';
nombreClases{2}='Tuercas';
nombreClases{3}='Alcayatas-Lisas';
nombreClases{4}='Alcayatas-Roscadas';
nombreClases{5}='Tornillos-Cabeza-Hexagonal';
nombreClases{6}='Tornillos-Roscados';
for i=1: numMuestras
%Dibujamos la imagen con la figura destacada
figure;
subplot(2,2,1), imshow(nombreImagen), title(nombreClases(Y(i)));
hold on
[fy,fx]=find(Ietiq ==i);
plot(fx,fy);
hold off

%dibujamos la grafica
subplot(2,2,2), funcion_representa_muestras_clasificacion_binaria_con_frontera...
(XoIRedCircAlcaLRTorn,YoIRedCircAlcaLRTorn,nombresProblemaAlcaLRTorn)
XoI=Z(i,espacioCcasAlcaLRTorn);
    %Dibujamos la figura que evaluamos en la grafica
hold on 
plot3(XoI(1),XoI(2),XoI(3),'ok') 
hold off

subplot(2,2,3), funcion_representa_muestras_clasificacion_binaria_con_frontera...
(XoIRedTornH_R,YoIRedTornH_R,nombresProblemaTornH_R)
XoI=Z(i,espacioCcasTornH_R);
    %Dibujamos la figura que evaluamos en la grafica
hold on 
plot3(XoI(1),XoI(2),XoI(3),'ok') 
hold off


subplot(2,2,4), funcion_representa_muestras_clasificacion_binaria_con_frontera...
(XoIRedAran_Tuer,YoIRedAran_Tuer,nombresProblemaAran_Tuer,coeficientesAran_Tuer)
XoI=Z(i,espacioCcasAran_Tuer);
    %Dibujamos la figura que evaluamos en la grafica
hold on 
plot3(XoI(1),XoI(2),XoI(3),'ok') 
hold off

end







    
