From: simone.marchi@ilc.cnr.it (simone marchi)
Date: Fri, 08 Sep 2006 14:52:24 +0000
Subject: [lm-sensors] w83627ehf-isa-0290 CPU fan rpm: wrong value
Message-Id: <loom.20060908T163738-492@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear all,
I've a problem with that sensors about CPU fan RPM value reported.
My motherboard is a Asus A8V-E SE. 
I use SuSE 10.1. (2.6.16.21-0.13-default)

The sensors command report sometimes a correct value (~2200rpm) 
and other time a wrong value (~140rpm).
I've seen that the multiplier of the fan (fan2_div for me) 
switch between 4 and 64.
I tried to force manually the value to 4 by this command:
 
echo -n "4" > /sys/bus/i2c/devices/9191-0290/fan2_div
but I've got a "permission denied" (I ran the command as root)

If I list that file I got that result:
-r--r--r-- 1 root root 0 2006-09-08 16:43 
            /sys/bus/i2c/devices/9191-0290/fan2_div

So, I can't modify that value.
I've tried to chmod the fan2_div, but I can't chage the value yet.

I tried also with a more recent kernel (2.6.18-rc6) but
I got the same error
(with new kernel I can monitoring, in addition, the voltages)

Does anyone help me?

Thank you
Ciao simone


