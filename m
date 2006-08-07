From: vsu@altlinux.ru (Sergey Vlasov)
Date: Mon, 07 Aug 2006 19:34:12 +0000
Subject: [lm-sensors] BIOS Corruption (was : new abituguru driver in mm
Message-Id: <20060807233412.48ba78e3.vsu@altlinux.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
In-Reply-To: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 7 Aug 2006 09:09:45 -0701 Sunil Kumar wrote:

> Yeah, I tried that. Didn't help. I think BIOS reset might help, but I have
> to note down some settings before I do that (bigger exercise than just cmos
> jumper moves, which in itself involves opening the box....<yawn>). I am able
> to read/write all settings except for uguru temp screen. My system functions
> without any problems (none that I have noted), except it will not beep or
> shutdown if CPU were to become hotter than my tcase of 65C, which is
> possible if my cpu fan dies. With the fan working, at full load it stays
> around 45-46C.
> 
> Following is the actual output (245/235 I wrote from own memory) from
> sensors and my BIOS screen gets stuck when it prints "250C". The values I
> had set for these were either 60-65 or 65-75, I don't remember exactly (was
> more than 9 months ago).
> 
> $ sensors
> abituguru-isa-00e0
> Adapter: ISA adapter
> CPU Core Voltage:       +1.38 V (min  +1.00 V, max  +1.60 V)
> DDR Voltage:            +2.60 V (min  +2.10 V, max  +3.10 V)
> DDR VTT Voltage:        +1.31 V (min  +1.05 V, max  +1.55 V)
> nForce4 Standby Voltage:
>                         +1.51 V (min  +1.25 V, max  +1.85 V)
> CPU VDDA 2.5V Voltage:  +2.56 V (min  +2.00 V, max  +3.00 V)
> HyperTransport Voltage: +1.21 V (min  +0.94 V, max  +1.45 V)
> nForce4 Voltage:        +1.59 V (min  +1.25 V, max  +1.85 V)
> ATX +5V:                +5.02 V (min  +3.97 V, max  +5.98 V)
> ATX +3.3V:              +3.33 V (min  +2.63 V, max  +3.93 V)
> ATX 5VSB Voltage:       +5.00 V (min  +3.97 V, max  +5.98 V)
> ATX +12V:              +11.95 V (min  +9.56 V, max +14.34 V)
> CPU Temperature:          +33 C  (high =  +245 C, crit =  +250 C)

Hm, then this code in abituguru_detect_bank1_sensor_type() might be the
culprit:

	/* Volt sensor test, enable volt low alarm, set min value ridicously
	   high. If its a volt sensor this should always give us an alarm. */
	buf[0] = ABIT_UGURU_VOLT_LOW_ALARM_ENABLE;
	buf[1] = 245;
	buf[2] = 250;
	if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1 + 2, sensor_addr,
			buf, 3) != 3)
		return -ENODEV;

If this call succeeds, but then one of the two abituguru_read() calls
below fails for some reason, abituguru_detect_bank1_sensor_type()
returns without restoring the original sensor settings.

This method of probing looks dangerous - is there really no better way
to do it?

Now, the limits could be restored by writing the appropriate values to
sysfs, but there is no way to restore the corrupted flags (except for
patching the driver) - there is no sysfs attribute to control
ABIT_UGURU_VOLT_LOW_ALARM_ENABLE for a temperature sensor.

> SYS Temperature:          +30 C  (high =   +55 C, crit =   +65 C)
> PWM Temperature:          +36 C  (high =   +80 C, crit =   +90 C)
> CPU FAN Speed:         1740 RPM (min  900 RPM)
> NF4 FAN Speed:            0 RPM (min 1200 RPM)
> SYS FAN Speed:         1080 RPM (min  720 RPM)
> OTES1 FAN Speed:          0 RPM (min 1200 RPM)
> OTES2 FAN Speed:          0 RPM (min  720 RPM)
> AUX FAN Speed:            0 RPM (min 1200 RPM)
> 
> -Sunil
> 
> 
> On 8/7/06, Jean Delvare <khali at linux-fr.org> wrote:
> >
> > Hi Sunil, Hans,
> >
> > > I found an issue with the driver. It seems to have put something in the
> > > uguru part of BIOS, which makes my BIOS hang when I enter Abit uGuru
> > > temperature monitor screen in the BIOS. No keys work and only way for me
> > at
> > > that point is to give it the three finger salute. The peculiar thing I
> > > noticed was that somehow it modified the shutdown and beep CPU
> > temperatures
> > > to 245C and 235C while I had them set at 65C and 75C.
> > >
> > > As soon as the temp monitor displays 245C in CPU row, it just hangs. The
> > > next values to be displayed are the enable bit for these temps, I think.
> > >
> > > I never used the driver to write anything to BIOS, so how did it end up
> > > updating those values?
> >
> > Err, this is bad :(
> >
> > Hans, see why I was reluctant to having your driver in the kernel tree?
> > Nothing personal, but that kind of problem is to be expected when
> > writing a driver without a datasheet :(
> >
> > What should we do now? Mark the driver broken in the kernel tree?
> > 2.6.18 is just around the corner, and we sure don't want people to
> > corrupt their BIOS.
> >
> > Sunil, did you try a complete power-off (with PSU switched off or
> > unplugged) to see if the default values are back?
> >
> > --
> > Jean Delvare
> >
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 190 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060807/9d9eae6d/attachment.bin 
