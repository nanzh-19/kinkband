 % 从材料刚度矩阵计算得到刚度阵
clear all;
clc;
ef=324;  %纤维的杨氏模量
em=3;    %基体的杨氏模量
vf=0.3;  %纤维的泊松比
vm=0.3;  %基体的泊松比
wf=0.6;  %纤维的体积分数
wm=1-wf; %基体的体积分数
gf=0.5*ef/(1+vf);  %纤维的剪切模量 
gm=0.5*em/(1+vm);  %基体的剪切模量
s=zeros(3,3);      %初始化柔度矩阵
s(1,1)=(wf*ef+wm*em+(wf*wm*ef*em*(vf-vm)^2)/(wf*ef*(1-vm^2)+wm*em*(1-vf^2)))^-1;     %柔度矩阵分量S11
s(2,2)=wf/ef+wm/em-(2*wf*wm*(vf*em-vm*ef)^2)/((1-vf)*wm*ef*em^2+(1-vm)*wf*em*ef^2);  %柔度矩阵分量S22
s(3,3)=wf/gf+wm/gm;%柔度矩阵分量S33
s(1,2)=(wf*vf+wm*vm-vf*vm)/(wf*vm*ef+wm*vf*em-wf*ef-wm*em);  %柔度矩阵分量S12
s(2,1)=s(1,2);     %柔度矩阵分量S21
c=s^-1;            %求解刚度矩阵
% S=[-2.75084 0;0 -0.041469]; %-0.014
% S=[-1.966 0;0 -6.108e-09]; % -0.01
 S=[-2.877 0;0 -2.784e-08]; %-0.0146
%S=[-2.897 0;0 -2.861e-08];   %-0.0147
% S=[-5.61372 0;0 -1.148e-06];  %-0.0287 
%S=[1.946 0;0 -6.023e-09];  %拉伸0.01
B=[0 0 1;0 1 0;-1 0 -1;0 -1 -1;1 0 0;0 0 1];
B1=[0 1;-1 -1;1 0];
kmat=1/2*B*c*B';
H=1/2*B1*S*B1';  
% kgeo=[H(1,1) 0 H(1,2) 0 H(1,3) 0;0 H(1,1) 0 H(1,2) 0 H(1,3);H(2,1) 0 H(2,2) 0 H(2,3) 0;0 H(2,1) 0 H(2,2) 0 H(2,3);H(3,1) 0 H(3,2) 0 H(3,3) 0;0 H(3,1) 0 H(3,2) 0 H(3,3)];
for i=1:3
    for j=1:3
        kgeo(2*i-1,2*j-1)=H(i,j);
        kgeo(2*i,2*j)=H(i,j);
    end
end
K=kmat+kgeo