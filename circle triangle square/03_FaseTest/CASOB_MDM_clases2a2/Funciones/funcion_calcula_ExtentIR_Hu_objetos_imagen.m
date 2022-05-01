function X = funcion_calcula_ExtentIR_Hu_objetos_imagen(Ietiq,N)
%Calculamos el momento de Hu de cada objeto etiquetado
X=[];

for i=1:N
    
    Ibin_i=Ietiq==i;
    extentIR=Funcion_Calcula_Extent(Ibin_i);
    m=Funcion_Calcula_Hu(Ibin_i);
    X(i,:)=[extentIR m'];
end

