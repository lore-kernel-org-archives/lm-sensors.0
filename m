From: olli.zimmermann@gmx.net (Oliver Zimmermann)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: get no informations on laptop acer extensa: Especially smart
Message-Id: <200411172342.09872.olli.zimmermann@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200411152320.53143.olli.zimmermann@gmx.net>
In-Reply-To: <200411152320.53143.olli.zimmermann@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i attached my sensors-detect output and my i2cdetect 0 output. 

thanks.

Olli



Am Dienstag, 16. November 2004 10:28 schrieb Jean Delvare:
> [please reply to the list, not to me]
>
> Hi Olli,
>
> > i bought an acer extensa 3002 laptop and install SuSE 9.1 with Kernel
> > 4.6.10.
>
> Wooo. But that kernel would not be out before decades, if not centuries!
> ;)
>
> > Acpi is supported and i can get many informations but there is no battery
> > support. I disassembled the DSDT and dont?t find any error. With
> > Windows XP the control manager dosn?t list a ACPI battery support but use
> > smart battery with SMBus. So i install lm_sensor latest version and do
> > sensors-detect. The script found i2c-i801 and load the module. But there
> > is only the eeprom module found, no other sensors/chips etc. sensors
> > listed only the eeprom and i2cdetect dosn?t find anything, i2cdump only
> > list i2c-0 unknown  SMBus I801 adapter at 1880  Algorithm unavailable. So
> > i think, thats not o.k. Also i?m not able to fiind a way to compile the
> > smartbat.c module in the subdirectory of lm_sensors.
>
> What you say here would suggest that the battery is not supported by ACPI
> so there is probably no need to search any further in that direction.
> BTW, ACPI and lm_sensors are almost completely separated, and we do not
> have enough knowledge about ACPI to help.
>
> The smartbatt driver that comes with lm_sensors is for Linux 2.4 and was
> not ported to 2.6 yet, so you won't get it to compile.
>
> > What?s wrong?
> >
> > i attached my lspci -v, my boot.msg and DSDT. Please help me.
>
> Doesn't help much except lspci which confirms that you have an
> i801-compatible SMBus. Please provide the full output of sensors-detect
> on your system, and the output of "i2cdetect 0".
>
> Thanks,
>
> --
> Jean Delvare
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cdetect.log
Type: text/x-log
Size: 635 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041117/8f820c05/i2cdetect.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors-detect.log
Type: text/x-log
Size: 7798 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041117/8f820c05/sensors-detect.bin
