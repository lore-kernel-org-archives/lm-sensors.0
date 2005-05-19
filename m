From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: Follow-UP to ticket 1578 as requested
Message-Id: <20040320173700.424e9b94.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
In-Reply-To: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I upgraded my kernel and  I just used newer packages of i2c and
> lm_sensors from gentoo, which are not oficially released.
> After that, the winbond gets used, the readings look okay in majority.

Great :)

> Just one fan is reporter at 0 rpm, and there's a couple fans as well
> as one heat sensor missing and I got no clue, where to get the data.
> :-)

Maybe you need to increase the fan divisor (see doc/fan-divisors).

As for the missing sensors, according to the output of sensors-detect
from your first post, it's not something we support.  Maybe you can get
the values from ACPI.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
