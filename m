From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 05 Nov 2011 21:58:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix for non-SMP builds
Message-Id: <20111105215812.GA18231@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111105185411.0fb888e3@endymion.delvare>
In-Reply-To: <20111105185411.0fb888e3@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 05, 2011 at 01:54:11PM -0400, Jean Delvare wrote:
> The definition of TO_ATTR_NO in the non-SMP case is wrong. As the SMP
> definition resolves to the correct value, just use this for both
> cases.
> 
> Without this fix the temperature attributes are named temp0_* instead
> of temp2_*, so libsensors won't pick them. Broken since kernel 3.0.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Tested-by: Phil Sutter <phil@nwl.cc>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Jean, I assume you take that one ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
