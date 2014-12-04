From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Dec 2014 19:02:38 +0000
Subject: Re: [lm-sensors] [PATCH v3 0/3] hwmon: tmp401: support for TMP435 and fix for a probe issue
Message-Id: <20141204190238.GA16710@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417711553-21311-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1417711553-21311-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On Thu, Dec 04, 2014 at 05:45:50PM +0100, Bartosz Golaszewski wrote:
> This series adds support for the TI TMP435 chip and fixes an issue similar
> to the one we observed for ina2xx - ignoring the write errors when probing the
> device.
> 
Series applied, with the tmp435 related patches merged into one.

Thanks,
Guenter

> v3:
> - remove the copyright notice from tmp401.c
> - preinitialize status and skip an 'if'
> 
> v2:
> - changed 'static const char *names' to 'static const char * const names'
>   as checkpatch.pl still complained about this one,
> - updated Documentation and Kconfig on TMP435,
> - added missing error check in tmp401_init_client(),
> - removed the redundant "Initialization failed" string since we'll get
>   'tmp401: probe of X-00XX failed with error -121' anyway in dmesg,
> 
> v1:
> https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg781930.html
> 
> Bartosz Golaszewski (2):
>   hwmon: tmp401: add TMP435 to the list of supported chips in docs and Kconfig
>   hwmon: tmp401: bail-out from tmp401_probe() in case of write errors
> 
> Patrick Titiano (1):
>   hwmon: tmp401: add support for TI TMP435
> 
>  Documentation/hwmon/tmp401 |  7 +++++--
>  drivers/hwmon/Kconfig      |  2 +-
>  drivers/hwmon/tmp401.c     | 45 ++++++++++++++++++++++++++++++++-------------
>  3 files changed, 38 insertions(+), 16 deletions(-)
> 
> -- 
> 2.1.3
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
