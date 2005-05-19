From: vdykt@icon.co.za (Tobias van Dyk)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] Abit uGuru
Message-Id: <428A38E8.2000801@icon.co.za>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I recently tried Olle Sandberg's test code for reading the Winbond 
W83L950D ports (aka uGuru) on an ABIT AG8-V. Provided his uGuru detect 
routine is shorted I got satisfactory results on this MB - as shown below

How do I go about to help to include a partial implementation into 
lm_sensors (or alternatively is it more feasible to think of a GKrellM 
plugin)?

I must confess that I miss the temperature readings on my PC because the 
current (windows) speedfan beta now understands uGuru.

If required I can post the Olle Sandberg ollebull@gmail.com February 
2005 source.


[root@linux64 uguru]# /root/uguru/openGuru
uGuru detected!

Temperatures:
CPU:            42C
SYS:            36C
PWM:            38C

Voltages:
Vcore:          1.40V
DDRVdd:         2.67V
DDRVtt:         1.35V
NBVdd:          2.89V
SBVdd:          1.23V
HTVdd:          1.55V
AGPVdd:         2.55V
Vdd5V:          5.05V
Vdd3V3:         3.30V
Vdd5VSB:        5.02V
Vdd3VDual:      0.65V

Fans:
CPU fan:        1800RPM
NB fan:         3660RPM
SYS fan:        1080RPM
AUX fan1:       0RPM
AUX fan2:       0RPM


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
