% rotate clockwise
i = sqrt(-1);
p = complex(0.075 + 0.29 - 0.1, 0.1 + 0.2); % world space
p_30 = p * exp(30/180*pi* i); % configuration space rotate 30 degrees
offset = complex(0.075, 0.1);

