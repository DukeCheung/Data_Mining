length = 2;
repeat = 100;
N = [0, 10, 20, 30, 40, 50, 60, 70, 80, 100, 200, 500];
mean = zeros(1,12);
variance = zeros(1,12);
for p = 2:11
    for i = 1:repeat
        SumX = 0;
        for j = 1:N(p)
            mat=unifrnd(0,length,N(p),2);%n个长length的正方形中的随机点的坐标，均匀分布
            mat(:,1) = mat(:,1)-1;%y坐标减1
            mat(:,2) = mat(:,2)+2;%x坐标加2
            SumY = 0;
            for k = 1:N(p)
                x = mat(j,2);
                y = mat(k,1);
                SumY = SumY + (power(y,2)*exp(-power(y,2))+power(x,4)*exp(-power(x,2)))/(x*exp(-power(x,2)));
            end
            SumY = SumY/N(p);
            SumX = SumX+(4-2)*SumY;
        end
        result = SumX/N(p);
        mean(p) = mean(p)+result;
        variance(p) = variance(p)+result*result;
    end
    mean(p) = mean(p)/repeat;
    %variance = E(x^2) - E(x)^2
    variance(p) = variance(p)/repeat - mean(p)*mean(p);
    %plot(mat(:,1),mat(:,2),'.');
end
x=0:42:500;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
plot(x,mean,'-*b'); %线性，颜色，标记
axis([0,500,0,100000])  %确定x轴与y轴框图大小
set(gca,'XTick',(0:42:500));
set(gca,'YTick',(0:10000:100000));
legend('Mean');%右上角标注
xlabel('N')  %x轴坐标描述
ylabel('均值') %y轴坐标描述
