%% advect linearization
clear all;
clc;
close all;
addpath(['/Users/kevin/SkyDrive/KTH Work/Period 3 2014'...
    '/DN2255/Homework/4/HW4-High Resolution shock-capturing'...
    ' methods/matlabfiles/']);
%% Parameters
N = 100;
L = 1.;
dx = L/N; % Grid spacing
H = 1;
g = 9.8;
c = sqrt(g*H); % Wave speed
tau = .8*dx/c; % Time Step
coeff = -tau/(2*dx);
nStep = L/(c*tau); % waves
finalTime = nStep*tau;
nCells = 1:N;
x = dx/2:dx:L;
%% Boundary Conditions
w = 0.1*L; % Width
a = 1/5*H;
h = a*exp(-(x-L/2).^2/(w^2));
m = 0*h;
%% Record the initial state
hplot(:,1) = h(:);
mplot(:,1) = m(:);
f = (1/2*g*h.^2 + (m.^2)./h);
r = L/6;
B0 = H/10;
for ib = 1:length(x)
    if abs(x(ib)-L/2)<r
        B(ib) = B0*cos((pi*(x(ib)-L/2))/(2*r));
    else
        B(ib)=0;
    end
end
%% Loop
for tstep= 1:(round(nStep))
    hp=h;
    mp=m;
    f = (1/2*g*hp.^2 + (mp.^2)./hp);
    
    for i = 2:(N-1)
        F = 1/2*(f(i) + f(i+1)) - 1/2*()
        hp(i) = .5*(hp(i+1)+ hp(i-1))...
            - abs(coeff)*(m(i+1) - m(i-1));
        mp(i) = .5*(mp(i+1)+ mp(i-1))...
            - abs(coeff)*(f(i+1) - f(i-1));
    end
    hp(1) = hp(2);
    mp(1) = mp(2)*(-1);
    hp(N) = hp(N-1);
    mp(N) = mp(N-1)*(-1);
    hplot(:,(tstep+1)) = hp(:);
    mplot(:,(tstep+1)) = mp(:);
    h=hp;
    m=mp;
end

%% Plot
% figure(1); clf;
% plot(x,hplot(i,1),'-',x,hplot(i,nStep),'--');
% legend('t=0','t=1');
% xlabel('x');  ylabel('h(x,t)');
% title(sprintf('$h(x,t)$ $\\Delta t=$%0.2g,',...
%     ' $\\epsilon =$ %g',tau,a),...
%     'Interpreter','latex')
%% h plot1
%     figure(2)
%     for iPlotting = 1:2:nStep
%         clf;
%         plot(x,hplot(i,1) + B(i)')
%         hold on;
%         plot(x,hplot(i,iPlotting)+B(i)','-');
%         finalB = plot(x,B(i),'-.','color','r');
%         pause(.1)
%     end
% m plot
figure(3)
for ip = 1:8:nStep
    plot(x,hplot(:,1))
    hold on;
    plot(x,hplot(:,ip),'-');
    hold off;
    pause(.1)
end
%% Plot for 2.1
% figure(3)
% initialH = plot(x,hplot(:,1) + B(:)','-','color','b');
% hold on;
% hPlusB.t1 = plot(x,hplot(:,round(nStep/2))+ B(:)'...
%     ,'--','color','k');
% hPlusB.t2 = plot(x,hplot(:,round(nStep))+ B(:)'...
%     ,'--','color','m');
% finalB = plot(x,B(:),'-.','color','r');
% legend([initialH,hPlusB.t1,hPlusB.t2,finalB],...
%     't=0, h(x) + B(x)',...
%     sprintf('t=%0.2g, h(x) + B(x)',tau*round(nStep/2)),...
%     sprintf('t=%0.2g, h(x) + B(x)',tau*round(nStep)),...
%     'B(x)','location','best');
% xlabel('x');  ylabel('h(x,t)');
% hold off;
% %%
% printYesNo = 0;
% if printYesNo == 1
%     saveFigurePath = ['/Users/kevin/SkyDrive/KTH Work'...
%         '/Period 3 2014/DN2255/Homework/4/HW4-High'...
%         ' Resolution shock-capturing methods/Figures/'];
%     set(figure(3), 'PaperPositionMode', 'auto');
%     print('-depsc2', [saveFigurePath ...
%         sprintf('steadySolutionsp%g_n_is_%g_a_%g',H,N,round(a))]);
% end
% 
% 
