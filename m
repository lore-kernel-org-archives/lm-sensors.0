From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Dec 2010 09:00:16 +0000
Subject: Re: [lm-sensors] [PATCH] lsm303dlh: Adding Accelerometer and
Message-Id: <20101201100016.22b3ea0d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1291180447-16570-1-git-send-email-chethan.krishna@stericsson.com>
In-Reply-To: <1291180447-16570-1-git-send-email-chethan.krishna@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chethan Krishna N <chethan.krishna@stericsson.com>
Cc: guenter.roeck@ericsson.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, preetham.rao@stericsson.com, linus.walleij@linaro.org, mian-yousaf.kaukab@linaro.org

On Wed,  1 Dec 2010 10:44:07 +0530, Chethan Krishna N wrote:
> From: Chethan Krishna N <chethan.krishna@stericsson.com>
> 
> lsm303dlh accelerometer magnetometer device support added.
> Also provides input device support through interrupts.
> 
> Signed-off-by: Chethan Krishna N <chethan.krishna@stericsson.com>
> ---
>  drivers/hwmon/Kconfig       |   23 +
>  drivers/hwmon/Makefile      |    1 +
>  drivers/hwmon/lsm303dlh_a.c | 1112 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/lsm303dlh_m.c |  764 +++++++++++++++++++++++++++++
>  include/linux/lsm303dlh.h   |   56 +++
>  5 files changed, 1956 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 drivers/hwmon/Kconfig
>  create mode 100644 drivers/hwmon/lsm303dlh_a.c
>  create mode 100644 drivers/hwmon/lsm303dlh_m.c
>  create mode 100644 include/linux/lsm303dlh.h

Nack. This isn't a hardware monitoring driver, so it has nothing to do
in drivers/hwmon. Please find a better place.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
