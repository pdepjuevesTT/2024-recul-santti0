% solucion en prolog

% punto 1

vive(juan,casa(120)).
vive(nico,depto(3,2)).
vive(alf,depto(3,1)).
vive(julian,loft(2000)).
vive(vale,depto(4,1)).
vive(fer,casa(110)).

barrio(almagro).
barrio(flores).

% no es necesario modelar a rocio ya que no dice donde esta viviendo actualmente que es lo que necesitamos
% no modelamos por universo cerrado a felipe, siempre que se pregunte nos retornaria falso



residencia(juan,almagro).
residencia(alf,almagro).
residencia(nico,almagro).
residencia(julian,almagro).
residencia(vale,flores).
residencia(fer,flores).

% punto 2



barrioCopado(Barrio):-
    barrio(Barrio),
    forall(residencia(Persona,Barrio),(vive(Persona,Vivienda),viviendaCopada(Vivienda))).

viviendaCopada(casa(Metros)):- Metros > 100.
viviendaCopada(depto(Ambientes,_)):- Ambientes > 3.
viviendaCopada(depto(_,Banios)):- Banios > 1.
viviendaCopada(loft(Anio)):- Anio > 2015.

%punto 3
 
%plantearlo tambien con un finall

%barrioCaro(Barrio):
%    barrio(Barrio),
%    findall(Barrio, (residencia(Persona,Barrio),vive(Persona,Casa),barrioBarato(Casa)), BarriosBaratos),
%    length(BarriosBaratos, Cantidad), not(Cantidad >1).


barrioCaro(Barrio):-
    barrio(Barrio),
    not((forall(residencia(Persona,Barrio),(vive(Persona,Casa),not(barrioBarato(Casa)))))).

barrioBarato(casa(Metros)):- Metros < 90.
barrioBarato(loft(Anio)):- Anio < 2005.
barrioBarato(depto(Ambientes,_)):- between(1, 2, Ambientes).


%punto 4

determinarCompra([dineroDisp(Dinero)],[precioCasa(juan,150000),
precioCasa(nico,80000),
precioCasa(alf,75000),
precioCasa(julian,140000),
precioCasa(vale,95000),
precioCasa(fer,60000),]).

sublista([],[]).
sublista([_|Cola],Sublista):-sublista(Cola,Sublista).
sublista([Cabeza|Cola],[Cabeza|Sublista]):-sublista(Cola,Sublista).

comprarPropiedad(Dinero):-
    determinarCompra(dineroDisp(Dinero),[Cabeza|Cola]),
    findall(Sublista,(evaluarCompras(Dinero,[Cabeza|_],[_|Cola]),Sublista),Compradas).
ç
evaluarCompras(Dinero,[Cabeza|_],[_|Cola],Sublista):-
    findall(Resultado,(posiblesCombinaciones(Cabeza,Cola,Resultado)),Sublista),
    append(Cabeza,Sublista).
    
posiblesCombinaciones(Cabeza,Cola,Resultado):-
    sublista(Cabeza,Cola).


    


    






