From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 Mar 2011 08:55:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver for SMSC SCH5627 hwmon
Message-Id: <20110314095520.1a5c3795@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299871683-3945-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1299871683-3945-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 14 Mar 2011 09:35:30 +0100, Hans de Goede wrote:
> SMSC SCH5627 Super I/O chips include complete hardware monitoring
> capabilities. They can monitor up to 5 voltages, 4 fans and 8 temperatures.
> 
> The hardware monitoring part of the SMSC SCH5627 is accessed by talking
> through an embedded microcontroller. An application note describing the
> protocol for communicating with the microcontroller is available upon
> request. Please mail me if you want a copy.
> 
> Changes since version 1:
> * Properly format multi line comments
> * Avoid a potential divide by 0
> * Use pr_err / pr_warn / pr_err instead of printk
> 
> Changes since version 2:
> * Various cleanups as result of a thorough review by Jean Delvare
> 
> Changes since version 3:
> * Report fan reading of 0xffff as 0 rpm
> * Mark sch5627_read_limits __devinit
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/hwmon/sch5627 |   22 ++
>  MAINTAINERS                 |    7 +
>  drivers/hwmon/Kconfig       |    9 +
>  drivers/hwmon/Makefile      |    1 +
>  drivers/hwmon/sch5627.c     |  857 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 896 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/sch5627
>  create mode 100644 drivers/hwmon/sch5627.c

Applied, thanks!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
