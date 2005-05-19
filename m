From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: LM83 sensor
Message-Id: <20030702112716.74f0978f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43612812.20030701105509@matrixc.ru>
In-Reply-To: <43612812.20030701105509@matrixc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> lm_sensors work with ITE 8705 chip, but sensors value incorect (CPU
> temp. is very high, voltages not corespond value shown in BIOS, etc.)
> 
> Also send screenshot form Sandra 2003

Thanks for the shot. Unfortunately, it doesn't say on which chipset each
sensor is located :/

I've added preliminary LM83 detection to our sensors-detect script.
Could you please get it from
 
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect
and give it a try? Preferably unload all sensors modules before doing so
and send us a whole log of the script run (using script or whatever).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
