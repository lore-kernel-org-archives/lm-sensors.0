From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: LM83 sensor
Message-Id: <20030702105239.07ae16f9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43612812.20030701105509@matrixc.ru>
In-Reply-To: <43612812.20030701105509@matrixc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> lm_sensors work with ITE 8705 chip, but sensors value incorect (CPU
> temp. is very high, voltages not corespond value shown in BIOS, etc.)

This may simply be a configuration issue (especially for the
temperaturs, did you tried the temp_type module parameter?)

Are you using i2c & lm_sensors 2.7.0 or CVS?

As is, the sensors-detect script should have detected your LM83 as a
LM84 and asked you to load the adm1021 module. Did it actually happen?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
