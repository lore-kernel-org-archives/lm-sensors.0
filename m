From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: lm_sensors ain't updating cpu temp
Message-Id: <20040830100043.M57839@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1093792983.3809.5.camel@84.xa.interkam.pl>
In-Reply-To: <1093792983.3809.5.camel@84.xa.interkam.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > I'm using lm_sensors 2.8.5 with 2.6.3-7mdk kernel.
> >
> > Which driver ? Which chip ? Anything relevant in the logs? Sample output
> > from "sensors" ?
> 
> I don't know what do you mean saying 'driver'.

I mean the part of the kernel which is specifically handling your hardware
monitoring chipset. We usually also refer to them as "modules" because they
can be built apart from the kernel itself, and loaded and unloaded at will.

According to what you write below, you are using the driver "w83781d".

> The chipset is VIA VT8233A.

That's not quite what I was referring to. I did not mean the main chipset on
your motherboard, but the hardware monitoring chipset. According to what you
write just below, your chipset is a Winbond W83697HF.

> I don't know where to find logs (I'm a real newbie).

Usually in /var/log, in files named syslog, messages and/or debug. Exact names
and contents depend on the distribution. You can also watch the kernel log
buffer by running "dmesg".

> Here's the sample output :
> 
> w83697hf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.79 V  (min =  +1.71 V, max =  +1.89 V)
> +3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.46 V)
> +5V:       +4.76 V  (min =  +4.73 V, max =  +5.24 V)       ALARM
> +12V:     +12.65 V  (min = +10.82 V, max = +13.19 V)
> -12V:     -12.85 V  (min = -13.18 V, max = -10.88 V)
> -5V:       -5.55 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
> V5SB:      +5.48 V  (min =  +4.73 V, max =  +5.24 V)
> VBat:      +3.25 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:     4245 RPM  (min =   -1 RPM, div = 2)              ALARM
> fan2:        0 RPM  (min = 5273 RPM, div = 2)              ALARM
> temp1:       +39?C  (high =    +0?C, hyst =  +105?C)   sensor > thermistor   ALARM
> temp2:     +53.5?C  (high =  +120?C, hyst =  +115?C)   sensor > thermistor

OK, it looks rather good overall. If I understand what you first said
correctly, temp1 is changing, but temp2 isn't and will always read 53.5 degrees?

What are the brand and model name of your motherboard?

> Though I had to use module w83781d instead of w83697hf (which isn't
> supported in my kernel version, right?)

The alternative (and prefered when possible) driver to w83781d is named
w83627hf, and you're right, it wasn't present in the 2.6.3 kernel yet. w83781d
driver should work too anyway.

> > If you have the possibility to upgrade kernels (and lm_sensors) I would
> > try that, since 2.6.3 is somewhat old now.
> 
> I was told that the latest stable kernel version for mandrake10.0
> official is 2.6.3-15mdk (once again: I'm a newbie) so I don't believe
> that the upgrade could change something.

It's hard to say. Mandrake may have been backporting patches. After all, there
must be differences and improvements, or there would not be new kernel
packages released. Do you know if a list of the changes exists?

I also think I remember that there are alternative, semi-official kernel
packages for Mandrake. It may only be for Cooker and not for 10.0 though. And
it may not be the easiest thing to try if you're just starting with Linux.

-- 
Jean Delvare
http://khali.linux-fr.org/
