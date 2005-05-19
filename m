From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: device matching
Message-Id: <20021025103633.60978848.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <011f01c27b57$49a53450$5100a8c0@office>
In-Reply-To: <011f01c27b57$49a53450$5100a8c0@office>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> "Mark Studebaker" said the followings
> > good tool for finding CPU temperature is 'cpuburn' 
> > (link on our links page)
> 
> Byounggwon :
> OK, I have found it already, and I will use the program.

I tried it myself yesterday on an old Pentium system with two temp
sensors to determine which was the CPU's and which was the M/B's. It
worked like a charm. While both temps were around 24?C before runing
burnP5, they went to 35?C and 28?C after a few minutes, so it was
obvious that the 35 was for the CPU. Thanks Mark :)

> Byounggwon :
> My result is
> temp1: +36?C (limit =  +60?C) sensor = thermistor
> temp2: +50.5?C (limit =  +60?C, hysteresis = +50?C) sensor > thermistor temp3: +63.5?C (limit =  +60?C, hysteresis =  +50?C) sensor
> = PII/Celeron diode ALARM The guess is not easy.
Well, it makes no doubt that temp3 is for the CPU. BTW, did you compared
these values with the BIOS' ones?
If the value is exact, 63.5?C is rather high and you should probably do
somethig.

> If Gigabyte send me some information which pin in the chip is
> connected with which device, and I know which value of w83781d is
> connected with which pin, then my problem will be over.
If you get such information, please share it with us :)
Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
