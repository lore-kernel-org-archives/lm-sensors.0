From: christophe.dr@free.fr (christophe)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <200502211617.18707.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> >It doesn't seem to set fan speed at a low rpm (not less than 3000 rpm,
> > that's too fast) as i expected, but it might be due to my inappropriate
> > settings... Actuall i read this document :
> >http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/lm85
> >but did not understand a lot of it...
> I'm sorry.  Is there any particular section that was confusing?  What
> could I explain better?

Well, "i" am sorry, i read the document about lm85 chip and i may not have 
enough technical knowledges to understand how to give the right parameters 
in /etc/sensors.conf
This is the intersting part of this file (in the lm85 and co section) :

set pwm1_zone 123
set pwm1_min_ctl 0
set pwm1_min 0

set temp1_min 20
set temp1_max 60       # dothan's max temp is actually around 100?C
set temp2_min 10
set temp2_max 45
set temp3_min 10
set temp3_max 45

If i run "sensord -i 1m -l 30m", i read this in /var/log/syslog :
Error getting sensor data: adt7463/fan1_tach_mode: Can't access procfs/sysfs 
file

I get the same message in /var/log/syslog if put this line 
in /etc/sensors.conf:

set fan1_tach_mode 0

I can't understand that... Actually this may be the reason why the fan doesn't 
seem to follow the policy i give him in /etc/sensors.conf, as i told before.

> >In spite of my settings the fan1_pwm is always at a minimum of 127, which
> >means a little more than 3000 rpm. Quite noisy and "energy-consuming". I
> > can only set fan to a lower velocity (around 1800 rpm) with this command
> > : echo 77 > fan1_pwm (for example)
> >Actually when cpu is very busy, cpu temperature increases and fan speed
> > also. When cpu is less busy,  cpu temperature decreases and fan speed
> > also, but never below 3000 rpm which corresponds to fan1_pwm7. Never
> > less than 127, except if i set it by myself.
> >In spite of my "set pwm1_zone 123" setting, fan speed does not increase
> > when zone 3 has an increase in temperature : zone 3 seems to be the gpu,
> > because it gets very hot when i use opengl with a game or a screensaver.
> >That's a problem because if gpu temperature gets too high, that doesn't
> > smell good.
> Is this a 2.4 or a 2.6 kernel?

The kernel is 2.6.8.1 with a patch for quirks.c to detect the adt7463 chip on 
my asus w1n laptop.

> Can you send the current values of all your current settings by running
> something like:
>    head /proc/sys/dev/sensors/adt7463*/*

No sensors directory in /proc/sys/dev/ ! Shall i recompile again with some 
other options ?

> which will work on 2.4.  If you're using 2.6, you'll need to do
> something similar in /sys

Ah ! OK so here is what i get if i run "head /sys/bus/i2c/devices/0-002e" :

=> alarms <=
394

=> detach_state <=
0

=> fan1_input <=
0

=> fan1_min <=
500

=> fan1_pwm <=
0

=> fan1_pwm_enable <=
1

=> fan2_input <=
0

=> fan2_min <=
0

=> fan2_pwm <=
255

=> fan2_pwm_enable <=
1

=> fan3_input <=
0

=> fan3_min <=
0

=> fan3_pwm <=
255

=> fan3_pwm_enable <=
1

=> fan4_input <=
0

=> fan4_min <=
0

=> in0_input <=
0

=> in0_max <=
1576

=> in0_min <=
1419

=> in0_ref <=
1850

=> in1_input <=
1207

=> in1_max <=
1945

=> in1_min <=
1758

=> in2_input <=
3369

=> in2_max <=
3472

=> in2_min <=
3128

=> in3_input <=
3281

=> in3_max <=
5260

=> in3_min <=
4740

=> in4_input <=
0

=> in4_max <=
12625

=> in4_min <=
11375

=> name <=
adt7463

=> power <=
head: Erreur lors de la lecture `power': Is a directory

=> temp1_input <=
54000

=> temp1_max <=
60000

=> temp1_min <=
30000

=> temp2_input <=
48000

=> temp2_max <=
50000

=> temp2_min <=
20000

=> temp3_input <=
48000

=> temp3_max <=
50000

=> temp3_min <=
20000

=> vrm <=
91



I thought that the the chip itself could handle fan speed according to 
temperatures. Shall i use fancontrol instead ?


Thank you.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCGft9oBxdxgioZBIRAgbGAJ9xOH8pb727lRi/6tvyfrVpMrXgsQCePhmi
4nWN8ZGuQ1gYGAX84QhCqnA=DyR6
-----END PGP SIGNATURE-----
