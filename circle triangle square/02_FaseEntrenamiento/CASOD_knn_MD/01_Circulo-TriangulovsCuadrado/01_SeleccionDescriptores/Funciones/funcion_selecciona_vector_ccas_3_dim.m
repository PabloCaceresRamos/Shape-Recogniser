function [espacioCcas, JespacioCcas] = funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI)

% Se va a buscar los mejores 9 descriptores individualmente, una vez
% encontrado, se va a ver que conjunto de 3 descriptores es el mejor
% combinando los x descriptores primeros.

[numMuestras, numDescriptores] = size(XoI);


%% Determinamos los 9 mejores descriptores individuales
outputs = YoI';
ValoresJ = zeros(1,numDescriptores);

%Sacamos que bueno es cada descriptor
for j=1:numDescriptores
   inputs= XoI(:,j)';
   ValoresJ(1,j)=indiceJ(inputs,outputs);
end

[valoresJord, indices]= sort(ValoresJ,'descend');

mejoresDInd = indices(1:numDescriptoresOI); %mejores descriptores individualmente

%% Determinar que 3 de esos x descriptores son la mejor combinación
NuevaX= XoI(:,mejoresDInd);
comb = combnk(1:numDescriptoresOI,3);% genera combinaciones de 3 elementos del 1 al numero de descriptores pasados

numComb = size(comb,1);

outputs =YoI';
valoresJ = zeros(numComb,1);

for i=1:numComb
    columnasOI = comb(i,:);
    inputs = NuevaX(:,columnasOI)';
    valoresJ(i) = indiceJ(inputs,outputs);
end

[valoresJord, indicesComb] = sort(valoresJ,'descend');

mejoresDComb= comb(indicesComb(1),:); %mejores descriptores de forma conjunta
JespacioCcas = valoresJord(1); %valores de J de ese espacion formado por esos descriptores
    
espacioCcas = indices(mejoresDComb);%Una vez sacado los mejores descriptores 
%veo cual son sus indices reales

end

