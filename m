From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Wed, 15 Sep 2010 16:07:40 +0000
Subject: Re: [lm-sensors] [patch 00/36] New w83795 driver
Message-Id: <20100915160740.GF20558@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100915154005.448afabb@hyperion.delvare>
In-Reply-To: <20100915154005.448afabb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 15 Sep 2010, Jean Delvare wrote:
> On Wed, 15 Sep 2010 12:52:06 -0300, Henrique de Moraes Holschuh wrote:
> > On Wed, 15 Sep 2010, Jean Delvare wrote:
> > > This is a new driver for the Winbond/Nuvoton W83795G/ADG hardware
> > > monitoring chips. The original code was contributed by Wei Song, a
> > > former employee of Nuvoton. I've fixed and improved a lot of things
> > > on top of his work.
> > 
> > You've gotten yourself a tester: I have one of those in my main desktop
> > (SuperMicro C7X58 v1.1).  I just have to backport the driver to 2.6.32.y
> > to test it there.
> 
> You don't even have to, as I did it for you already:
> http://khali.linux-fr.org/devel/misc/w83795/

Thanks.  Will use.

> If you find any problem with the driver, please let me know!

I will even try to send patches :-)

> (Note: monitoring should work OK now, but I didn't have the time to
> work on fan speed control yet, so I expect bugs in this area.)

I can try to compare the montoring results with the userspace driver
included in SuperODoctor II.  The first version of the driver (before
your patches) had inconsistentices.

I will have to read the chip's datasheet to check if my hardware setup
will let me help test PWM control.

The C7X58/S8SAX BIOS is supposed to put the chip in some sort of
closed-loop fan control mode if you tell it to, but there are issues
when mixing 3-pin and 4-pin fans in the same system (or at least
SuperMicro cautions agains such a setup.  It might be just a lazy BIOS,
or it might be a chip restriction)... and I have a mix of 3-pin and
4-pin fans.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
