From: gbg@exacube.co.kr (Byounggwon)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: device matching
Message-Id: <025c01c27bc8$5d8220c0$5100a8c0@office>
List-Id: <lm-sensors.vger.kernel.org>
References: <011f01c27b57$49a53450$5100a8c0@office>
In-Reply-To: <011f01c27b57$49a53450$5100a8c0@office>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean and Mark.

Thank you for your replys
Please see in the below.

----- Original Message ----- 
"Jean Delvare" said followings
> Anyway, if you have a correct sensors.conf in /etc, most values should
> be already correctly labelled (but again, we can't prevent manufacturers
> from connecting the probes the way they want).

Byounggwon :
OK, I see. On Gigabyte's 8IRXR M/B, there are two monitoring chipsets.
W83627HF monitors 2 fans, Vcore, Vcc18, Vcc3, +12V, -12V, and 3 temps.
It's configuration is some different from normal lm_sensors's configuration.
But, I think I can request Gigabyte to send the information to me.

----- Original Message ----- 
"Mark Studebaker" said the followings
> good tool for finding CPU temperature is 'cpuburn' 
> (link on our links page)

Byounggwon :
OK, I have found it already, and I will use the program.
Thank you.

----- Original Message ----- 
"Jean Delvare" said the followings
> > 1* CPU temp is always higher that SYS temp. PS temp is usually bewteen
> > CPU and SYS temp.
> 
> I have to correct myself here. See my own temps:
> M/B Temp:   +35?C     (limit =  +42?C, hysteresis =  +40?C)        
> CPU Temp:  +50.4?C  (limit =  +60?C, hysteresis =  +56?C)     (beep)
> P/S Temp:    +30.0?C  (limit =  +42?C, hysteresis =  +40?C)        
> The CPU has the higher temperature, but M/B is hotter than P/S. So, take
> care not to conclude too fast.

Byounggwon :
My result is
temp1:  +36?C     (limit =  +60?C)                                 sensor = thermistor
temp2:  +50.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = thermistor
temp3:  +63.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = PII/Celeron diode ALARM
The guess is not easy.

OK
If Gigabyte send me some information which pin in the chip is connected
with which device, and I know which value of w83781d is connected with
which pin, then my problem will be over.
I have dug the w83781d.c and W83627HF Document for some days,
but the c program is very long, and it is not easy to find out.
Please help me.

Once more, I really thank you for your replys.

Byounggwon(gbg@exacube.co.kr)
