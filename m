From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Mon, 03 Sep 2007 02:02:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add power meters
Message-Id: <20070903020200.GA8948@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com> <20070828015029.GA10107@khazad-dum.debian.net> <20070828131942.18449886@hyperion.delvare> <20070828164440.GL32667@tree.beaverton.ibm.com> <20070901171048.GA3883@ucw.cz> <41840b750709011105s6c434217t50d965a0b17df643@mail.gmail.com> <20070901194417.GA24897@khazad-dum.debian.net> <20070902213837.7293d6fa@hyperion.delvare>
In-Reply-To: <20070902213837.7293d6fa@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, lm-sensors@lm-sensors.org

On Sun, 02 Sep 2007, Jean Delvare wrote:
> On Sat, 1 Sep 2007 16:44:17 -0300, Henrique de Moraes Holschuh wrote:
> > On Sat, 01 Sep 2007, Shem Multinymous wrote:
> > > > Should we add power?_10sec_avg_input? IIRC thinkpads export that,
> > > > too.
> > 
> > I'd say it is enough to know it is an average, you don't need to specify HOW
> > it is averaged.
> 
> Agreed.
> 
> > But there is a real need to export both instantaneous and averaged values in
> > power supplies/power sources, so we should have a standard way to do so in
> > hwmon, and power_supply class should use it (or the opposite, it doesn't
> > matter, as long as everyone does it the same way).
> 
> I guess power[1-*]_average would be OK?

AFAIK, yes.  It is probably not 100% in sync with the power supply class,
though.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
