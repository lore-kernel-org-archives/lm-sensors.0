From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 04 Oct 2010 12:28:03 +0000
Subject: Re: [lm-sensors] W38795ADG sensors.conf for SuperMicro C7X58/X8SAX
Message-Id: <20101004142803.5b76104a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101002024101.GA6862@khazad-dum.debian.net>
In-Reply-To: <20101002024101.GA6862@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Mon, 4 Oct 2010 08:05:07 -0300, Henrique de Moraes Holschuh wrote:
> On Sun, 03 Oct 2010, Jean Delvare wrote:
> > On Fri, 1 Oct 2010 23:41:01 -0300, Henrique de Moraes Holschuh wrote:
> > > Please add this to the lm-sensors wiki, and any relevant userspace config
> > > files being shipped in lm-sensors userspace.
> > 
> > Thanks for your contribution.
> > 
> > http://www.lm-sensors.org/wiki/Configurations/SuperMicro/C7X58
> > http://www.lm-sensors.org/wiki/Configurations/SuperMicro/X8SAX
> > 
> > Just one question: what's the point of having a "w83627dhg-*" section
> > in the configuration file, given that you don't want to load the
> > w83627ehf driver in the first place, if it's useless on this board?
> 
> Because sensors-detect will find it...  also, there is something useful
> hooked to the w83627dhg, in GP31.  I wanted to document that.

I'd rather document the fact that the w83627ehf driver shouldn't be
loaded on this board. There's no point in slowing down the system boot
and libsensors by loading a useless driver. I've updated your
configuration file in the wiki accordingly.

Even better would be if sensors-detect would _not_ recommend loading
the w83627ehf driver on that board, of course. But for that, the board
manufacturer (or actually BIOS author) should disable the logical
device in question, which I presume SuperMicro didn't do.

> I didn't check whether the w83627ehf driver exports the gpio pins or not.

No, it doesn't, nor should it. The w83627ehf driver, despite its name,
focuses on the hardware monitoring part of the supported chips. Other
features, including GPIO, would belong to a separate driver.

> > > The BIOS does not set the correct limits for VTT, but it is wired.
> > 
> > Why don't you set the limits in the configuration file then?
> 
> I don't know what are the safe VTT limits for the processors supported on
> this board.  The board supports every LGA1366 processor (Core i7, Xeons
> 3500,3600,5500 and 5600 sequences, although the 3600/5600 and latest i7 are
> only supported on rev 2.0 of the board (which I don't have).

I have VTT monitored at 1.14 V on my Xeon E5520. On my Asus Z8NA-D5,
the limits are set by the BIOS to min = 0.770 V and max = 1.538 V. I
guess you could use the same limits on your board, this is very broad
but still better than no limits at all, and at least should be suitable
for all CPU models.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
