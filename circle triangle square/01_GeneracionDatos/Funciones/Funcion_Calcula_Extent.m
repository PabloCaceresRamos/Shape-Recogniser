function Extent =Funcion_Calcula_Extent(Matriz_Binaria)
%vamos a calcular el Exten de la figura independientemente de la rotacion
%para ello vamos a rotar la imagen hasta que su descriptor sea maximo
Extent=0;

Objcentrado=Funcion_Centra_Objeto(Matriz_Binaria);
a=regionprops(Objcentrado,'Area');
Area=cat(1,a.Area);

for i=0:5:355
   Rotada=imrotate(Objcentrado,i);
   c=regionprops(Rotada,'BoundingBox');
   Rectangulo=cat(1,c.BoundingBox);
   AreaRectangulo=Rectangulo(3)*Rectangulo(4);
   Descriptor=Area/AreaRectangulo;
   
   if(Descriptor>Extent)
      Extent=Descriptor;
   end
   
end


end

