function [mu trmx] = pcaPrepTransform(tvec, comp_count)
% tvec - maciery zawieraj¹ca obrazy zbioru ucz¹cego
% comp_count - liczba najwiêkszych sk³adowych w macierzy transformacji
% mu - wartoœæ œrednia zbioru ucz¹cego
% trmx - macierz transformacji do comp_count-wymiarowej przestrzeni PCA
% Funkcja zapisuje w plikach wektor œredniej zbioru ucz¹cego, oraz WSZYSTKIE wektory w³asne 
% w kolejnoœci od odpowiadaj¹cego najwiêkszej wartoœci w³asnej (w tej wersji zapis wykomentowany!)

mu = mean(tvec);
cmx = cov(tvec);
[evec eval] = eig(cmx);
eval = sum(eval);
[eval evid] = sort(eval);
eval = eval(size(eval,2):-1:1);
evec = evec(:, evid(size(eval,2):-1:1));
% save 'nist_mu.mat' mu
% save 'nist_cov.mat' evec 
trmx = evec(:, 1:comp_count);
