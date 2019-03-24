length=1;
repeat = 100;
N=[20, 50, 100, 200, 300, 500, 1000, 5000];
mean = zeros(1,8);
variance = zeros(1,8);
for k = 1:8
    for i = 1:repeat
        circleTimes = 0;
        mat=unifrnd(0,length,N(k),2);%n����length���������е����������꣬���ȷֲ�
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

x=0:714:5000;%x���ϵ����ݣ���һ��ֵ�������ݿ�ʼ���ڶ���ֵ��������������ֵ������ֹ
plot(x,mean,'-*b',x,variance,'-or'); %���ԣ���ɫ�����
axis([0,5000,0,4])  %ȷ��x����y���ͼ��С
set(gca,'XTick',(0:1000:5000));
set(gca,'YTick',(0:1:4));
legend('Mean','Variance');%���ϽǱ�ע
xlabel('N')  %x����������
ylabel('��ֵ/����') %y����������
