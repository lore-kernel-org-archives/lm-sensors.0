From: santiago.alban@gmail.com (Santiago Alban)
Date: Tue, 16 May 2006 18:58:45 +0000
Subject: [lm-sensors] question about your driver
Message-Id: <9d6ab59b0605161158l1352e1a1u631f4869fd9f9db5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear lm-sensors,
First of all, thanks a lot for developing and posting this driver! It's the
only one I've been able to find for our hardware running linux.
I tried to fill out a ticket, but this service is apparently undergoing an
upgrade and was unavailable.

If you have a moment, I'd really appreciate your comments on a problem I'm
having...

We (my company) are running Busybox on an embedded application, with Linux
Kernel version 2.4.31. The motherboard is a Geode SC2200, which has a
Winbond W83627HF Super IO chip.  I've verified the chip is present,
visually.  I've also successfully compiled the i2c and lm-sensors modules,
and I think
I've installed correctly in an embedded device.
Your documentation is very clear on how to install this stuff, but given
that I'm trying to use this driver in an embedded application, I've had to
do some things
differently.  Namely,
1.  Since the embedded app doesn't have a compiler installed, I had to
compile externally from the machine it would be installed on, and point to
the correct headers (V2.4.31) from the makefile.
2.  I had to manually move the *.o files and libraries from the "staged"
installation to the device.
 3.  Only one prototype we have in the lab is able to run perl scripts, so
for now I'm using that one so I could use sensors-detect. This script found
the the SIO chip on the ISA bus, at address 0x290, and gave me some names of
modules to install.
4.  Busybox doesn't have depmod, and modprobe seems to need some *.ko files
I don't have.  But after some effort, I managed to install all the modules
needed with insmod.  From /proc/modules, I verified that the following
modules were installed:
i2c-core.o
i2c-proc.o
i2c-dev.o
i2c-isa.o
w83627hf.o

I then did a small edit of sensors.conf, to read a +12V battery voltage from
the "in6" analog input.

Finally, when I ran the sensors program, I essentially get all 0xFF readings
from the sensors (see below).
Have you guys ran into this before?  If so, do you have any
recommendations?  Am I missing any necessary modules?

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
VCore 2:   +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
+3.3V:     +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
+5V:       +6.85 V  (min =  +6.85 V, max =  +6.85 V)       ALARM  (beep)
+12V:     +15.50 V  (min = +15.50 V, max = +15.50 V)       ALARM  (beep)
-12V:      +6.06 V  (min =  +6.06 V, max =  +6.06 V)       ALARM  (beep)
Batt Volt:+31.21 V  (min = +31.21 V, max = +31.21 V)       ALARM  (beep)
V5SB:      +6.85 V  (min =  +6.85 V, max =  +6.85 V)       ALARM  (beep)
VBat:      +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
fan1:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
fan2:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
fan3:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
temp1:        -1 C  (high =    -1 C, hyst =    -1 C)   sensor = diode
ALARM   (beep)
temp2:      +0.0 C  (high =    +0 C, hyst =    +0 C)   sensor = diode
ALARM   (beep)
temp3:      +0.0 C  (high =    +0 C, hyst =    +0 C)   sensor = diode
ALARM   (beep)
vid:      +0.000 V  (VRM Version 8.2)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled


Thanks very much in advance
Santiago
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060516/ab7b477f/attachment.html
