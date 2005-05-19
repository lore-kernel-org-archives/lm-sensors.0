From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Raw sensor readings
Message-Id: <ZDTs9pfy.1113292205.2649120.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY101-F36EBF0A9799BF1039FC5FEA43E0@phx.gbl>
In-Reply-To: <BAY101-F36EBF0A9799BF1039FC5FEA43E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi John,

> Instead of trying to code everything myself using lm_sensors (which I was
> informed wasn't possible, thank you), I decided to use FreeBSD and the
> code from the previous semester's project. Now I can simply call a method
> brand() and retrieve a supposedly random number based on the sensors. My
> job for this semester is to test it for randomness and perhaps make a
> webpage for it. Chi-squared analysis yields that 5/10 groups of readings
> are random. Not bad for a start.

I don't know if this is of any interest to you, but some computers have
hardware random number generators, and Linux (and I suspect BSD) has
drivers to handle a couple of these. Andrew E. Schulman set up a nice
(although slightly outdated) page about these:
  http://home.comcast.net/~andrex/hardware-RNG/
But it might not be of any help for your specific project. Up to you.

> lm_sensors is quite extensive and easy to use, kudos to that.

Thanks :')

--
Jean Delvare
