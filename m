From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Nov 2009 15:43:33 +0000
Subject: Re: [lm-sensors] [PATCH v4] k10temp: temperature sensor for AMD
Message-Id: <20091127164333.75e20c8f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AF91F70.10106@ladisch.de>
	<4B06501B.8080509@ladisch.de>
	<87ws1l5wcl.fsf@depni.sinp.msu.ru>
	<4B0673D7.5010006@ladisch.de>
	<20091120123016.19d98ab4@hyperion.delvare>
	<4B068402.7020606@ladisch.de>
	<20091120131855.7f8f8722@hyperion.delvare>
	<4B0A3DB6.9090703@ladisch.de>
	<20091123145154.5b2b5735@hyperion.delvare>
	<4B0AAA55.3040702@ladisch.de>
	<20091123200527.1114cbc2@hyperion.delvare>
	<4B0B9CBB.2050107@ladisch.de>
In-Reply-To: <4B0B9CBB.2050107@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Serge Belyshev <belyshev@depni.sinp.msu.ru>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Clemens,

On Tue, 24 Nov 2009 09:43:39 +0100, Clemens Ladisch wrote:
> This adds a driver for the internal temperature sensor of AMD Family 10h
> and 11h CPUs.
> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> ---
> v3: added 'force' parameter for CPUs with buggy sensor; more documentation
> v4: added max/crit values, other changes suggested by Jean Delvare
> 
>  Documentation/hwmon/k10temp |   60 +++++++++
>  drivers/hwmon/Kconfig       |   12 +
>  drivers/hwmon/Makefile      |    1
>  drivers/hwmon/k10temp.c     |  197 ++++++++++++++++++++++++++++++++
>  4 files changed, 270 insertions(+)

Looks alright to me.

Acked-by: Jean Delvare <khali@linux-fr.org>

If this is OK with you, I can add this patch to my hwmon tree and
schedule it for merge in kernel 2.6.33.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
