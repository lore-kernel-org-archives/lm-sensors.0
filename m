From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: System hanging using CSB5 chip with 2.8.1 - No longer
Message-Id: <3FCD5378.A6EE0E84@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
In-Reply-To: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> > I wrote the xeontemp driver as a one-temperature driver,
> > since it was confusing to people using the adm1021 driver that they
> > had to ignore the local temp and look at the remote temp.
> 
> Did you really write (I mean, cut and paste) a new driver just so that
> people wouldn't have to add an ignore statement in their config file?
> This is bad. A comment in both sensors.conf.eg and doc/chips/adm1021
> should be sufficent.
> 

I disagree (about the "bad" part - it was a cut and paste for sure).
adm1021 was at the limit for number of chips in SENSORS_INSMOD_x.
Making a new driver is a prerequisite for having better detection
in sensors-detect and recommending the correct driver,
without the user having to edit sensors.conf.
The new driver matches the xeon datasheet - exactly one sensor. Not two.

> > Khali, I'll update the docs myself using Philip's info,
> > to make recommendations.
> 
> Maybe you could mention that dual-Xeon systems will have a second
> adm1021-compatible chip at 0x29 or so?

ok
