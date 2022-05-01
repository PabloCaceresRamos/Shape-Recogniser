function YTest = funcion_knn(XTest,XTrain,YTrain,k,Distancia)

[numDatos,numDescriptores]=size(XTest)
[numDatosTrain,numDescriptoresTrain]=size(XTrain)
valoresClases=unique(YTrain);
numClases=length(valoresClases);


YTest =[];
for i=1:numDatos
    
    %Lo que vamos a hacer es calcular todas las distancias de un punto
        %de Test con los demas puntos, luego cogemos las k menores
        %distancias. Buscamo las figuras que son esas k menores distancias
        %y contamos cuantas figuras se repiten. Nos quedamos con la que mas
        %se repita, en caso de que haya 2 o mas que se repitan igual de
        %veces nos quedamos con la que tenga la distancia mas corta, que
        %siempre seta la primera que este ordenada en el sort.
        
if(strcmp(Distancia,'Euclidea'))
        
        X=XTest(i,:);
        XRepeat=repmat(X,numDatosTrain,1);
        DistanciaE=sqrt(sum((XTrain'-XRepeat').^2));
        
end
if(strcmp(Distancia,'Mahalanobis'))

 % Calculamos la matriz de covarianzas de cada clase
 
        for j=1:numClases
            FoI = YTrain == valoresClases(j);
            XClase = XTrain(FoI,:);
            mCov(:,:,j) = cov(XClase,1);
        end
    
       
        DistanciaE = [];
        for j=1:numDatosTrain
            mCovClase = mCov(:,:,find(ismember(YTrain(j),valoresClases),1));%find(ismenber(x,y)) sacala posicion de x en y 
            X1 = XTrain(j,:);
            X2 = XTest(i,:);
            distancia_calculada = sqrt((X1-X2)*pinv(mCovClase)*(X1-X2)');
            DistanciaE = [DistanciaE distancia_calculada];
        end
    


end

%% Localizo las k instancias mas cercanas
[DisOrdenada,pos]=sort(DistanciaE);
kValores=pos(1:k);
%% Cojo la figura a la que pertenece cada instancia
FiguraKValores=YTrain(kValores);
ValoresFiguras = unique(FiguraKValores);
%% Contamos cuantas veces se repite cada figura
Repetido=hist(FiguraKValores);
Repetido(Repetido ==0)=[];
[RepetidoOrd,posMasRepetido]=sort(Repetido,'Des');
%% Cogemos la figura que mas veces se repita, o en caso de empate la que tenga la intancia mas cercana
Y=ValoresFiguras(posMasRepetido(1));
YTest=[YTest;Y];

end
end

