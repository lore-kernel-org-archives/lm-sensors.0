From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Jul 2011 15:01:47 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (pmbus) Add ADP4000,
Message-Id: <20110720170147.5d4d7fc6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309907054-4254-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1309907054-4254-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Jul 2011 16:04:14 -0700, Guenter Roeck wrote:
> Add ADP4000, NCP4200 and NCP4208 to the list of devices supported by the generic
> PMBus driver, and add device IDs to enable explicit instantiation.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/pmbus |    7 +++++++
>  drivers/hwmon/Kconfig     |    4 ++--
>  drivers/hwmon/pmbus.c     |    3 +++
>  3 files changed, 12 insertions(+), 2 deletions(-)

Looks good.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
