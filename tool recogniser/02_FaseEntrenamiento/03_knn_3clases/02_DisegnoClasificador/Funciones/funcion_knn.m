function YTest = funcion_knn(XTest,XTrain,YTrain,k,Distancia)

[numDatos,numDescriptores]=size(XTest)
[numDatosTrain,numDescriptoresTrain]=size(XTrain)

YTest =[];
for i=1:numDatos
    
    %Lo que vamos a hacer es calcular todas las distancias de un punto
        %de Test con los demas puntos, luego cogemos las k menores
        %distancias. Buscamo las figuras que son esas k menores distancias
        %y contamos cuantas figuras se repiten. Nos quedamos con la que mas
        %se repita, en caso de que haya 2 o mas que se repitan igual de
        %veces nos quedamos con la que tenga la distancia mas corta, que
        %siempre seta la primera que este ordenada en el sort.
        
if(strcop(Distancia,'Euclidea'))
        
        X=XTest(i,:);
        XRepeat=repmat(X,numDatosTrain,1);
        DistanciaE=sqrt(sum((XTrain'-XRepeat').^2));
        
end
if(strcop(Distancia,'Mahalanobis'))
    
%calculamos vector prototipo de cada clase
    valoresClases=unique(YTrain);
    numClases=length(valoresClases);
    M=zeros(numClases,numAtributos);
    for j=1:numClases
        FoI=Y==valoresClases(j);
        XClase=XTrain(FoI,:);
        M(j,:)=mean(XClase);
        mCov(:,:,j)=cov(XClase,1);%Matriz de covalianza
    end
    X=XTest(i,:);
    for j=1:numDatosTrain
        DistanciaE(j)=(XTrain'-X')'*pinv(mCov(:,:,YTrain(j)))*(XTrain'-X');
    end

end

[DisOrdenada,pos]=sort(DistanciaE);
kValores=pos(1:k);
FiguraKValores=YTrain(kValores);
ValoresFiguras = unique(FiguraKValores);
Repetido=hist(FiguraKValores);
Repetido(Repetido ==0)=[];
[RepetidoOrd,posMasRepetido]=sort(Repetido,'Des');

Y=ValoresFiguras(posMasRepetido(1));
YTest=[YTest;Y];

end
end

