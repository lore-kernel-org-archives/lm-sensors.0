From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Mon, 04 Oct 2010 11:05:07 +0000
Subject: Re: [lm-sensors] W38795ADG sensors.conf for SuperMicro C7X58/X8SAX
Message-Id: <20101004110506.GA27627@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101002024101.GA6862@khazad-dum.debian.net>
In-Reply-To: <20101002024101.GA6862@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 03 Oct 2010, Jean Delvare wrote:
> On Fri, 1 Oct 2010 23:41:01 -0300, Henrique de Moraes Holschuh wrote:
> > Please add this to the lm-sensors wiki, and any relevant userspace config
> > files being shipped in lm-sensors userspace.
> 
> Thanks for your contribution.
> 
> http://www.lm-sensors.org/wiki/Configurations/SuperMicro/C7X58
> http://www.lm-sensors.org/wiki/Configurations/SuperMicro/X8SAX
> 
> Just one question: what's the point of having a "w83627dhg-*" section
> in the configuration file, given that you don't want to load the
> w83627ehf driver in the first place, if it's useless on this board?

Because sensors-detect will find it...  also, there is something useful
hooked to the w83627dhg, in GP31.  I wanted to document that.  I didn't
check whether the w83627ehf driver exports the gpio pins or not.

> > The BIOS does not set the correct limits for VTT, but it is wired.
> 
> Why don't you set the limits in the configuration file then?

I don't know what are the safe VTT limits for the processors supported on
this board.  The board supports every LGA1366 processor (Core i7, Xeons
3500,3600,5500 and 5600 sequences, although the 3600/5600 and latest i7 are
only supported on rev 2.0 of the board (which I don't have).

> > I still haven't found how the PWM outputs are wired in this board, though,
> > due to my mix of PWM and non-PWM fans I cannot enable fan control.
> 
> Note that I did not review that part of the driver yet, and I know
> there are a few oddities there. The BIOS-defined automatic control
> works OK on my board, but if you attempt to tweak it using the driver,
> I can't guarantee it will work OK.

I am leaving it untouched for now, as well.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
