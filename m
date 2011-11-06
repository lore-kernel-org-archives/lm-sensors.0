From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Nov 2011 09:30:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix for non-SMP builds
Message-Id: <20111106103024.31cd2892@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111105185411.0fb888e3@endymion.delvare>
In-Reply-To: <20111105185411.0fb888e3@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 5 Nov 2011 14:58:12 -0700, Guenter Roeck wrote:
> On Sat, Nov 05, 2011 at 01:54:11PM -0400, Jean Delvare wrote:
> > The definition of TO_ATTR_NO in the non-SMP case is wrong. As the SMP
> > definition resolves to the correct value, just use this for both
> > cases.
> > 
> > Without this fix the temperature attributes are named temp0_* instead
> > of temp2_*, so libsensors won't pick them. Broken since kernel 3.0.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Tested-by: Phil Sutter <phil@nwl.cc>
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Thanks.

> Jean, I assume you take that one ?

Yes I will.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
