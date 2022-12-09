function [net, deltaW, deltaB] = rprop(net, derW, derB, precDerW, precDerB, deltaW, deltaB, etaP, etaN)
    for layer = 1 : net.getLayersNum()-1
        % Calcolo il segno del prodotto tra le nuove g(t) e le vecchie g(t−1) derivate (t = epoca)
		% prodSign = sign(g(t−1) * g(t))
		prodSign = sign(derW{layer} .* precDerW{layer});

        % Calcolo i delta dei pesi
        deltaW = getDelta(deltaW, layer, prodSign, etaP, etaN);
		
		% Aggiornamento dei pesi
		% Δw(t) = -sign(g(t)) * Δ(t)
        % w(t) = w(t) + Δw(t)
		deltaW_t = (-sign(derW{layer})) .* deltaW{layer};
		net = net.setNetWeight(layer, net.getNetWeight(layer) + deltaW_t);
		
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				
		% Eseguo le operazioni precedenti ma questa volta per i bias
		% prodSign = sign(g(t−1) * g(t))
		prodSign = sign(derB{layer} .* precDerB{layer});

        % Calcolo i delta dei bias
        deltaB = getDelta(deltaB, layer, prodSign, etaP, etaN);
		
		% Aggiornamento dei bias
		% Δb(t) = -sign(g(t)) * Δ(t)
        % b(t) = b(t) + Δb(t) 
		deltaB_t = (-sign(derB{layer})) .* deltaB{layer};
		net = net.setNetBias(layer, net.getNetBias(layer) + deltaB_t);
    end
end

function delta = getDelta(delta, layer, prodSign, etaP, etaN)
    % Parametri di default della rProp
	deltaMin = 1e-6;
	deltaMax = 50;

    %delta{layer} = ((prodSign > 0) .* min(etaP * delta{layer}, deltaMax)) + ...
    %                ((prodSign <= 0) .* max(etaN * delta{layer}, deltaMin));

    % Calcolo i delta
    for i = 1 : size(prodSign, 1)
        for j = 1 : size(prodSign, 2) 
            if prodSign(i, j) > 0 
                % Δij(t) = min(η+ * Δij(t), Δmax)
		        delta{layer}(i, j) = min(etaP * delta{layer}(i, j), deltaMax);
            elseif prodSign(i, j) < 0
                % Δij(t) = max(η- * Δij(t), Δmin)
		        delta{layer}(i, j) = max(etaN * delta{layer}(i, j), deltaMin);
            %{
	        else prodSign(prodSign_i, prodSign_j) == 0
	            Δij(t) = Δij(t)
            %}
            end
        end
    end
end