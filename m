From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <kSYJUUFK.1115728531.1460500.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Just reviewed /etc/sensors.conf again, negative voltage calculation
> is totally bogus as it does not account for reference voltage driving
> top of resistor divider.  The proof is that you do not have correct
> Winbond resistor values in the sample calculations.  They're fudged.

This is no proof. Winbond datasheet are not always accurate (*cough*),
and motherboards have a long history of not following the
recommendations anyway.

That being said, I have found similar errors in the past (mostly broken
rounding in the drivers) so I wouldn't be surprised if there are more.

> Parameter based calculation does not have these issues, doesn't
> need floating point either.

Just because the resistors value are integers doesn't mean you don't
need floating point. Future resistors may not have integer values, and
also libsensors currently provides the chip voltage values in Volts, as
floats.

> Numbers traceable to datasheet is easy way.

And mostly useless, unfortunately, for the reasons given above. Most
datasheets are hints at best.

--
Jean Delvare
