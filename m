From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: i850 && lm_sensors
Message-Id: <20030726193921.1fe38d01.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ondrej,

> i2cdump 0 0x44:

I don't know what this one is. Your main device (see below) has no
sub-address AFAICT. If you re-run the command some times later, are the
values still the same?


> (1) a hardware monitoring ASIC (Analog Devices ADM1025, Philips
> Semiconductor NE1619, or equivalent) include:
> (...)
> (2) hardware monitoring and fan control ASIC (Analog Devieces ADM1027,
> National Semiconductor LM85, Standart Microsystems SMSC EMC6D101, or 
> equivalent) include:

We already have support for ADM1025, ADM1027, LM85 and EMC6D101, so your
chip has to be a NE1619. I took a look at your i2cdump and it matches,
I'm 95% sure it's a NE1619. The chip is pin-to-pin compatible with the
ADM1025, and register compatible too as far as I can say.

I just added detection for the NE1619 to our sensors-detect script.
Please grab it there:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect

Could you please give it a try? It should detect your chip at 0x2d as a
NE1619 with confidence 8, and suggest adm1025 as the driver. Then you
could try forcing the adm1025 driver:

modprobe adm1025 force_adm1025=0,0x2d

Let us know how it works. Since both chips seem to be compatible, I
expect it to give very good result. If you confirm that, I'll add the
NE1619 ID to the driver so that the force parameter isn't necessary
anymore.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
