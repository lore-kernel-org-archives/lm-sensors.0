From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 May 2009 15:57:28 +0000
Subject: Re: [lm-sensors] PATCH [1/4]: hwmon: f71882fg cleanup f8000 pwm
Message-Id: <20090529175728.4f4eed3c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A1FA574.5050405@redhat.com>
In-Reply-To: <4A1FA574.5050405@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 May 2009 11:05:56 +0200, Hans de Goede wrote:
> Currently we are using separate per model sysfs attr for the 3th pwm, because
> the 3th pwm of the f8000 only has automatic mode and not manual mode. Doing
> things this way was getting in the way for adding f71858fg support, so this
> patch makes the pwm attr identical for all models, and instead adds a check
> to store_pwm_enable() disallowing setting the 3th pwm to manual mode
> on a f8000 IC.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks good, applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
