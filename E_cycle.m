%matlab project function
function[E_state]=E_cycle(R,G,B) %Based on RGB fluorescent levels we can produce a read telling the user what state of the estrous cycle we are in
if B>G&&B>R;
    E_state='Diestrous'
elseif G>B&&G>R
    E_state='Proestrous'
elseif R>G&&R>B
    E_state='Estrous'
else
    E_state='Metestrous'
end 

