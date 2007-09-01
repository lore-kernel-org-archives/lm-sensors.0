From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sat, 01 Sep 2007 19:44:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add power meters
Message-Id: <20070901194417.GA24897@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com> <20070828015029.GA10107@khazad-dum.debian.net> <20070828131942.18449886@hyperion.delvare> <20070828164440.GL32667@tree.beaverton.ibm.com> <20070901171048.GA3883@ucw.cz> <41840b750709011105s6c434217t50d965a0b17df643@mail.gmail.com>
In-Reply-To: <41840b750709011105s6c434217t50d965a0b17df643@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shem Multinymous <multinymous@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, "Darrick J. Wong" <djwong@us.ibm.com>

On Sat, 01 Sep 2007, Shem Multinymous wrote:
> > Should we add power?_10sec_avg_input? IIRC thinkpads export that,
> > too.

I'd say it is enough to know it is an average, you don't need to specify HOW
it is averaged.

But there is a real need to export both instantaneous and averaged values in
power supplies/power sources, so we should have a standard way to do so in
hwmon, and power_supply class should use it (or the opposite, it doesn't
matter, as long as everyone does it the same way).

> It would be nice if the power meter interface uses the same
> conventions as the power supply interface, since the former is
> essentially a subset of the latter. Userspace app that read power
> meters via sysfs should work for power supplies too.

Agreed.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
