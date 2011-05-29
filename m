From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 29 May 2011 07:23:07 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: New driver sch5636
Message-Id: <20110529092307.1e0779e2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306567285-2322-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1306567285-2322-3-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 28 May 2011 09:21:25 +0200, Hans de Goede wrote:
> This patch adds a new driver for SMSC SCH5636 Super I/O chips.
> The chips include an embedded microcontroller for hardware monitoring
> solutions, allowing motherboard manufacturers to create their own custom
> hwmon solution based upon the SCH5636.
> 
> Currently the sch5636 driver only supports the Fujitsu Theseus SCH5636 based
> hwmon solution. The sch5636 driver runs a sanity check on loading to ensure
> it is dealing with a Fujitsu Theseus and not with another custom SCH5636 based
> hwmon solution.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/hwmon/sch5636    |   31 +++
>  drivers/hwmon/Kconfig          |   15 ++
>  drivers/hwmon/Makefile         |    1 +
>  drivers/hwmon/sch5636.c        |  539 ++++++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/sch56xx-common.c |    4 +
>  5 files changed, 590 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/sch5636
>  create mode 100644 drivers/hwmon/sch5636.c
> 
> diff --git a/Documentation/hwmon/sch5636 b/Documentation/hwmon/sch5636
> new file mode 100644
> index 0000000..ac975a6
> --- /dev/null
> +++ b/Documentation/hwmon/sch5636
> @@ -0,0 +1,31 @@
> +Kernel driver sch5636
> +==========> +
> +Supported chips:
> +  * SMSC SCH5636
> +    Prefix: 'sch5636'
> +    Addresses scanned: none, address read from Super I/O config space
> +
> +Author: Hans de Goede <hdegoede@redhat.com>
> +
> +
> +Description
> +-----------
> +
> +SMSC SCH5636 Super I/O chips include an embedded microcontroller for
> +hardware monitoring solutions, allowing motherboard manufacturers to create
> +their own custom hwmon solution based upon the SCH5636.
> +
> +Currently the sch5636 driver only supports the Fujitsu Theseus SCH5636 based
> +hwmon solution. The sch5636 driver runs a sanity check on loading to ensure
> +it is dealing with a Fujitsu Theseus and not with another custom SCH5636 based
> +hwmon solution.
> +
> +The Fujitsu Theseus can monitor up to 5 voltages, 8 fans and 16
> +temperatures. Note that the driver detects how many fan headers /
> +temperature sensors are actually implemented on the motherboard, so you will
> +likely see fewer temperature and fan inputs.
> +
> +An application note decribing the Theseus' registers, as well as an

Spelling: describing.

> +application note describing the protocol for communicating with the
> +microcontroller is available upon request. Please mail me if you want a copy.

Fixed the above myself, all the rest looks good, thanks for your
contribution, applied.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
