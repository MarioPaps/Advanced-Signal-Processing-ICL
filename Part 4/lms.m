function  [y_hat,error,evolution]= lms(x,z,mu,ord)
    x=x'; 
    z=z'; 
    N=length(x);
    w=zeros(N,ord);
    y_hat=zeros(1,N);
    error=zeros(1,N);

    for n=ord+1:N
        x_hat=x(n:-1:n-(ord-1));
        y_hat(1,n)= dot(w(n-ord,:),x_hat);
        error(1,n)= z(1,n)-y_hat(1,n);
        temp= mu*error(1,n) * x_hat;
        w(n+1,:)= w(n,:)+ temp;
    end
    w_out= w(height(w),:); %display final coefficients
    evolution=w;
end


        
        