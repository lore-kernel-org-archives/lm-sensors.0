From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Jan 2012 17:09:47 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm63) Expose automatic fan speed control lookup table
Message-Id: <20120114180947.3add5f8f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120114100704.5e22934d@endymion.delvare>
In-Reply-To: <20120114100704.5e22934d@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 14 Jan 2012 08:39:17 -0800, Guenter Roeck wrote:
> On Sat, Jan 14, 2012 at 04:07:04AM -0500, Jean Delvare wrote:
> > The LM63 and compatible devices have a lookup table to control the fan
> > speed automatically. Expose it in sysfs. We might make it writable in
> > the future.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Possibly document that the lookup table is (only) updated every 5 secons.

Done, thanks for the suggestion.

> Otherwise
> 
> Tested-and-Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> for both LM63 and LM96163.

Thanks. BTW I've seen that the driver doesn't allow changing the value
of pwm1_enable... I'll add support for that next (tomorrow.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
