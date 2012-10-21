From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Oct 2012 16:57:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Manage device specific features with table
Message-Id: <20121021185726.080d640c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1350837712-31556-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1350837712-31556-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 21 Oct 2012 09:41:52 -0700, Guenter Roeck wrote:
> This simplifies the code, improves runtime performance, reduces
> code size (about 300 bytes on x86_64), and makes it easier
> to add support for new devices.

No time for a full review right now, just one thing:

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> This patch applies on top of the previously submitted patch series for it87.
> 
>  drivers/hwmon/it87.c |  217 ++++++++++++++++++++++++++------------------------
>  1 file changed, 111 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index e7b604c..560f9a9 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> (...)
> +	[it8726] = {
> +		.name = "it8726",
> +		.id = IT8726F_DEVID,
> +		.features = FEAT_16BIT_FAN,
> +	},

The name change is breaking user-space compatibility. With lm-sensors
2.10.x an IT8726F chip will suddenly become unrecognized. With
lm-sensors 3.x this isn't so bad but the name change may still break
chip matching in board-specific configuration files, sensord rrd
databases, custom scripts etc. So please don't do that.

This is exactly the reason why the IT8705F is still named "it87"
instead of the more consistent "it8705".

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
