From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: W83L785R Support
Message-Id: <20040221195733.4441a609.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200402201842.48537.coflynn@newae.com>
In-Reply-To: <200402201842.48537.coflynn@newae.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The CVS of RivaTuner works, thanks for the tip! I got it compiled up
> and inserted the modules - 3 new I2C buses show up in I2C detect, with
> one of them having two devices on it (one device is the W83L785R -
> yes!), one having nothing on it, and one having an EEPROM, and a DDC
> Monitor (from sensors-detect). (this is after I set the W83L785R back
> on the I2C bus on the video card itself)

OK, I've added your PCI ID to the list of cards supported by rivatv to
sensors-detect. Can you get it here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect
and confirm that it now detects it and propose you to load rivatv?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
