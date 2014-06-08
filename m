From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 08 Jun 2014 20:16:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ina2xx) Change register cache to signed
Message-Id: <20140608201600.GA30953@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402174021-25857-1-git-send-email-fabio.baltieri@gmail.com>
In-Reply-To: <1402174021-25857-1-git-send-email-fabio.baltieri@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, Lothar Felten <l-felten@ti.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Sat, Jun 07, 2014 at 09:47:01PM +0100, Fabio Baltieri wrote:
> All devices supported by the ina2xx driver are bidirectional and reports
> the measured value as a signed 16 bit, but the current driver
> implementation caches the number as an u16, leading to an incorrect sign
> extension when reporting to the userspace in ina2xx_get_value().
> 
> This patch fixes the problem by using a s16 instead, and has been tested
> on an INA219.
> 
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
