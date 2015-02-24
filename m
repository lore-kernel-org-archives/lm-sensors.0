From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 24 Feb 2015 08:41:31 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (it87) Add support for IT8781F
Message-Id: <20150224094131.62ac0654@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423858433-1416-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1423858433-1416-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 13 Feb 2015 12:13:50 -0800, Guenter Roeck wrote:
> IT8781F is mostly compatible to IT8782F. Major difference is that it only
> supports four instead of six UART channels, and therefore does not share
> the uart6 pins.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/it87 | 22 +++++++++++++---------
>  drivers/hwmon/Kconfig    |  4 ++--
>  drivers/hwmon/it87.c     | 32 ++++++++++++++++++++++++--------
>  3 files changed, 39 insertions(+), 19 deletions(-)
> (...)

Looks good, please commit.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
