From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 Nov 2009 11:30:16 +0000
Subject: Re: [lm-sensors] [PATCH v2] k10temp: temperature sensor for AMD
Message-Id: <20091120123016.19d98ab4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AF91F70.10106@ladisch.de>
	<4B06501B.8080509@ladisch.de>
	<87ws1l5wcl.fsf@depni.sinp.msu.ru>
	<4B0673D7.5010006@ladisch.de>
In-Reply-To: <4B0673D7.5010006@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Serge Belyshev <belyshev@depni.sinp.msu.ru>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, 20 Nov 2009 11:47:51 +0100, Clemens Ladisch wrote:
> This adds a driver for the internal temperature sensor of AMD Family 10h
> and 11h CPUs.
> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> ---
> v2: Erratum 319 now results in a warning, not an error, because it cannot
>     be reliably detected; Serge Belyshev reports that his CPU sensor works.

Nack. Unreliable sensors -> the default must be to NOT bind to these
CPUs. Feel free to provide a way to force the bind to happen (and still
print a big fat warning that this is a very bad idea), but do NOT make
it the default. Otherwise your driver will _never_ make it into the
kernel tree.

As a side note I'd be curious to see what Serge calls "working
sensors". We had several reports in the past of people who claimed that
their sensors were working. After looking at their numbers, I had doubt
this really was the case.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
