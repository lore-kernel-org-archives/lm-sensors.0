From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <4217D1A8.3020309@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

christophe wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>  
>
>>Adapter is 0, address is 0x2e.
>>modprobe lm85 force_adt7463=0,0x2e
>>In other words it's exactly the same parameters you used for i2cdump.
>>Easy :)
>>    
>>
>
>Great ! That works !
>
>Now i have another question : i've put these lines in /etc/sensors.conf in the 
>lm85 and co section :
>
>set pwm1_zone 123
>set pwm1_min_ctl 0
>set pwm1_min 0
>
>set temp1_min 20
>set temp1_max 60       # dothan's max temp is actually around 100?C
>set temp2_min 10
>set temp2_max 45
>set temp3_min 10
>set temp3_max 45
>
>It doesn't seem to set fan speed at a low rpm (not less than 3000 rpm, that's
>too fast) as i expected, but it might be due to my inappropriate settings...
>Actuall i read this document :
>http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/lm85
>but did not understand a lot of it...
>  
>
I'm sorry.  Is there any particular section that was confusing?  What 
could I explain better?

>In spite of my settings the fan1_pwm is always at a minimum of 127, which
>means a little more than 3000 rpm. Quite noisy and "energy-consuming". I can
>only set fan to a lower velocity (around 1800 rpm) with this command :
>echo 77 > fan1_pwm (for example)
>Actually when cpu is very busy, cpu temperature increases and fan speed also.
>When cpu is less busy,  cpu temperature decreases and fan speed also, but
>never below 3000 rpm which corresponds to fan1_pwm7. Never less than 127,
>except if i set it by myself.
>In spite of my "set pwm1_zone 123" setting, fan speed does not increase when
>zone 3 has an increase in temperature : zone 3 seems to be the gpu, because it
>gets very hot when i use opengl with a game or a screensaver.
>That's a problem because if gpu temperature gets too high, that doesn't smell 
>good.
>  
>
Is this a 2.4 or a 2.6 kernel?

Can you send the current values of all your current settings by running 
something like:

   head /proc/sys/dev/sensors/adt7463*/*

which will work on 2.4.  If you're using 2.6, you'll need to do 
something similar in /sys


Thanks,
:v)
