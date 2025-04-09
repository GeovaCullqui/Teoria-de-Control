
k =60;
tau = 10;
theta = 3;

num = k;
den = [tau 1];

G = tf(num, den,"InputDelay", theta);
 