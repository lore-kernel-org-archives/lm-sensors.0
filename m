From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: New LM83 driver
Message-Id: <20030812191335.795b5112.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809231304.74f73999.khali@linux-fr.org>
In-Reply-To: <20030809231304.74f73999.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I only downloaded the lm83.c file and recompiled it. How do I see/test
> the status register? I was expecting something from the sensors
> output.

You need to check a fresh CVS out in order to see the changes, because
not only the driver, but also the library and userspace tools, have
changed. Also note that you'll need i2c-CVS too.

> The sensors output was:
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> temp1:       +36?C  (limit = +100?C)                      
> temp2:       +39?C  (limit = +100?C)                      
> temp3:       +50?C  (limit = +100?C)                      
> temp4:       +42?C  (limit = +100?C)        
> 
> In the proc filesystem Ive got:
> # ls /proc/sys/dev/sensors/lm83-i2c-0-19/
> alarms  tcrit   temp1   temp2   temp3   temp4   
> 
> # cat /proc/sys/dev/sensors/lm83-i2c-0-19/tcrit
> 120
> # cat /proc/sys/dev/sensors/lm83-i2c-0-19/alarms 
> 0

So far so good, let's see if the library and userspace tools code is ok
too.

Oh, another thing. I'm still wondering which elements of your PC the
temperatures shown here can correspond to. Temp1 is the LM83's own
temperature. We guessed that temp3 had to be the CPU's one. We have
temp2 and temp4 left. The datasheets gives a Battery and a LCD as
examples, but I don't think you have such devices on your system, do
you? So I still believe the North and South bridges are good candidates.

Could you remind me what the brand and model of your motherboard are?
Maybe I could take a look at the online docs and see if I can learn
something there. And anyway, I'd like to mention the motherboard's model
in our docs as "known to have a LM83 on it".

Thanks a lot!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
