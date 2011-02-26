From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Sat, 26 Feb 2011 18:25:37 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/5] hwmon: PMBus device driver
Message-Id: <4D6945A1.1030807@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298742650-9789-1-git-send-email-guenter.roeck@ericsson.com> <1298742650-9789-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1298742650-9789-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <kernel@jic23.retrosnub.co.uk>, Randy Dunlap <rdunlap@xenotime.net>, Greg Schnorr <gschnorr@cisco.com>, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/26/11 17:50, Guenter Roeck wrote:
> This driver adds support for hardware monitoring features of various PMBus
> devices.
> 
I'm happy with changes/responses to comments so ready to merge as far as
I am concerned.
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/hwmon/Kconfig      |   25 +
>  drivers/hwmon/Makefile     |    4 +
>  drivers/hwmon/pmbus.c      |  203 ++++++
>  drivers/hwmon/pmbus.h      |  313 +++++++++
>  drivers/hwmon/pmbus_core.c | 1628 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/pmbus.h  |   45 ++
>  6 files changed, 2218 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/pmbus.c
>  create mode 100644 drivers/hwmon/pmbus.h
>  create mode 100644 drivers/hwmon/pmbus_core.c
>  create mode 100644 include/linux/i2c/pmbus.h
...

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
