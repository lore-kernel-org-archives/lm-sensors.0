From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Oct 2007 17:25:08 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm78 and w83781d: Probe fewer I2C
Message-Id: <20071030182508.5796d4fe@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071007122546.3f8b4d18@hyperion.delvare>
In-Reply-To: <20071007122546.3f8b4d18@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sun, 28 Oct 2007 14:10:30 -0400, Mark M. Hoffman wrote:
> * Jean Delvare <khali@linux-fr.org> [2007-10-07 12:25:46 +0200]:
> > We've never seen any device supported by the lm78 or w83781d driver
> > at addresses 0x20-0x27, so let's stop probing these addresses. Extra
> > probes cost time, and have potential for confusing or misdetecting
> > other I2C devices.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > ---
> >  Documentation/hwmon/lm78    |    4 ++--
> >  Documentation/hwmon/w83781d |    6 +++---
> >  drivers/hwmon/lm78.c        |    6 ++----
> >  drivers/hwmon/w83781d.c     |    7 +++----
> >  4 files changed, 10 insertions(+), 13 deletions(-)
> 
> This patch has high "regression potential".  I'll take it, but not for 2.6.24.

Of course, I never meant to get this in 2.6.24 that late in the game.

> Also: please modify sensors-detect so that it includes the (now necessary)
> options to get the driver loaded, in case the above hardware is found at one of
> these addresses.

I don't think this makes sense. This would mean adding specific code to
sensors-detect to handle this case, while the reason why I sent the
patch in the first place is that I am fairly certain that the extra
addresses are never used in practice and I wanted to simplify things.

So I'd rather leave sensors-detect as it is now. If I am wrong, it will
detect one of the affected chips at an address no longer supported by
the driver, and the user will (hopefully) complain, so that we are
aware of the regression.

Alternatively, I could reduce the probe lists in sensors-detect the same
way I did in the drivers. This would bring back some consistency, and
save 8 probes (addresses 0x20 to 0x27 are probed only for these
devices). This might even solve some problems people have reported with
sensors-detect, as there are non-sensors chip living at these addresses
(I/O expanders and video chips) which may not like being probed.

For what it's worth, since I joined the lm-sensors mailing list in July
2002, we did not have a single report of any hardware monitoring chip
in this address range. So the second option has my favors.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
