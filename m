From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Mon, 03 Sep 2007 23:22:25 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add power meters
Message-Id: <20070903232225.GD3899@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com> <20070828015029.GA10107@khazad-dum.debian.net> <20070828131942.18449886@hyperion.delvare> <20070828164440.GL32667@tree.beaverton.ibm.com> <20070901171048.GA3883@ucw.cz> <41840b750709011105s6c434217t50d965a0b17df643@mail.gmail.com> <20070901194417.GA24897@khazad-dum.debian.net> <20070902213837.7293d6fa@hyperion.delvare> <20070903020200.GA8948@khazad-dum.debian.net> <20070903180636.4096e7d5@hyperion.delvare>
In-Reply-To: <20070903180636.4096e7d5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Darrick J. Wong" <djwong@us.ibm.com>

On Mon, 03 Sep 2007, Jean Delvare wrote:
> On Sun, 2 Sep 2007 23:02:01 -0300, Henrique de Moraes Holschuh wrote:
> > On Sun, 02 Sep 2007, Jean Delvare wrote:
> > > I guess power[1-*]_average would be OK?
> > 
> > AFAIK, yes.  It is probably not 100% in sync with the power supply class,
> > though.
> 
> Is the power supply class creating sysfs files? I see a number of
> attributes listed in Documentation/power_supply_class.txt, but they are
> all uppercase, which doesn't seem suitable for sysfs file names. That
> document also doesn't list the numbering convention when multiple
> channels are present.

Looks like power supply needs some tweaks, then.

> My main worry is that we will have to add support for power measurement
> in libsensors, and I would like it to be as easy as possible. Thus
> sticking to the same naming convention hwmon have been using for years
> appears to be the best solution.

Agreed.

> I see that the power supply class units are 10^-6 A and 10^-6 W, so if
> we are supposed to be compatible, I guess we'll have to use this too.

There was a good reason for that, and people who deal with small portables
said that they needed 10^-4 A or somesuch, at which point it makes more
sense to just go to 10^-6 already.  I don't recall why 10^-6 W, though.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
