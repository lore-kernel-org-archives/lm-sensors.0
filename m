From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Nov 2012 21:55:23 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (it87) Add support for AMDTSI, and restrict  sensor type configur
Message-Id: <20121103225523.1ea8bcfd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351960184-23005-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351960184-23005-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 3 Nov 2012 14:46:54 -0700, Guenter Roeck wrote:
> On Sat, Nov 03, 2012 at 09:11:52PM +0100, Jean Delvare wrote:
> > I admit I don't quite get why ITE made these separate configuration
> > bits when all it brings is the possibility to select a non-working
> > combination...
> > 
> > I will also admit I'm kind of lost with the IT8728F. The datasheet
> > suggests that the PCH temperature can be retrieved but there is no
> > configuration bit to actually select it? Or if bit 6 of IT87_REG_VID
> > supposed to do exactly that? And if so, where does the reading go?
> > 
> Oh, there is. Bit 6 of IT87_REG_VID = 1, and bit 6 of register 0x98
> (IT87_REG_AMDTSI_HSR) = 0, and then there are a couple additional bits in
> register 0x9e (as I just noticed, meaning this patch is incomplete and I'll
> have to send you another version for AMDTSI support on IT8728F).
> Bit 4/5 of register 0xa are irrelevant for PCH on IT8728F.
> 
> Or at least that is how I think it works. I can not test it on my board, 
> so I did not even bother trying to add support for it. It gets tricky, since
> there are now, at least potentially, two separate "external" temperature
> sensors, so we would have to change the code structure for it. Maybe sometime
> later, if someone has a board supporting it and we can test if it actually
> works.

Ack.

> > BTW maybe we should come up with a different name for register 0x0A for
> > newer chips, otherwise the code gets a little confusing. IT87_REG_IFSEL
> > maybe?
>
> Ok with me. Since I have to create another version of the patch anyway,
> I'll merge that in, unless you want a separate patch for it.

No, merged is fine.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
