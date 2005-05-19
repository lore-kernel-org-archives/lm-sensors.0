From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: problem with it87.o
Message-Id: <20030816142003.3f7f4860.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
In-Reply-To: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I've got a small bugreport for the it87 driver.
> The driver loads fine, and i get normal readings afterwards, but as
> soon as the driver loads, my cpu fan gears up to it's maximum rpm,
> even though the temperature is still low enough.
> 
> I have a shuttle sn41g2 pc, with the nforce2 chipset. The board
> supports variable fan speeds, it monitors cpu temperature, and sets
> fan speed accordingly. Up to the point where i load the it87 module
> that is :)
> 
> I'm running kernel 2.4.20, i2c and lm-sensors version 2.8.0
> bios version fn41s019. Should you need more info just ask.

Does the fan keep a high speed for always, or does is goes down after
some times?

Does the "sensors" program report any alarm? (a "cat" on the alarms file
could help too)

Can you confirm the fan speedup is caused by loading the driver, and not
by running "sensors -s"? (Many scripts will do both in a row.)

Does using the temp_type parameter with various values (read
doc/chips/it87) have any influence (except giving very bad temperatures)
on the fan speed?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
