From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Jul 2012 14:19:45 +0000
Subject: Re: [lm-sensors] [PATCH 2/2 v2] hwmon: (jc42) Don't reset hysteresis on device removal
Message-Id: <20120727141945.GB24718@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120726221843.38f3aaf2@endymion.delvare>
In-Reply-To: <20120726221843.38f3aaf2@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 26, 2012 at 10:18:43PM +0200, Jean Delvare wrote:
> Restoring the configuration register on device removal has the side
> effect of also resetting the hysteresis value. This is inconsistent as
> the other limits are not reset, only hysteresis. So, following the
> principle of least surprise, preserve the hysteresis value when
> restoring the configuration register.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <linux@roeck-us.net>


Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
