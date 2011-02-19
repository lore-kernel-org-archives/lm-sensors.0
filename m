From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 19 Feb 2011 20:47:15 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] Move hp_accel to drivers/platform/x86
Message-Id: <20110219204715.GB1728@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219142503.77aadd2d@endymion.delvare>
In-Reply-To: <20110219142503.77aadd2d@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 19, 2011 at 08:25:03AM -0500, Jean Delvare wrote:
> The hp_accel driver isn't a hardware monitoring driver, so it doesn't
> belong to drivers/hwmon. Move it to drivers/platform/x86, assuming HP
> doesn't ship non-x86 laptops.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Eric Piel <eric.piel@tremplin-utc.net>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> Not tested due to lack of hardware.
> 
>  drivers/hwmon/Kconfig           |   59 -----
>  drivers/hwmon/Makefile          |    1
>  drivers/hwmon/hp_accel.c        |  405 ---------------------------------------
>  drivers/platform/x86/Kconfig    |   18 +
>  drivers/platform/x86/Makefile   |    1
>  drivers/platform/x86/hp_accel.c |  405 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 424 insertions(+), 465 deletions(-)
> 
Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
