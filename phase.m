clc;clear all
for h = 0:0.01:1
    x_aprx = -pi:h:pi;
    l = length(x_aprx);
    syms x
    f(x) = 3*cos(10*x)+5*sin(15*x)
    df_true = 75.*cos(15.*x_aprx) - 30.*sin(10.*x_aprx);
    
    F = f(x_aprx);

    df_cfd = zeros(1,l);
    for i = 2:l-1
        df_cfd(1) = df_true(1); % Boundary condition is not given.
        df_cfd(l) = df_true(l); % Boundary condition is not given.
        df_cfd(i) = (f(x_aprx(i+1))-f(x_aprx(i-1)))./(2*h);
    end
    e1 = mean(abs(df_cfd-df_true)./df_true)
    M = [1 1 1 1 1;
    -2 -1 0 1 2;
    2 1/2 0 1/2 2;
    -4/3 -1/6 0 1/6 4/3
    2/3 1/24 0 1/24 2/3];
    u = [0; 1/h; 0; 0; 0];
    A = M\u;

    df_fod = zeros(1,l);
    for i = 3:l-2
        df_fod(1) = df_true(1);
        df_fod(2) = df_true(2);
        df_fod(l-1) = df_true(l-1);
        df_fod(l) = df_true(l);% Unknown boundary conditions
        df_fod(i) = dot(A,F(i-2:i+2));
    end
end
