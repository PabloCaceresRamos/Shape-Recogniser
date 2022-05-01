function IbinFilt = funcion_elimina_regiones_ruidosas(Ibin)
%vamos a coger una imagen binaria donde primero vamos a quitar las areas
%menores al 0.001% del area de la imagen, y luego vamos a quitar aquellas
%areas menores que el areamaxima/5. Todo esto para quitar el ruido

[N,M]=size(Ibin);
Ibin2=bwareaopen(Ibin,round(0.001*N*M));% descarto regiones con menos area
%que el 0.001% del area de la imagen

if sum(Ibin2>0)
    Ietiq=bwlabel(Ibin2);
    
    stats=regionprops(Ietiq,'Area');
    areas=cat(1,stats.Area);
    
    numPix=floor(max(areas)/5);
    
    IbinFilt=bwareaopen(Ibin2,numPix);% descarto regiones con area mas pequeña 
    %que la mayor/5
else
    IbinFilt= Ibin2;
end

