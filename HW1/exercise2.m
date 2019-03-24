length=1;
repeat = 100;
N=[0, 5, 10, 20, 30, 40, 50, 60, 70, 80, 100];
mean = zeros(1,11);
variance = zeros(1,11);
for k = 2:11
    for i = 1:repeat
        integralTimes = 0;
        mat=unifrnd(0,length,N(k),2);%n个长length的正方形中的随机点的坐标，均匀分布
        temp = size(mat,1);
        for j = 1:temp
            if mat(j,1) <= power(mat(j,2),3)
                integralTimes = integralTimes+1;
            end
        end
        result = integralTimes/temp;
        mean(k) = mean(k)+result;
        variance(k) = variance(k)+result*result;
    end
    mean(k) = mean(k)/repeat;
    %variance = E(x^2) - E(x)^2
    variance(k) = variance(k)/repeat - mean(k)*mean(k);
    %plot(mat(:,1),mat(:,2),'.');
end
x=0:10:100;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
plot(x,mean,'-*b',x,variance,'-or'); %线性，颜色，标记
axis([0,100,0,0.5])  %确定x轴与y轴框图大小
set(gca,'XTick',(0:10:100));
set(gca,'YTick',(0:0.1:0.5));
legend('Mean','Variance');%右上角标注
xlabel('N')  %x轴坐标描述
ylabel('均值/方差') %y轴坐标描述
