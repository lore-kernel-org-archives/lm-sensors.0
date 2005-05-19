From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH 2.6] I2C: New chip driver: sis5595
Message-Id: <QQhCmClW.1107269004.3606060.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <w2Am1HDp.1107265957.3006340.khali@localhost>
References: <20050125220945.GA23560@bode.aurel32.net>
In-Reply-To: <20050125220945.GA23560@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adobriyan@mail.ru
Cc: Aurelien Jarno <aurelien@aurel32.net>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>


Quoting myself:

> To me, the only acceptable simplification is
> the initialization of "last_updated" to something which ensures that
> the first update attempt will succeed - providing we actually can do
> that.

On second thought, we obviously cannot, because jiffies wrap, so there is
no single initial value of "last_updated", either relative or
absolute, which can ensure this condition to be true. I think we are
stuck we this "valid" flag, or at least with the concept thereof.
Possibly we can use "last_updated" itself as a flag if we absolutely
want to get rid of "valid". "last_updated = 0" would mean the same
as "valid = 0" did. The probability of "last_updated" to become 0
again after init time is obviously thin, and it wouldn't really hurt if
it did (it would simply allow an extra update to happen). That said,
this makes the code somewhat trickier.

What could (and should) be done anyway is to use time_after() or
something equivalent for the jiffies checks, instead of direct
coparison, in all hardware monitoring drivers.

Thanks,
--
Jean Delvare
