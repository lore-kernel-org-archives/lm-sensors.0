From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 02 Mar 2012 16:31:19 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (f75375s) Properly map the F75387 automatic modes to pwm_enab
Message-Id: <1330705879.23014.276.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330463755-5763-4-git-send-email-mail@microschulz.de>
In-Reply-To: <1330463755-5763-4-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-02-28 at 16:15 -0500, Nikolaus Schulz wrote:
> From: Nikolaus Schulz <schulz@macnetix.de>
> 
> The F75387 supports automatic fan control using either PWM duty cycle or
> RPM speed values.  Make the driver detect the latter mode, and expose the
> different modes in sysfs as per pwm_enable, so that the user can switch
> between them.
> 
> The interpretation of the pwm_enable attribute for the F75387 is adjusted
> to be a superset of those values used for similar Fintek chips which do
> not support automatic duty mode, with 2 mapping to automatic speed mode,
> and moving automatic duty mode to the new value 4.
> 
> Toggling the duty mode via pwm_enable is currently denied for the F75387,
> as the chip then simply reinterprets the fan configuration register values
> according to the new mode, switching between RPM and PWM units, which
> makes this a dangerous operation.
> 
> Signed-off-by: Nikolaus Schulz <mail@microschulz.de>

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
