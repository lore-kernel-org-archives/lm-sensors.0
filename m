From: bmeier@infovia.com.ar (Beat Meier)
Date: Wed, 17 Aug 2005 01:54:12 +0000
Subject: [lm-sensors] lm77 driver locks up with kernel-2.6.12
Message-Id: <43027C3E.6020309@infovia.com.ar>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

I'm doing temperature tests with lm77, kernel-2.6.12 on wrap.
There seems to be a problem with the driver or driver/kernel.
Sometimes the temperature is read bad and somthing locks up.
It begins with all temp values read are 40955500
and all temp_hist  are 0 except critical hyst which is min_hist which is 
81910000.
After that there is no chance get the values.
Sometimes only some values are corrupted in the read then the next read
is ok.
First I tought this is the lm77 or the board because on an other board 
there was ok
but now there is is also the same problem.

for example a read of temp_input needs 3 seconds

If you remove the drivers with
rmmod scx200_acb lm77 ic2_sensor  ic2_core
abd insert it again
the /sys/bus/i2c/drivers/lm77
directory is empty

If you remove and put again the modules before this problem with the bad 
values occures
it works i.e. the directory contains values and you can read temperatures.

BTW: What I do is a cat of every temp* file in a script and this scripts 
runs every 2 seconds

What's wrong? Anyone having this problem?

Greetings

Beat
