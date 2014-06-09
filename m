From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Jun 2014 14:45:32 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ina2xx) Cast to s16 on shunt and current regs
Message-Id: <5395C88C.5070408@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402261584-5301-1-git-send-email-fabio.baltieri@gmail.com>
In-Reply-To: <1402261584-5301-1-git-send-email-fabio.baltieri@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Baltieri <fabio.baltieri@gmail.com>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 06/08/2014 02:06 PM, Fabio Baltieri wrote:
> All devices supported by ina2xx are bidirectional and reports the
> measured shunt voltage and power values as a signed 16 bit, but the
> current driver implementation caches all registers as u16, leading to an
> incorrect sign extension when reporting to the userspace in
> ina2xx_get_value().
>
> This patch fixes the problem by casting the signed registers to s16.
> Tested on an INA219.
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>

Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
