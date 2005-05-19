From: DarKRaveR@verfeiert.org (DarKRaveR@verfeiert.org)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: Follow-UP to ticket 1578 as requested
Message-Id: <298642146.20040320175000@verfeiert.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
In-Reply-To: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

I guess the next thing I will try to work out, is to find out which
values are reported and which seem to be missing, concerning the
naming etc.
Saturday, March 20, 2004, 5:37:00 PM, you wrote:

>> I upgraded my kernel and  I just used newer packages of i2c and
>> lm_sensors from gentoo, which are not oficially released.
>> After that, the winbond gets used, the readings look okay in majority.

JD> Great :)

>> Just one fan is reporter at 0 rpm, and there's a couple fans as well
>> as one heat sensor missing and I got no clue, where to get the data.
>> :-)

JD> Maybe you need to increase the fan divisor (see doc/fan-divisors).

True that, I will check that, but after skipping a nights sleep, I
will keep that for soem other day ;-).

JD> As for the missing sensors, according to the output of sensors-detect
JD> from your first post, it's not something we support.  Maybe you can get
JD> the values from ACPI.

Sounds interesting, I will check on that too.

Thnx so far.

-- 
Best regards,
 DarKRaveR                            mailto:DarKRaveR@verfeiert.org
