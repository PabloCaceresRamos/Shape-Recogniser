function [d1_mCov_de_cada_clase,d2_mCov_de_cada_clase,d12,coeficiente_d12,M] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(X,Y)

datos=X;

valoresClases=unique(Y);
numClases=length(valoresClases);
[numDatos,numAtributos]=size(datos);

x1=sym('x1','real');
x2=sym('x2','real');

X=[x1;x2];

if numAtributos==3
   
    x3=sym('x3','real');
    X=[X;x3];
    
end
%calculamos vector prototipo de cada clase

M=zeros(numClases,numAtributos);
for i=1:numClases
    FoI=Y==valoresClases(i);
    XClase=datos(FoI,:);
    M(i,:)=mean(XClase);
    mCov(:,:,i)=cov(XClase,1);
end


%Matrices de covalianza de cada clase

mCov1=mCov(:,:,1);
mCov2=mCov(:,:,2);

numDatosClase1=sum(Y==valoresClases(1));
numDatosClase2=sum(Y==valoresClases(2));
mCov=(numDatosClase1*mCov1 + numDatosClase2*mCov2)/(numDatosClase1+numDatosClase2);


%Calculo de la funcion de decision de cada clase
%la diferencia entre las dos formas de hacerlo es que en una utilizo su
%propia matriz de covalianza y en el otro utilizo la matriz comun

M1=M(1,:)';
d1_mCov_de_cada_clase=expand(-(X-M1)'*pinv(mCov1)*(X-M1));
d1_mCov_comun=expand(-(X-M1)'*pinv(mCov)*(X-M1));

M2=M(2,:)';
d2_mCov_de_cada_clase=expand(-(X-M2)'*pinv(mCov2)*(X-M2));
d2_mCov_comun=expand(-(X-M2)'*pinv(mCov)*(X-M2));

d12=d1_mCov_comun-d2_mCov_comun;%forma lineal

if numAtributos==2
    %Ax1+Bx2+C
    x1=0;x2=0;C=eval(d12);
    x1=1;x2=0;A=eval(d12)-C;
    x1=0;x2=1; B=eval(d12)-C;
    
    coeficiente_d12=[A B C];
    
else
    %Ax1+Bx2+Cx3+D
    x1=0;x2=0;x3=0;D=eval(d12);
    x1=1;x2=0;x3=0;A=eval(d12)-D;
    x1=0;x2=1;x3=0; B=eval(d12)-D;
    x1=0;x2=0;x3=1; C=eval(d12)-D;
    
    coeficiente_d12=[A B C D];

end
