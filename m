From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 11 Mar 2011 20:33:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver for SMSC SCH5627 hwmon
Message-Id: <1299875596.20292.24.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299871683-3945-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1299871683-3945-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 2011-03-11 at 14:28 -0500, Hans de Goede wrote:
> SMSC SCH5627 Super I/O chips include complete hardware monitoring
> capabilities. They can monitor up to 5 voltages, 4 fans and 8 temperature
> sensors.
> 
> The hardware monitoring part of the SMSC SCH5627 is accessed by talking
> through an embedded microcontroller. An application note describing the
> protocol for communicating with the microcontroller is available upon
> request. Please mail me if you want a copy.
> 
> Changes since version 1:
> * Properly format multi line comments
> * Avoid a potential divide by 8
> * Use pr_err / pr_warn / pr_err instead of printk
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

checkpatch.pl gives me the following warning:

WARNING: msleep < 20ms can sleep for up to 20ms; see
Documentation/timers/timers-howto.txt
+			msleep(1);
total: 0 errors, 1 warnings, 894 lines checked

The documentation suggests to use usleep_range() instead. Would that
make sense, or do you want to keep the msleep() ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
