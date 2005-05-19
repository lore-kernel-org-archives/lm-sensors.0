From: stic6021@yahoo.com (Steve Tice)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Follow-up, ticket #1375
Message-Id: <20030815141119.66538.qmail@web11203.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030814211421.52539.qmail@web11206.mail.yahoo.com>
In-Reply-To: <20030814211421.52539.qmail@web11206.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you for the reply and for the patch. I will add to my
to-do list a carefully controlled trial run of the patched
i2c-piix4.o.

Kudos on the level of support provided. I am most impressed.

Regards,
Steve

--- Jean Delvare <khali@linux-fr.org> wrote:
> 
> > I may have stumbled across the root cause of my ticket #1375
> > (Tyan S2727, no chips detected). The main chipset is the
> > ServerWorks GC-SL with a CSB6 controlling the PCI bus. I
> just
> > noticed the CSB6 is on the "NEW AND REQUESTED BUS DRIVERS"
> list.
> 
> Yes, there is no support yet. We think support could be easily
> added to
> our i2c-piix4 driver, but we would need a datasheet to confirm
> that. I
> just made a request to serverworks to have one, we'll see.
> 
> > 00:0f.0 ISA bridge: ServerWorks: Unknown device 0203 (rev
> a0)
> >         Subsystem: ServerWorks: Unknown device 0201
> >         Flags: bus master, medium devsel, latency 64
> 
> That should be where the I2C/SMBus bus is.
> 
> If you like playing with fire, I've attached a simple patch
> that make
> i2c-piix4 accept the CSB6. It could work, since the CSB6 is
> expected to
> be mostly compatible with the CSB5. However, beware that we
> don't have a
> datasheet yet, so the CSB6 may work in a completely different
> manner,
> loading the i2c-piix4 on it may completely screw your system.
> It's
> unlikely, but could happen. I of course take no responsability
> for that.
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/



__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
