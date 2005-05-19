From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: lm_sensors2/prog/sensors chips.c
Message-Id: <20021203140140.730a9967.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021128172256.1841b834.khali@linux-fr.org>
In-Reply-To: <20021128172256.1841b834.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> ddcmon reports the contents of the eeprom on a monitor.
> If you hvae a video chip which has an i2c bus driver,
> then it should work. Can you do i2cdetect and i2cdump
> on the i2c bus connected to the monitor?

Actually I finally get it working:

ddcmon-i2c-1-50
Adapter: DDC:fb0 #0 on i2c-matroxfb
Algorithm: Bit-shift algorithm
Monitor ID:             DEL635>
Serial number:          959595606
Monitor Size (cm):      23x30
Vertical Sync (Hz):     0-0
Horizontal Sync (KHz):  0-0

I guess it had first being confused by the eeprom module I do load for
the piix4 chipset I have also.

One question comes to mind. The /etc/modules.conf file may contain
references to i2c bus numbers (to ignore or force adresses). But the
order in which the bus drivers are loaded (if there are more than one)
has an importance there. So, am I right to assume that if the modules
are not loaded in the correct order, the options lines will be bad? Is
there a way to force a bus number for a given bus driver?

(May I get the ddcmon specs for free somewhere?)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
