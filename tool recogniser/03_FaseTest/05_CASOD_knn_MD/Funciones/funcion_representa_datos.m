function funcion_representa_datos(X,Y,espacioCcas,nombresDescriptores,nombresClases,simbolosClases)
%sacamos cuantos ejes vamos a tener y el nombre de cada eje
numeroEjes=size(espacioCcas,2);
for i=1:numeroEjes
   nombreEjes(i)=nombresDescriptores(espacioCcas(i)); 
end


Clases=unique(Y);
numClases=size(Clases);

figure, hold on
%miramos si queremos 2 ejes o 3 y hacemos la grafica
%Si sale una grafica sin datos es que no se ha introducido mas de 3 datos o
%menos de 2.
if(numeroEjes==2)
    for i=1:numClases
    
        datosClase= X(Y==Clases(i),espacioCcas);
        plot(datosClase(:,1),datosClase(:,2),simbolosClases{i})

    end
    legend(nombresClases)
    xlabel(nombreEjes(1));
    ylabel(nombreEjes(2));
end
if(numeroEjes==3)
    for i=1:numClases
    
        datosClase= X(Y==Clases(i),espacioCcas);
        plot3(datosClase(:,1),datosClase(:,2),datosClase(:,3),simbolosClases{i})

    end
    legend(nombresClases)
    xlabel(nombreEjes(1));
    ylabel(nombreEjes(2));
    zlabel(nombreEjes(3));
    
end



