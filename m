From: Jeremy Jackson <jerj@coplanar.net>
Date: Tue, 12 Jun 2007 00:44:22 +0000
Subject: Re: [lm-sensors] dme1737 datasheet
Message-Id: <1181609062.6811.53.camel@ragnarok>
List-Id: <lm-sensors.vger.kernel.org>
References: <1176080449.13814.51.camel@ragnarok>
In-Reply-To: <1176080449.13814.51.camel@ragnarok>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

To clarify, are you saying the watchdog is the same, or more than that
(whole chip) ?

Regards,

Jeremy

On Mon, 2007-06-11 at 12:48 -0700, Juerg Haefliger wrote:
> Jeremy,
> 
> The DME1737 is compatible to the SCH311X ->
> http://www.nuhorizons.com/FeaturedProducts/Volume1/SMSC/311x.pdf
> 
> ...juerg
> 
> 
> On 4/8/07, Jeremy Jackson <jerj@coplanar.net> wrote:
> > Hi,
> >
> > Given the NDA nature it's tricky trying to support the watchdog and
> > serial port for LinuxBIOS.  I think I can fly blind using parts of
> > publicly available datasheets, but it would save me time if I knew the
> > Logical Device #'s of the various superio modules, ie index 7 values
> > needed to address parport, serial 1/2, fdc, etc. config registers.
> >
> > Any chance someone can hint at what these might be, or a publicly
> > available datasheet that's closest:
> >
> > http://www.smsc.com/main/datasheet.html
> >
> > Ok so they all have serial port as Logical Device 4, so I've summarized
> > what the watchdog uses below.
> >
> > ISA bus types - Config index/data registers at 0x3F0 or 0x370
> >
> > watchdog uses configuration space of logical device
> >
> > FDC37b727 Logical Device 8 - Aux I/O 0xF1 - 0xF4 watchdog *
> > FDC37b78x Logical Device 8 - Aux I/O 0xF1 - 0xF4 watchdog *
> > FDC37c665GT very different - no logical devices
> > FDC37c669 very different - no logical devices
> > FDC37c672 Logical Device 8 - Aux I/O 0xF1 - 0xF4 watchdog * no
> > WDT_TIME_OUT register
> > FDC37c78 FDC only
> > FDC37c93x Logical Device 8 - Aux I/O 0xF2 - 0xF4 watchdog *
> > FDC37M707 Logical Device 8 - Aux I/O 0xF1 - 0xF4 watchdog *
> > FDC37m817 Logical Device 8 - Aux I/O 0xF1 - 0xF4 watchdog *
> > FDC37n769 very different - no logical devices
> >
> > * can be configured to allow access to some watchdog registers while in
> > run mode
> >
> > LPC bus types - index/address registers 0x2e/0x2f or 0x4e/0x4f
> >
> > watchdog uses offset from decoded address set by logical device Primary
> > Base Address
> >
> > LPC47b272 Logical Device A - Runtime reg offset 0x52 - 0x55 watchdog
> > LPC47m10x no WDT
> > LPC47m112 no WDT
> > LPC47m172 no WDT
> > LPC47S45x Logical Device A - Runtime reg offset 0x52 - 0x55 watchdog
> >
> > I'm leaning towards DME1737 being the same as these LPC parts.
> >
> > --
> > Jeremy Jackson
> > jerj@coplanar.net Email/Jabber/Google Talk/MSN
> > (519)489-4903
> > Coplanar Networks
> > http://www.coplanar.net
> >
> >


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
