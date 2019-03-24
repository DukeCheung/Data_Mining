length=1;
repeat = 100;
N=[20, 50, 100, 200, 300, 500, 1000, 5000];
mean = zeros(1,8);
variance = zeros(1,8);
for k = 1:8
    for i = 1:repeat
        circleTimes = 0;
        mat=unifrnd(0,length,N(k),2);%n个长length的正方形中的随机点的坐标，均匀分布
        temp = size(mat,1);
        for j = 1:temp
            if power(mat(j,1),2)+power(mat(j,2),2)<=1
                circleTimes = circleTimes+1;
            end
        end
        PI = (double(circleTimes)/temp)*4;
        mean(k) = mean(k)+PI;
        variance(k) = variance(k)+PI*PI;
    end
    mean(k) = mean(k)/100;
    %variance = E(x^2) - E(x)^2
    variance(k) = variance(k)/100 - mean(k)*mean(k);
    %plot(mat(:,1),mat(:,2),'.');
end

x=0:714:5000;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
plot(x,mean,'-*b',x,variance,'-or'); %线性，颜色，标记
axis([0,5000,0,4])  %确定x轴与y轴框图大小
set(gca,'XTick',(0:1000:5000));
set(gca,'YTick',(0:1:4));
legend('Mean','Variance');%右上角标注
xlabel('N')  %x轴坐标描述
ylabel('均值/方差') %y轴坐标描述
