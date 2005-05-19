From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: lm_sensors 2.8.3
Message-Id: <1075457831.401a2f27ba69f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401291139.58838.jumpyboy@infinito.it>
In-Reply-To: <200401291139.58838.jumpyboy@infinito.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I see that in lm_sensors 2.8.2 my VIA VT8327 chipset is supported

I think you really mean VT8237?

> so I think  also in 2.8.3 that I installed, but when I rus
> sensor-detects on linux 2.6.1  at the end lm_sensors doesn't say
> of loading i2c-viapro. Maybe linux 2.6.1 has not got yet VIA VT8237
> chipset?

It has. Anyway, usually sensors-detect doesn't depend on the kernel
(apart from a very few quirks with hidden pci devides, maybe that's
what you have here...)

> I tryed linux 2.6.2-rc2 and lm_sensors  say me to load i2c-viapro,
> but sensors -s && sensors say: "no sensors available!".

The i2c-viapro driver is a bus driver. It gives you access to sensor
chips but doesn't drive them by itself. You need to find out which chip
driver you need. Sensors-detect *should* tell you which. If it doesn't,
maybe you have an unsupported chip, or no compatible chip at all (usual
on laptops). You may send the whole output of sensors-detect for
analysis. Do not forget to unload all i2c-related drivers before so as
not to confuse sensors-detect.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
