%%% Matlab 2020a ile kodlanmıştır.


clear all; close all; clc;

%% Verileri çekmek için.
url='https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide.xlsx';
T = webread(url);

%%  Buna göre ülkelerin,
% %  a.Günlük ortalama vaka sayılarını,
% %  b.Günlük ortalama ölüm sayılarını,
% %  c.Toplam vaka sayılarını,
% %  d.Toplam ölüm sayılarını,
% %  e.Toplam ölüm/toplam vaka oranını,
% %  f.Toplam ölüm/ülke nüfusu oranını,
% %  g.Toplam vaka/ülke nüfusu oranını.
%% “covid19stats” adında bir excel dosyasına yazdıran MATLAB programını kodlayınız.

%%% Not: Dosya içerisinde ülkeler alfabetik sıraya göre sıralanacaktır.
%%% Birinci sütunda ülke adı, sonraki sütunlarda sırayla a %dan g% ye
%%% şıkların sonuçları yer alacaktır. Aşağıda bir örnek yer almaktadır.


%% Şimdi gelen veriyi kümeleme zamanı hadi o verileri düzenleyelim. (:
[group, id] = findgroups(T.countriesAndTerritories);

%Fonksiyon ile atama yapma.
func = @(vaka, olum, nufus) [mean(vaka), mean(olum), sum(vaka), sum(olum),...
    sum(olum)/sum(vaka), sum(olum)/mean(nufus), sum(vaka)/mean(nufus)];


result = splitapply(func, T.cases, T.deaths, T.popData2018, group);

newVarNames = {'Ortalama Vaka', 'Ortalama Ölüm', 'Toplam Vaka', ...
    'Toplam Ölüm', 'Toplam Ölüm/Toplam Vaka', 'Toplam Ölüm/Nüfus', 'Toplam Vaka/Nüfus'};

Tout1 = array2table(string(id),'VariableNames', "Ülkeler");
Tout2 = array2table(result,    'VariableNames', newVarNames);

%En son istenilen taployu verme.
Tout  = [Tout1, Tout2];

%Dosyaya yazdır.
writetable(Tout, 'covid19stats.xlsx');
