From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <aqbCAbPX.1108715731.1908550.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Christophe,

> I plead guilty for one confusion i did. I did use the printk stuff :
> (...)
> And i realised that when adding the patch manually to the 2.6.8.1 kernel,
> although it was a patch done for kernel 2.6.10, i inserted the "case"
> lines for w1n in the wrong if section. I inserted it for the
> PCI_DEVICE_ID_INTEL_82855GM_HB when it was for
> PCI_DEVICE_ID_INTEL_82855PM_HB

Ok, at least that explains it all. I'll push the patch upwards.

> So now the patch is correctly applied and could run sensors-detect
> successfully.
> Actually, sensors-detect did not detect the adt7463 chip.

This is a problem. Can you please provide a dump of your chip (using
i2cdetect to locate the correct address and i2cdump to do the actual
dump)?

> But i added
> everything in the config files to insert automatically the lm85 modules,
> without any parameters, when the lm_sensors service is started.
> So now, i can reduce manually the fan speed and have a longer battery
> time.

I admit I am surprised, I never thought that lowering the speed of the
fan could really spare a significant amount of battery.

> One more question : is there a way to adjust fan speed to one of the
> temperature ?
> Or do i have to write a little script ?

The LM85 and friend chips supposedly have hardware temperature-driven fan
control.

> Why can't i modify the content of
> the /sys/bus/i2c/devices/0-002e/fan1_pwm_enable (it contains '1') ?
> What is the purpose of these fan*_pwm_enable files ?

This means that fan control is enabled for this fan output (which may or
may not be physically wired to an actual fan on your system).

See this file for additional insight:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/lm85

Not everything might exactly apply to the 2.6 kernel version of the
driver but that will still give you a good idea of the chip capabilities
and how it can be configured.

--
Jean Delvare
