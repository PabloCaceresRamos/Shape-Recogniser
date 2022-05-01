
addpath('Funciones')
addpath('../../Imagenes/Test')
addpath('../../01_GeneracionDatos/DatosGenerados');
addpath('../../02_FaseEntrenamiento/CASOA_MDE_clases2a2/01_CirculoCuadrado/02_DisegnoClasificador/DatosGenerados')
addpath('../../02_FaseEntrenamiento/CASOA_MDE_clases2a2/02_CirculoTriangulo/02_DisegnoClasificador/DatosGenerados')
addpath('../../02_FaseEntrenamiento/CASOA_MDE_clases2a2/03_CuadradoTriangulo/02_DisegnoClasificador/DatosGenerados')
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

load('MDE_circ_cuad.mat');
coeficientesCircCuad= coeficientes_d12;
d12CircCuad= d12;
espacioCcasCircCuad= espacioCcas;
nombresProblemaCircCuad= nombresProblemaOIRed;
XoIRedCircCuad= XoIRed;
YoIRedCircCuad=YoIRed;

load('MDE_circ_trian.mat');
coeficientesCircTrian= coeficientes_d12;
d12CircTrian= d12;
espacioCcasCircTrian= espacioCcas;
nombresProblemaCircTrian= nombresProblemaOIRed;
XoIRedCircTrian= XoIRed;
YoIRedCircTrian=YoIRed;

load('MDE_cuad_trian.mat');
coeficientesCuadTrian= coeficientes_d12;
d12CuadTrian= d12;
espacioCcasCuadTrian= espacioCcas;
nombresProblemaCuadTrian= nombresProblemaOIRed;
XoIRedCuadTrian= XoIRed;
YoIRedCuadTrian=YoIRed;

%% Aplicamos el clasificador para el reconocimiento de cada objeto
%Hago el clasificador para cada caso y luego voy mirando los resultados
%para ver de que tipo es y lo guardo en la variable Y.
[numMuestras, numDescriptores]=size(Z);

Y=[];
for i=1: numMuestras
    %Hacemos el clasificacodr para CircCuad
   XoI=Z(i,espacioCcasCircCuad);
   x1=XoI(1);
   x2=XoI(2);
   x3=XoI(3);
   A=coeficientesCircCuad(1); B=coeficientesCircCuad(2); C=coeficientesCircCuad(3);
   D=coeficientesCircCuad(4);
   d12_manualCircCuad=A*x1+B*x2+C*x3+D;
   %Hacemos el clasificador para CircTrian
    XoI=Z(i,espacioCcasCircTrian);
   x1=XoI(1);
   x2=XoI(2);
   x3=XoI(3);
   A=coeficientesCircTrian(1); B=coeficientesCircTrian(2); C=coeficientesCircTrian(3);
   D=coeficientesCircTrian(4);
   d12_manualCircTrian=A*x1+B*x2+C*x3+D;
   %Hacemos le clasifiacdor para CuadTrian
    XoI=Z(i,espacioCcasCuadTrian);
   x1=XoI(1);
   x2=XoI(2);
   x3=XoI(3);
   A=coeficientesCuadTrian(1); B=coeficientesCuadTrian(2); C=coeficientesCuadTrian(3);
   D=coeficientesCuadTrian(4);
   d12_manualCuadTrian=A*x1+B*x2+C*x3+D;
   
   if( d12_manualCircCuad>=0 && d12_manualCircTrian>=0)
       Y=[Y;1];
   end
   if(d12_manualCircCuad<0 && d12_manualCuadTrian>=0)
       Y=[Y;2];
   end
   if(d12_manualCircTrian<0 && d12_manualCuadTrian<0)
       Y=[Y;3];
   end
   
   
end

%% Representacion de los resultados

[numMuestras, numDescriptores]=size(Z);
nombre{1}='Circulo';
nombre{2}='Cuadrado';
nombre{3}='Triangulo';
for i=1: numMuestras
%Dibujamos la imagen con la figura destacada
figure;
subplot(2,2,1), imshow(nombreImagen), title(nombre(Y(i)));
hold on
[fy,fx]=find(Ietiq ==i);
plot(fx,fy);
hold off

%dibujamos las graficas
subplot(2,2,2), funcion_representa_muestras_clasificacion_binaria_con_frontera...
(XoIRedCircCuad,YoIRedCircCuad,nombresProblemaCircCuad,coeficientesCircCuad)
XoI=Z(i,espacioCcasCircCuad);
    %Dibujamos la figura que evaluamos en la grafica
hold on 
plot3(XoI(1),XoI(2),XoI(3),'ok') 
hold off

subplot(2,2,3), funcion_representa_muestras_clasificacion_binaria_con_frontera...
(XoIRedCircTrian,YoIRedCircTrian,nombresProblemaCircTrian,coeficientesCircTrian)
XoI=Z(i,espacioCcasCircTrian);
    %Dibujamos la figura que evaluamos en la grafica
hold on 
plot3(XoI(1),XoI(2),XoI(3),'ok') 
hold off

subplot(2,2,4), funcion_representa_muestras_clasificacion_binaria_con_frontera...
(XoIRedCuadTrian,YoIRedCuadTrian,nombresProblemaCuadTrian,coeficientesCuadTrian)
XoI=Z(i,espacioCcasCuadTrian);
    %Dibujamos la figura que evaluamos en la grafica
hold on 
plot3(XoI(1),XoI(2),XoI(3),'ok') 
hold off
end







    
