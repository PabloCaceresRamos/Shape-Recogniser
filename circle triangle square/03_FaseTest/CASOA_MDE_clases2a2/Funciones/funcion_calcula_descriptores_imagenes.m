function XImagen = funcion_calcula_descriptores_imagenes(Ietiq,N)
%devuelvo una matriz con todos los descriptores (23)columnas y tantas filas
%como objetos(N)
stats=regionprops(Ietiq,'Extent','Area','Perimeter','Eccentricity','EulerNumber','Solidity');

Perimetro=cat(1,stats.Perimeter);
Area=cat(1,stats.Area);
ExtentImagen=cat(1,stats.Extent);
%Calculamos la compacticidad
Compacticidad=(Perimetro.^2 )./Area;
%calculamos la Excentricidad
Excentricidad=cat(1,stats.Eccentricity);
%calculamos la solidez
Solidez=cat(1,stats.Solidity);
%Claculamos el numero de Euler
NEuler=cat(1,stats.EulerNumber);
%calculamos la Nueva Extension + los descriptores de hu
ExtensionIR_HuImagen=funcion_calcula_ExtentIR_Hu_objetos_imagen(Ietiq,N);
%Claculamos los descriptores de DF
DFImagen=funcion_calcula_DF_objetos_imagen(Ietiq,N);
XImagen=[Compacticidad Excentricidad Solidez ExtentImagen ExtensionIR_HuImagen DFImagen NEuler];

end

