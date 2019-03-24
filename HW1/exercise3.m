length = 2;
repeat = 100;
N = [0, 10, 20, 30, 40, 50, 60, 70, 80, 100, 200, 500];
mean = zeros(1,12);
variance = zeros(1,12);
for p = 2:11
    for i = 1:repeat
        SumX = 0;
        for j = 1:N(p)
            mat=unifrnd(0,length,N(p),2);%n����length���������е����������꣬���ȷֲ�
            mat(:,1) = mat(:,1)-1;%y�����1
            mat(:,2) = mat(:,2)+2;%x�����2
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
x=0:42:500;%x���ϵ����ݣ���һ��ֵ�������ݿ�ʼ���ڶ���ֵ��������������ֵ������ֹ
plot(x,mean,'-*b'); %���ԣ���ɫ�����
axis([0,500,0,100000])  %ȷ��x����y���ͼ��С
set(gca,'XTick',(0:42:500));
set(gca,'YTick',(0:10000:100000));
legend('Mean');%���ϽǱ�ע
xlabel('N')  %x����������
ylabel('��ֵ') %y����������
