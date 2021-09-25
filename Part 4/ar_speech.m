function [y,error,coeffs]= ar_speech(letter,mu,ord)
    N=length(letter);
    error=zeros(1,N-1);
    y=zeros(1,N-1);
    coeffs=zeros(N-1,ord);
   
    for id=ord+1:N-1
        letter_hat= letter(id:-1:id-ord+1);
        y(1,id)= (coeffs(id,:))*(letter_hat)';
        error(1,id)= letter(1,id)-y(1,id);
        coeffs(id+1,:)=coeffs(id,:)+ mu*error(1,id)*letter_hat;
    end
    
end
%take error for specific order and error error' and normalise