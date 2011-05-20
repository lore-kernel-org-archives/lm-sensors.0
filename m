From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 20 May 2011 14:00:45 +0000
Subject: Re: [lm-sensors] [PATCHv3 6/11] HWMON: Fixed point conversion gives
Message-Id: <20110520140045.GC23076@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E2CAE7F7B064EA49B5CE7EE9A4BB167D151BDC3D33@KCINPUNHJCMS01.kpit.com>
In-Reply-To: <E2CAE7F7B064EA49B5CE7EE9A4BB167D151BDC3D33@KCINPUNHJCMS01.kpit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ashish Jangam <Ashish.Jangam@kpitcummins.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Dajun Chen <Dajun.Chen@diasemi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, May 20, 2011 at 06:57:18AM -0400, Ashish Jangam wrote:
> Hi,
> 
> As requested approximation of battery temperature calculation with fixed point conversion is tried but it causes couple of link time errors, like undefined reference to __aeabi_i2d at sprintf(). Have a look at the function da9052_read_tbat(); we feel that this function should not be supported else there will be a prerequisite to the support the required floating point library. Enabling FPE_NWFPE support in the kernel gives the same link time errors.
> 
You have defined

#define LOGN2          0.693147181

and use it, which makes the entire calculation a floating point calculation
and defeats the purpose. The idea would have been to define something like 

#define CAL_LOG2(nr)	((int)((ilog2(nr) - ilog2(100)) * 693147181LL / 1000000000LL))

Also, there is no need for rounding, say, 0.003355705 to 0.0034, or 2.5 to 3.
Add a few digits, like above, and remove them afterwards.

	x * 2.5 = x * 5 / 2.
	x * 33.55705 = x * 3355705 / 100000

Just be careful that you don't get overflows.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
