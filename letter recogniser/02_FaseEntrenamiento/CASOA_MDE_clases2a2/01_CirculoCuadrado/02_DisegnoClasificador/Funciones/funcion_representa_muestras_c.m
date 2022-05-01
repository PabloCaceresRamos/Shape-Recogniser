function funcion_representa_muestras_clasificacion_binaria_con_frontera(X,Y,nombresProblemaOIRed,coeficiente_d12, varargin)
%varargin quiere decir que la entrada de argumentos puede ser variable

%Esta funcion se va a encargar de coger los datos y hacer una grafica con
%ellos, ya puede ser 2D o 3D segun el numero de descriptores pasados. Tiene
%la opcion de pasarle el coeficiente o no, para dibujar la funcion de
%separacion.

valoresClases=unique(Y);
numClases=length(valoresClases);
[numDatos, numAtributos]=size(X);

%% Representacion de los datos
nombreCcas=nombresProblemaOIRed.descriptores;

simbolos=nombresProblemaOIRed.simbolos;

leyenda=nombresProblemaOIRed.clase;

%figure, 
hold on

if numAtributos==2
    %2D
    for i=1:numClases
       FoI=Y==valoresClases(i);
       x1=X(FoI,1);
       x2=X(FoI,2);
       plot(x1,x2,simbolos{i});
    end
        legend(leyenda{1},leyenda{2})
        xlabel(nombreCcas{1}),ylabel(nombreCcas{2})
        grid on
        
    if nargin == 4 %miro si le paso el coeficiente_d12    
    %Representacion frontera 2D   
    x1min=min(X(:,1)); x1max=max(X(:,1));
    x2min=min(X(:,2)); x2max=max(X(:,2));
    axis([x1min x1max x2min x2max]);

    A=coeficiente_d12(1); B=coeficiente_d12(2); C=coeficiente_d12(3);
    x1Recta=x1min:0.01:x1max;
    x2Recta=-(A*x1Recta+C)/(B+eps); %calculo la ecuacion de la recta

    plot(x1Recta,x2Recta,'g');
    end

    
else
     %3D
    for i=1:numClases
       FoI=Y==valoresClases(i);
       x1=X(FoI,1);
       x2=X(FoI,2);
       x3=X(FoI,3);
       plot3(x1,x2,x3,simbolos{i});
    end
        legend(leyenda{1},leyenda{2})
        xlabel(nombreCcas{1}),ylabel(nombreCcas{2});
        zlabel(nombreCcas{3});
        grid on
    
     if nargin == 4 %miro si le paso el coeficiente_d12    
    %representamos la fronterea 3D
    x1min=min(X(:,1)); x1max=max(X(:,1));
    x2min=min(X(:,2)); x2max=max(X(:,2));
    x3min=min(X(:,3)); x3max=max(X(:,3));
    axis([x1min x1max x2min x2max x3min x3max]);

    A=coeficiente_d12(1); B=coeficiente_d12(2); C=coeficiente_d12(3); D=coeficiente_d12(4);
    Xmin=min(X(:));
    Xmax=max(X(:));
    paso=(Xmax-Xmin)/100;
    [x1Plano, x2Plano]=meshgrid(Xmin:paso:Xmax);
    x3Plano=-(A*x1Plano + B*x2Plano+ D)/(C+eps);
    surf(x1Plano,x2Plano,x3Plano);
     end
    
end

hold off
end

