From: vdovikin@jscc.ru (Oleg I. Vdovikin)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <005501c35290$d3e4c7a0$6628d0c3@mlab.cs.msu.su>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307242129.59862.kelledin@users.sourceforge.net>
In-Reply-To: <200307242129.59862.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Also, the i2c-tsunami driver itself looks...well...unmaintained.
> > Does anyone maintain it now?
>
> Seems so, yes. Oleg?
    Probably. ;-))

> > If it's been abandoned, I can
> > happily take over maintenance, assuming someone can loan or
> > donate enough to build a sufficiently-working Typhoon/Tsunami
> > motherboard setup.
>
> We don't have such hardware, or we probably would maintain the driver by
> ourselves.
    Yes, I will do the testing if you make necessary changes to work it with
the new "PCI" style code. I've no idea for now... But remember tsunami it's
not a PCI device, it's something like an ISA memory mapped device.

Regards,
    Oleg.
