function [D,D1,D2]=LBP1(I,Inp)
imgray =I; %imread(I);
%[m,n,l]=size(im);
%imgray=rgb2gray(im);
im=imgray;
h=size(imgray,1);
    w=size(imgray,2);
    LBP(1,1)=(imgray(1,2)>=imgray(1,1))*2^4+(imgray(2,2)>=imgray(1,1))*2^3+(imgray(2,1)>=imgray(1,1))*2^2;
 
    LBP(1,w)=(imgray(1,w-1)>=imgray(1,1))*2^0+(imgray(2,w-1)>=imgray(1,1))*2^1+(imgray(2,w)>=imgray(1,1))*2^2;
   
    LBP(h,1)=(imgray(h-1,1)>=imgray(1,1))*2^6+(imgray(h-1,2)>=imgray(1,1))*2^5+(imgray(h,2)>=imgray(1,1))*2^4;

    LBP(h,w)=(imgray(h-1,w-1)>=imgray(1,1))*2^7+(imgray(h-1,w)>=imgray(1,1))*2^6+(imgray(h,w-1)>=imgray(1,1))*2^0;

    for j=2:w-1
        LBP(1,j)=(imgray(1,j-1)>=imgray(1,j))*2^0+(imgray(2,j-1)>=imgray(1,j))*2^1+(imgray(2,j)>=imgray(1,j))*2^2+(imgray(1,j+1)>=imgray(1,j))*2^3+(imgray(1,j+1)>=imgray(1,j))*2^4;
    end

    for j=2:w-1
        LBP(h,j)=(imgray(h-1,j-1)>=imgray(h,j))*2^7+(imgray(h-1,j)>=imgray(h,j))*2^6+(imgray(h-1,j+1)>=imgray(h,j))*2^5+(imgray(h,j+1)>=imgray(h,j))*2^4+(imgray(h,j-1)>=imgray(h,j))*2^0;
    end

    for i=2:h-1
        LBP(i,1)=(imgray(i-1,1)>=imgray(i,1))*2^6+(imgray(i-1,2)>=imgray(i,1))*2^5+(imgray(i,2)>=imgray(i,1))*2^4+(imgray(i+1,2)>=imgray(i,1))*2^3+(imgray(i+1,1)>=imgray(i,1))*2^2;
    end

    for i=2:h-1
        LBP(i,w)=(imgray(i-1,w-1)>=imgray(i,w))*2^7+(imgray(i-1,w)>=imgray(i,w))*2^6+(imgray(i+1,w)>=imgray(i,w))*2^2+(imgray(i+1,w-1)>=imgray(i,w))*2^1+(imgray(i,w-1)>=imgray(i,w))*2^0;
    end

    for i=2:h-1
        for j=2:w-1
            LBP(i,j)=(imgray(i-1,j-1)>=imgray(i,j))*2^7+(imgray(i-1,j)>=imgray(i,j))*2^6+(imgray(i-1,j+1)>=imgray(i,j))*2^5+(imgray(i,j+1)>=imgray(i,j))*2^4+(imgray(i+1,j+1)>=imgray(i,j))*2^3+(imgray(i+1,j)>=imgray(i,j))*2^2+(imgray(i+1,j-1)>=im(i,j))*2^1+(imgray(i,j-1)>=imgray(i,j))*2^0;
        end
    end
    D=LBP;
    %size(D)
D1=double([D(:)]);
D2=Inp
%size(D1)
end