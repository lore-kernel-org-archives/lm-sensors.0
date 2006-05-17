From: santiago.alban@gmail.com (Santiago Alban)
Date: Wed, 17 May 2006 00:30:34 +0000
Subject: [lm-sensors] question about your driver
Message-Id: <9d6ab59b0605161730j18f3f86y8ce7f16783af48cf@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9d6ab59b0605161158l1352e1a1u631f4869fd9f9db5@mail.gmail.com>
In-Reply-To: <9d6ab59b0605161158l1352e1a1u631f4869fd9f9db5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
Thank you very much for your prompt reply.  Your suggestion that the
hardware monitor may not be enabled was key. In fact, what was not ebabled
were the *IO permissions* to the LPC IO window that communicates with the
Winbond chip.  I think this is a very specific quirk for this board, and
through reading some of the documentation and code examples for the SC2200,
I think I figured out how to enable it.  If you'd like to document more
detail about this, I'll be happy to send you more detail.

Regarding your other comments, I was never able to run isadump command, as
Busybox doesn't have it.
I also reran the sensors-detect script, but there were no other i2c busses
found.

Thanks again
Santiago


On 5/16/06, Jean Delvare <khali at linux-fr.org> wrote:
>
> Hi Santiago,
>
> > If you have a moment, I'd really appreciate your comments on a problem
> I'm
> > having...
> >
> > We (my company) are running Busybox on an embedded application, with
> Linux
> > Kernel version 2.4.31. The motherboard is a Geode SC2200, which has a
> > Winbond W83627HF Super IO chip.  I've verified the chip is present,
> > visually.  I've also successfully compiled the i2c and lm-sensors
> modules,
> > and I think I've installed correctly in an embedded device.
>
> Which version of i2c and lm_sensors are you using, please?
>
> > Your documentation is very clear on how to install this stuff, but given
> > that I'm trying to use this driver in an embedded application, I've had
> to
> > do some things differently.  Namely,
> > 1.  Since the embedded app doesn't have a compiler installed, I had to
> > compile externally from the machine it would be installed on, and point
> to
> > the correct headers (V2.4.31) from the makefile.
> > 2.  I had to manually move the *.o files and libraries from the "staged"
> > installation to the device.
> >  3.  Only one prototype we have in the lab is able to run perl scripts,
> so
> > for now I'm using that one so I could use sensors-detect. This script
> found
> > the the SIO chip on the ISA bus, at address 0x290, and gave me some
> names of
> > modules to install.
> > 4.  Busybox doesn't have depmod, and modprobe seems to need some *.ko
> files
> > I don't have.  But after some effort, I managed to install all the
> modules
> > needed with insmod.  From /proc/modules, I verified that the following
> > modules were installed:
> > i2c-core.o
> > i2c-proc.o
> > i2c-dev.o
> > i2c-isa.o
> > w83627hf.o
> >
> > I then did a small edit of sensors.conf, to read a +12V battery voltage
> from
> > the "in6" analog input.
> >
> > Finally, when I ran the sensors program, I essentially get all 0xFF
> readings
> > from the sensors (see below).
> > Have you guys ran into this before?  If so, do you have any
> > recommendations?  Am I missing any necessary modules?
> >
> > w83627hf-isa-0290
> > Adapter: ISA adapter
> > VCore 1:   +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
> > VCore 2:   +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
> > +3.3V:     +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
> > +5V:       +6.85 V  (min =  +6.85 V, max =  +6.85 V)       ALARM  (beep)
> > +12V:     +15.50 V  (min = +15.50 V, max = +15.50 V)       ALARM  (beep)
> > -12V:      +6.06 V  (min =  +6.06 V, max =  +6.06 V)       ALARM  (beep)
> > Batt Volt:+31.21 V  (min = +31.21 V, max = +31.21 V)       ALARM  (beep)
> > V5SB:      +6.85 V  (min =  +6.85 V, max =  +6.85 V)       ALARM  (beep)
> > VBat:      +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
> > fan1:        0 RPM  (min =    0 RPM, div > 128)              ALARM  (beep)
> > fan2:        0 RPM  (min =    0 RPM, div > 128)              ALARM  (beep)
> > fan3:        0 RPM  (min =    0 RPM, div > 128)              ALARM  (beep)
> > temp1:        -1 C  (high =    -1 C, hyst =    -1 C)   sensor = diode
> ALARM   (beep)
> > temp2:      +0.0 C  (high =    +0 C, hyst =    +0 C)   sensor = diode
> ALARM   (beep)
> > temp3:      +0.0 C  (high =    +0 C, hyst =    +0 C)   sensor = diode
> ALARM   (beep)
> > vid:      +0.000 V  (VRM Version 8.2)
> > alarms:   Chassis intrusion detection                      ALARM
> > beep_enable:
> >           Sound alarm enabled
>
> Unfortunately, this output suggests that the hardware monitoring
> features of the W83627HF chip are not used. The function may not even be
> activated.
>
> Please provide the output of "isadump 0x295 0x296" (as root).
>
> Are you certain that the W83627HF chip is used for hardware monitoring
> on your system? Are you certain that this system does support hardware
> monitoring at all? It would help if you have technical documentation
> for the board explaining how hardware monitoring is implemented.
>
> On the Geode SC2200 you should be able to use the scx200_acb and/or
> scx200_i2c drivers. If you have a dedicated hardware monitoring chip on
> your system, it would be connected to one of these busses.
> sensors-detect should be able to scan these busses if you load the
> drivers before running the script. Try scx200_acb first.
>
> --
> Jean Delvare
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060517/a6ba11de/attachment.html
