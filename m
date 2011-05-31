From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 31 May 2011 20:29:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Relax target temperature
Message-Id: <1306873759.2163.635.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110531215051.663df5ef@endymion.delvare>
In-Reply-To: <20110531215051.663df5ef@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-05-31 at 15:50 -0400, Jean Delvare wrote:
> The current temperature range check of MSR_IA32_TEMPERATURE_TARGET
> seems too strict to me, some TjMax values documented in
> Documentation/hwmon/coretemp wouldn't pass. Relax the check so that
> all the documented values pass.
> 
Maybe the reason is that the processors which support reading TjMax via
the register are all in the 80 .. 120 range. Who knows - unfortunately,
a simple table describing which processor supports which set of
registers does not seem to exist, or at least I was unable to find it.

> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Carsten Emde <C.Emde@osadl.org>
> Cc: Fenghua Yu <fenghua.yu@intel.com>

> ---
> I'm not even sure why we need to check the range. Why would the
> value read from the MSR be wrong?

If I understand correctly, some processors support the register but not
the TjMax value in bits 16..23. Here is an exchange about it:

http://www.tomshardware.com/forum/230079-29-intel-tjunction-mean

Patch applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
