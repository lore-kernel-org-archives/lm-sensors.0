From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Jul 2012 13:37:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Don't reset hysteresis on device removal
Message-Id: <20120726133750.GA14371@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120726145745.0bc82f8d@endymion.delvare>
In-Reply-To: <20120726145745.0bc82f8d@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 26, 2012 at 02:57:45PM +0200, Jean Delvare wrote:
> Restoring the configuration register on device removal has the side
> effect of also resetting the hysteresis value. This is inconsistent as
> the other limits are not reset, only hysteresis. So, following the
> principle of least surprise, preserve the hysteresis value when
> restoring the configuration register.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <linux@roeck-us.net>

Good catch. Applied.

> ---
> Note: this would be more readable if JC42_CFG_HYST_MASK was the mask
> _before_ shifting instead of after shifting. Guenter, do you want me
> to send a separate patch doing that, or do you like it the way it is?
> 
Please send a patch.

> Alternatively we could invert the logic and only restore the
> JC42_CFG_SHUTDOWN bit. As this bit and the two hysteresis bits are the
> only ones the driver touches, this is equivalent. I don't know if
> there is an intent to ever have the jc42 driver touch any other bit in
> the configuration register. Guenter, I am leaving the decision up to
> you.
> 
Hard to say, though looking into it seems unlikely. But who knows. I would
suggest to keep it generic as you implemented.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
