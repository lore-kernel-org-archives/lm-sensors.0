From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 19 Feb 2011 20:24:12 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] Move lis3lv02d drivers to drivers/misc
Message-Id: <20110219202412.GA1696@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219142638.16c306eb@endymion.delvare>
In-Reply-To: <20110219142638.16c306eb@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sat, Feb 19, 2011 at 08:26:38AM -0500, Jean Delvare wrote:
> The lis3lv02d drivers aren't hardware monitoring drivers, so the don't
> belong to drivers/hwmon. Move them to drivers/misc, short of a better
> home.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Eric Piel <eric.piel@tremplin-utc.net>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> Not tested due to lack of hardware.
> 
>  drivers/hwmon/Makefile                 |    5
>  drivers/hwmon/lis3lv02d.c              | 1000 --------------------------------
>  drivers/hwmon/lis3lv02d.h              |  291 ---------
>  drivers/hwmon/lis3lv02d_i2c.c          |  279 --------
>  drivers/hwmon/lis3lv02d_spi.c          |  144 ----
>  drivers/misc/Kconfig                   |    9
>  drivers/misc/Makefile                  |    1
>  drivers/misc/lis3lv02d/Kconfig         |   37 +
>  drivers/misc/lis3lv02d/Makefile        |    7
>  drivers/misc/lis3lv02d/lis3lv02d.c     |  999 +++++++++++++++++++++++++++++++
>  drivers/misc/lis3lv02d/lis3lv02d.h     |  291 +++++++++
>  drivers/misc/lis3lv02d/lis3lv02d_i2c.c |  279 ++++++++
>  drivers/misc/lis3lv02d/lis3lv02d_spi.c |  144 ++++
>  drivers/platform/x86/hp_accel.c        |    2
>  14 files changed, 1768 insertions(+), 1720 deletions(-)
> 
You might want to update MAINTAINERS as well.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
