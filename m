From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 03 Jan 2012 16:49:32 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] drivers/hwmon/lm75.c: added error
Message-Id: <1325609372.3996.19.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325588561-31073-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325588561-31073-1-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-01-03 at 06:02 -0500, Frans Meulenbroeks wrote:
> added error handling so if lm75_update_device fails
> an error is returned when reading the value through sysfs
> This is closely modeled after the way this is handled in ltc4261
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> ---

Thanks, applied.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
