From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Sep 2007 19:38:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add power meters to
Message-Id: <20070902213837.7293d6fa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com>
	<20070828015029.GA10107@khazad-dum.debian.net>
	<20070828131942.18449886@hyperion.delvare>
	<20070828164440.GL32667@tree.beaverton.ibm.com>
	<20070901171048.GA3883@ucw.cz>
	<41840b750709011105s6c434217t50d965a0b17df643@mail.gmail.com>
	<20070901194417.GA24897@khazad-dum.debian.net>
In-Reply-To: <20070901194417.GA24897@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, lm-sensors@lm-sensors.org

On Sat, 1 Sep 2007 16:44:17 -0300, Henrique de Moraes Holschuh wrote:
> On Sat, 01 Sep 2007, Shem Multinymous wrote:
> > > Should we add power?_10sec_avg_input? IIRC thinkpads export that,
> > > too.
> 
> I'd say it is enough to know it is an average, you don't need to specify HOW
> it is averaged.

Agreed.

> But there is a real need to export both instantaneous and averaged values in
> power supplies/power sources, so we should have a standard way to do so in
> hwmon, and power_supply class should use it (or the opposite, it doesn't
> matter, as long as everyone does it the same way).

I guess power[1-*]_average would be OK?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
