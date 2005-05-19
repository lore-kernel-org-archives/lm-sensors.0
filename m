From: Sean.Gilmour@analog.com (Gilmour, Sean)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: ADM1025 eval board
Message-Id: <F7CB408531C5264680C9E37DE4FE71A404948FBC@limkexm2.ad.analog.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1072174424.3fe815583d4bc@imp.gcu.info>
In-Reply-To: <1072174424.3fe815583d4bc@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I couldn't find any in local stores. Consumer electronics universal PSU
don't go above +12V. Fortunately, it happens that my ADSL modem/router
uses a 15V/1A PSU, which I can borrow for my tests. The only drawback is
that I have to choose between Internet access and the ADM1025 evaluation
board ;)

>A 12V PSU would be fine as long as it could supply at least 100mA.

I am sorry to say that you did not really answered my question ;) My
concerns here are technical. I know what a standard is, I understand
that parts can comply or not with it. What I am curious about are the
technical characteristics a temperature monitoring chip has to meet to
comply with the ACPI standards.

>As far as I know, when ACPI was first defined certain SMBus characteristics were defined see http://www.acpi.info for more info. This applied to older devices and is not used anymore.
Temperature and systems monitoring devices from Analog Devices no longer quote the ACPI spec. 

Now, I have been playing with the ADM1025 eval board and I have the bad
feeling that it doesn't work as it should. Temperatures are OK, +2.5V,
VCore, VCC and vid are correct, but +3.3V, +5V and +12V (when selected)
are not. Their values are changing randomly all the time. I tried on my
other computer with the Windows evaluation software, and that's the same
story, so it's not a matter of system or Linux driver. Any idea on
what's going on or how I can fix that?
>It is likely that the switches that engage these voltage measurements are not switched on. See the eval board schematic for more info.

Another strange behavior I noticed as I was trying to understand and
workaround the first problem, in case it helps: if I select +12V on the
board but VID4 inside the chip, all measurements go wrong, including
temperatures. I'd have expected +12V and/or vid to be wrong, of course,
but why is this breaking everything else too?
>If you do this, you are reconfiguring the internal circuitry of the ADM1025. Placing a 12V supply on this pin when configured for a VID input will likely sink more power and may damage the device.

Regards,
Se?n.

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 25 January 2004 22:23
To: Gilmour, Sean
Cc: sensors@stimpy.netroedge.com
Subject: Re: ADM1025 eval board

> >No. The LEDs probably light because the board is somehow sourcing
> >power from the printer port. A power supply is needed with this
> >board. A power supply will also be needed with the ADT7468 eval board
> >to drive the fans (the USB connector can source enough current for
> >the board but not for the fans). I would recommend a 500mA 12V-15V
> >PSU if you can get one.

I couldn't find any in local stores. Consumer electronics universal PSU
don't go above +12V. Fortunately, it happens that my ADSL modem/router
uses a 15V/1A PSU, which I can borrow for my tests. The only drawback is
that I have to choose between Internet access and the ADM1025 evaluation
board ;)

> > 3* What does it take to a chip to be "ACPI-compliant"? For example
> > the ADM1032 is tagged "ACPI-compliant". I wonder what it has that
> > other chips don't.
>
> Basically this refers to the parts ability to ensure that PCs/servers
> are ACPI compliant with respect to hardware monitoring and the SMBus
> interface.

I am sorry to say that you did not really answered my question ;) My
concerns here are technical. I know what a standard is, I understand
that parts can comply or not with it. What I am curious about are the
technical characteristics a temperature monitoring chip has to meet to
comply with the ACPI standards.

Now, I have been playing with the ADM1025 eval board and I have the bad
feeling that it doesn't work as it should. Temperatures are OK, +2.5V,
VCore, VCC and vid are correct, but +3.3V, +5V and +12V (when selected)
are not. Their values are changing randomly all the time. I tried on my
other computer with the Windows evaluation software, and that's the same
story, so it's not a matter of system or Linux driver. Any idea on
what's going on or how I can fix that?

Another strange behavior I noticed as I was trying to understand and
workaround the first problem, in case it helps: if I select +12V on the
board but VID4 inside the chip, all measurements go wrong, including
temperatures. I'd have expected +12V and/or vid to be wrong, of course,
but why is this breaking everything else too?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/


