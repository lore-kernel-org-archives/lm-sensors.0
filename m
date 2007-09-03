From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 03 Sep 2007 16:06:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add power meters to
Message-Id: <20070903180636.4096e7d5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com>
	<20070828015029.GA10107@khazad-dum.debian.net>
	<20070828131942.18449886@hyperion.delvare>
	<20070828164440.GL32667@tree.beaverton.ibm.com>
	<20070901171048.GA3883@ucw.cz>
	<41840b750709011105s6c434217t50d965a0b17df643@mail.gmail.com>
	<20070901194417.GA24897@khazad-dum.debian.net>
	<20070902213837.7293d6fa@hyperion.delvare>
	<20070903020200.GA8948@khazad-dum.debian.net>
In-Reply-To: <20070903020200.GA8948@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, lm-sensors@lm-sensors.org

On Sun, 2 Sep 2007 23:02:01 -0300, Henrique de Moraes Holschuh wrote:
> On Sun, 02 Sep 2007, Jean Delvare wrote:
> > I guess power[1-*]_average would be OK?
> 
> AFAIK, yes.  It is probably not 100% in sync with the power supply class,
> though.

Is the power supply class creating sysfs files? I see a number of
attributes listed in Documentation/power_supply_class.txt, but they are
all uppercase, which doesn't seem suitable for sysfs file names. That
document also doesn't list the numbering convention when multiple
channels are present.

My main worry is that we will have to add support for power measurement
in libsensors, and I would like it to be as easy as possible. Thus
sticking to the same naming convention hwmon have been using for years
appears to be the best solution.

I see that the power supply class units are 10^-6 A and 10^-6 W, so if
we are supposed to be compatible, I guess we'll have to use this too.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
