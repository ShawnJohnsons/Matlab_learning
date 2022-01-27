clc
clear all
close all

figure %fig 1
x=sort(trnd(10,1,10000));
normplot(x);
[f,ep]=ecdf(x);
for k1=1:0.001:3 %求k1,k1是cdf包络，一般要小一些，这里直接用样本中分布最保守的点包络原分布
    yleft=normcdf(ep(1:ceil(length(x)*0.05)),mean(x),k1*std(x))-f(1:ceil(length(x)*0.05));
    yright=normpdf(ep(length(x-ceil(length(x)*0.05)+1):end),mean(x),k1*std(x))-f(length(x-ceil(length(x)*0.05)+1):end);
    if all(yleft>0) &&  all(-yright>0)
        break
    end    
end
hold on
plot(x,norminv(normcdf(x,0,k1*std(x)),0,1),'r');
legend('1 sig gaussian','1.658 sig gaussian','actual distribution')

figure %fig 2
[b, x2]=hist(x,100);%分区间统计，分成100个区间，b就是每个区间的统计个数，即频数，x是对应区间的中间坐标，这里的区间数会影响最终的膨胀因子，注意！！
fx=(b/length(x))/(x2(2)-x2(1));
semilogy(x2,fx,'k.')
hold on
grid on
for k2=1:0.001:3 %求k2,k2是pdf包络，一般要大于k1
    yleft2=normpdf(x2(1:ceil(length(x2)*0.05)),mean(x),k2*std(x))-fx(1:ceil(length(x2)*0.05));
    yright2=normpdf(x2(length(x2-ceil(length(x2)*0.05)+1):end),mean(x),k2*std(x))-fx(length(x2-ceil(length(x2)*0.05)+1):end);
    if all(yleft2>0) &&  all(yright2>0)
        break
    end
end
xall=-max(abs(x)):0.001:max(abs(x));
semilogy(xall,(normpdf(xall,mean(x),k2*std(x))),'g.')
hold on
semilogy(xall,(normpdf(xall,mean(x),1*std(x))),'r.')
legend('actual distribution','1 sig gaussian','2.663 sig gaussian')
%}
