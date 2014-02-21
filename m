From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 21 Feb 2014 04:54:13 +0000
Subject: Re: [lm-sensors] [PATCH 0/4] hwmon: (max6650) Cleanup and convert to new API
Message-Id: <5306DBF5.8010704@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392226866-25968-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392226866-25968-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/12/2014 09:41 AM, Guenter Roeck wrote:
> This patch series has been compile tested only and would require
> testing with real hardware.
>
> ----------------------------------------------------------------
> Guenter Roeck (4):
>        hwmon: (max6650) Rearrange code to no longer require forward declarations
>        hwmon: (max6650) Convert to use devm_hwmon_device_register_with_groups
>        hwmon: (max6650) Drop error message after memory allocation failures
>        hwmon: (max6650) Introduce local 'dev' variable
>
>   drivers/hwmon/max6650.c |  257 +++++++++++++++++++++--------------------------
>   1 file changed, 112 insertions(+), 145 deletions(-)
>
>
I received chip samples and was able to test the above patch series
with a real MAX6650. I will therefore move the series to hwmon-next.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
