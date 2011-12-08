From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Dec 2011 18:36:26 +0000
Subject: Re: [lm-sensors] (no subject)
Message-Id: <1323369386.2415.53.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4299B850.6000901@tassie.net.au>
In-Reply-To: <4299B850.6000901@tassie.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-12-08 at 13:31 -0500, Guenter Roeck wrote:
> Fix checkpatch errors and warnings, rename attributes to use standardized names,
> fix rpm mode value range, and initialize pwm_mode and pwm_enable if there is not
> platform data.
> 
> If we agree on this set of patches, the pending patches to add support for
> F75383 should probably be applied on top of it.
> 
Oops .. I'll resend the series with proper subject.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
