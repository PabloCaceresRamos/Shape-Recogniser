
addpath('Funciones')
addpath('../../Imagenes/Test')
addpath('../../01_GeneracionDatos/DatosGenerados');
addpath('../../02_FaseEntrenamiento/CASOA_MDE_clases2a2/01_CirculoCuadrado/02_DisegnoClasificador/DatosGenerados')
addpath('../../02_FaseEntrenamiento/CASOD_knn_MD/01_Circulo-TriangulovsCuadrado/02_DisegnoClasificador/DatosGenerados')
%% Sacamos los descriptores de cada figura

X=[];

   nombreImagen='E3.tif';
   
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

load('KNN_A_D.mat');

espacioCcasCircCuadTrian= espacioCcas;
nombresProblemaCircCuadTrian= nombresProblemaOIRed;
XoIRedCircCuadTrian= XoIRed;
YoIRedCircCuadTrian=YoIRed;


load('MDE_C_E');
coeficientesCircTrian= coeficientes_d12;
d12CircTrian= d12;
espacioCcasCircTrian= espacioCcas;
nombresProblemaCircTrian= nombresProblemaOIRed;
XoIRedCircTrian= XoIRed;
YoIRedCircTrian=YoIRed;


%% Aplicamos el clasificador para el reconocimiento de cada objeto
%Hago el clasificador para cada caso y luego voy mirando los resultados
%para ver de que tipo es y lo guardo en la variable Y.
[numMuestras, numDescriptores]=size(Z);


%ZoI=Z(:,espacioCcasCircCuadTrian);
%YKNN=funcion_knn(ZoI,XoIRedCircCuadTrian,YoIRedCircCuadTrian,5,'Mahalanobis');

Y=[];
%Si no es un cuadrado, miro si es un triangulo o un circulo
for i=1: numMuestras
    if(Z(i,end)~=-1)
        if(Z(i,end)==0)
       XoI=[Z(i,espacioCcasCircCuadTrian)];
       Y=[Y;funcion_knn(XoI,XoIRedCircCuadTrian,YoIRedCircCuadTrian,5,'Mahalanobis');];
        end
        if(Z(i,end)==1)
       XoI=Z(i,espacioCcasCircTrian);
       x1=XoI(1);
       x2=XoI(2);
       x3=XoI(3);
       A=coeficientesCircTrian(1); B=coeficientesCircTrian(2); C=coeficientesCircTrian(3);
       D=coeficientesCircTrian(4);
       d12_manualCircTrian=A*x1+B*x2+C*x3+D;
       
       if( d12_manualCircTrian>=0)
           Y=[Y;3];%circulo
       else
           Y=[Y;5];%triangulo
       end
        end
    else
       Y=[Y;2];%No se hace el clasificador y se queda en cuadrado
    end
end


%% Representacion de los resultados

[numMuestras, numDescriptores]=size(Z);

nombre{1}='A';
nombre{2}='B';
nombre{3}='C';
nombre{4}='D';
nombre{5}='E';

for i=1: numMuestras
%Dibujamos la imagen con la figura destacada
figure;
subplot(1,3,1), imshow(nombreImagen), title(nombre(Y(i)));
hold on
[fy,fx]=find(Ietiq ==i);
plot(fx,fy);
hold off

%dibujamos la grafica
subplot(1,3,2), funcion_representa_muestras_clasificacion_binaria_con_frontera...
(XoIRedCircCuadTrian,YoIRedCircCuadTrian,nombresProblemaCircCuadTrian)
XoI=Z(i,espacioCcasCircCuadTrian);
    %Dibujamos la figura que evaluamos en la grafica
hold on 
plot3(XoI(1),XoI(2),XoI(3),'ok') 
hold off

subplot(1,3,3), funcion_representa_muestras_clasificacion_binaria_con_frontera...
(XoIRedCircTrian,YoIRedCircTrian,nombresProblemaCircTrian,coeficientesCircTrian)
XoI=Z(i,espacioCcasCircTrian);
    %Dibujamos la figura que evaluamos en la grafica
hold on 
plot3(XoI(1),XoI(2),XoI(3),'ok') 
hold off

end






    
