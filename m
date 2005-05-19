From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: TI TMP101 driver
Message-Id: <42176C14.7010403@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050218154856.GA14189@home.fluff.org>
In-Reply-To: <20050218154856.GA14189@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ben Dooks wrote:
> On Fri, Feb 18, 2005 at 06:49:27PM -0500, Mark Studebaker wrote:
> 
>>isn't this chip compatible with the LM75 and its driver?
>>what's different about it if anything?
> 
> 
> configuration register is different, the temperature
> comparison is also different (tmp101 has low/high range)
> 
> 

The configuration register is compatible, and in any case the LM75 driver doesn't
do anything with the register other than write it to 0 (which we should probably
remove anyway).

The TMP101 datasheet labels the low limit "low" but it is really a hysteresis,
as is clear from figure 4 (which is essentially identical to Figure 4 in the LM75 datasheet).
Recall that "comparator" mode is the standard for all our drivers.

Does the LM75 driver work for you? I don't see why it wouldn't...
please try it and let us know.

The one interesting difference is the TMP101 has extended precision.
That may be worth supporting, although whether that would be better
added  to the lm75 driver as an option or  creating a new driver is
an open question...

mds

