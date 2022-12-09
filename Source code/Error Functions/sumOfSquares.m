% Funzione della somma dei quadrati
function y = sumOfSquares(output, target)
    y = sum(sum((output-target).^2,2) /2);
end