From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 09 Apr 2015 11:55:50 +0000
Subject: Re: [lm-sensors] [PATCH v2 03/22] hwmon: (it87) Add AVCC3 support for IT8620E
Message-Id: <20150409135550.3032823e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1428184513-22380-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1428184513-22380-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat,  4 Apr 2015 14:54:54 -0700, Guenter Roeck wrote:
> AVCC3 is supported on IT8620E, similar to IT8603E. Add feature flag
> to indicate AVCC3 support, and enable support for it on IT8620E.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Use feature macro on sio_data
> 
>  drivers/hwmon/it87.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> (...)

Looks good.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Makes me wonder, did you check if PWM outputs support full-speed mode
on the IT8620E? That's the only it8603-specific piece of code left in
the driver, and apparently the IT8620E and IT8603E have a few things in
common.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
