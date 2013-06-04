function F = int(f,x,from,to)
% INT Integration of scalar polynomial SDPVAR object
%
% F = int(f) Integrate w.r.t first variable
% F = int(f,x) Integrate w.r.t x
% F = int(f,x,u,v) Integrate w.r.t x from u to v
%
% sdpvar x1 x2
% p = 4*x1^4 + x1*x2;
% int(p) returns 0.8x1^5 + 0.5x1^2x2
% int(p,[x1 x2]) returns  0.25*x1^2*x2^2+0.8*x1^5*x2
% sdpvar s t
% int(p,[x1],s,t) returns 0.8*t^5-0.8*s^5+0.5*x2*t^2-0.5*x2*s^2
% See also JACOBIAN, HESSIAN

if nargin < 2
    xi = depends(f);
    xi = xi(1);
    x = recover(xi);
end

if nargin < 3
    from = zeros(length(x),1);
end

if nargin < 4
    to = x;
end

F = int_sdpvar(f,x,from,to);