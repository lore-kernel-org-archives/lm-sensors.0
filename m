From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Jul 2007 14:56:55 +0000
Subject: Re: [lm-sensors] TEMP_HYST and TEMP_LOW difference for 2.4 kernel?
Message-Id: <20070708165655.211e76be@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <468fa7c736845@wp.pl>
In-Reply-To: <468fa7c736845@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Sat, 07 Jul 2007 16:48:39 +0200, Krzysztof Helt wrote:
> I want to add support for the THMC50 sensor to the lmsensors 
> 2.x. I found that original THMC50 does not work with 2.6 kernel 
> because it expects a value tempX_max_hyst instead of tempX_min.
> 
> I found that the 2.4 driver returns TEMP, TEMP_HYST and 
> TEMP_OVER. The 2.4 equivalent to the tempX_min is called 
> TEMP_LOW.
> 
> Is there any difference between TEMP_LOW and TEMP_HYST?

Yes, there is. They are two fundamentally different types of temperature
limits.

A low (or min) limit triggers an alarm when the measured temperature
drops below the limit. The alarm is cleared when the measured
temperature goes over the limit again.

A high (or max) limit triggers an alarm when the measured temperature
goes over the limit. Without an hysteresis, the alarm is cleared as
soon as the measured temperature drops below the limit again. However
this could be inconvenient when the measured temperature is very close
to the the limit: the alarm would be triggered and cleared over and
over again. So thermal chip sensor manufacturers introduced the concept
of hysteresis. Once the alarm has been raised, the measured temperature
has to drop below the hysteresis limit (rather than the high limit)
before the alarm is cleared. Typically the hysteresis limit value is a
few degrees below the high limit value.

For additional information on the concept of hysteresis, see this
article in Wikipedia:
http://en.wikipedia.org/wiki/Hysteresis#Electronics

Reading the THMC50 and ADM1022 datasheets, I think that these chips
actually implement both:

* Registers 0x2c, 0x38 and 0x3a correspond to "real" low limits.

* Additionally, the "hardware" limits from registers 0x13, 0x14, 0x17
and 0x18, which control the THERM output, seem to have an hysteresis at
5 degrees below each limit. At least this is what the "THERM operation"
diagram suggests. But your driver doesn't support these "hardware"
limits at the moment, so you don't really care.

> May I change the 2.4 THMC50 driver (which should be cleaned and 
> extended for the adm1021 anyway) to report TEMP_LOW instead of 
> TEMP_HYST? 

No, changing the symbol names could break the compatibility with
third-party sensors applications. The symbol names do not matter that
much anyway, even though I admit that bad names add to confusion. In
libsensors, you can override file names for the 2.6 driver as needed,
using extra fields in the structure definition. Look at gl518_features
in lib/chips.c for an example of this: "vdd" in the 2.4 driver became
"in0_input" in the 2.6 driver. You can do the same for your thmc50
driver, so the 2.6 driver will work without changing the 2.4 driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
