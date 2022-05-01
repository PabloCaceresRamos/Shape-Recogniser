%% Vamos a calcular los descriptores de Hu y el descriptor Exten independiente de la rotacion

addpath('Funciones')
addpath('../Imagenes/Entrenamiento')
addpath('DatosGenerados')

nombre{1}='A';
nombre{2}='B';
nombre{3}='C';
nombre{4}='D';
nombre{5}='E';

%vamos a leer los datos de las imagenes sacando los descriptores de cada
%figura encontrada (extension 8descriptoresHu)

%El descriptor de extension consiste en dividir el area del objeto entre el
%rectangulo menor que rodea a ese objeto, que se calcula, cogiendo la
%xminima del objeto, la xmaxima, la yminima y la ymaxima y formamos un
%resctangulo.

numClases= length(nombre);
numImagenesPorClase=2;
X=[];
Y=[];

for i= 1:numClases
    for j=1:numImagenesPorClase
   nombreImagen=[nombre{i} num2str(j,'%2d') '.tif'];
   
  I=imread(nombreImagen);
   
   umbral=graythresh(I);%%%%%%%%%%%%%%%%%%%%puede pedir que la cambiemos en el examen
   
   Ibin=I<255*umbral;
   
   IbinFilt =funcion_elimina_regiones_ruidosas(Ibin);
   
   if sum(IbinFilt(:))>0
      
       [Ietiq,N]=bwlabel(IbinFilt);
       %esta funcion va a devolver los descriptores
       XImagen=funcion_calcula_descriptores_imagenes(Ietiq,N);
       YImagen=i*ones(N,1);
       
   else
       XImagen=[];
       YImagen=[];
       
   end
    
   X=[X; XImagen];
   Y=[Y; YImagen];
    end
end

%% 2.- Generacion variables y nombresProblemas
nombreDescriptores{1}='Compacticidad';
nombreDescriptores{2}='Excentricidad';
nombreDescriptores{3}='Solidez';
nombreDescriptores{4}='Extension';
nombreDescriptores{5}='Extension Invariante Rotacion';
nombreDescriptores{6}='Hu Numero 1';
nombreDescriptores{7}='Hu Numero 2';
nombreDescriptores{8}='Hu Numero 3';
nombreDescriptores{9}='Hu Numero 4';
nombreDescriptores{10}='Hu Numero 5';
nombreDescriptores{11}='Hu Numero 6';
nombreDescriptores{12}='Hu Numero 7';
nombreDescriptores{13}='DF Numero 1';
nombreDescriptores{14}='DF Numero 2';
nombreDescriptores{15}='DF Numero 3';
nombreDescriptores{16}='DF Numero 4';
nombreDescriptores{17}='DF Numero 5';
nombreDescriptores{18}='DF Numero 6';
nombreDescriptores{19}='DF Numero 7';
nombreDescriptores{20}='DF Numero 8';
nombreDescriptores{21}='DF Numero 9';
nombreDescriptores{22}='DF Numero 10';
nombreDescriptores{23}='Numero de Euler';
   
nombreClases{1}='A';
nombreClases{2}='B';
nombreClases{3}='C';
nombreClases{4}='D';
nombreClases{5}='E';
simbolosClases={'*r','*b','*g','*k','*y'};

%% 3.- Guardar conjunto de datos y nombres del problema

save('./Datosgenerados/conjunto_datos','X','Y');
save('./DatosGenerados/nombresProblemas','nombreClases','nombreDescriptores','simbolosClases');
