From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Jan 2012 21:53:41 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (lm63) Add support for update_interval sysfs attribute
Message-Id: <20120112225341.1bff347b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326223430-3297-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326223430-3297-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 Jan 2012 17:47:32 -0800, Guenter Roeck wrote:
> The update interval is configurable on LM63 and compatibles. Add support for it.

Oh, BTW, Documentation/hwmon/lm63 still says:

  The lm63 driver will not update its values more frequently than every
  second; reading them more often will do no harm, but will return 'old'
  values.

This is no longer correct. Care to provide a documentation update? I'll
merge it in this patch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
