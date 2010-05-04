From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 May 2010 14:54:54 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] emc1403: thermal sensor support
Message-Id: <20100504165454.5f2d02e4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100414125205.23181.15562.stgit@localhost.localdomain>
In-Reply-To: <20100414125205.23181.15562.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 4 May 2010 12:33:00 +0100, Alan Cox wrote:
> Agreed - done, and additional detection bits added from your mini-patch
> 
> Can't currently test this however.
> 
> 
> 
> emc1403: thermal sensor support
> 
> From: Kalhan Trisal <kalhan.trisal at intel.com>
> 
> Provides support for the emc1403 thermal sensor. Only reporting of values
> is supported. The various Moorestown specific extras to do with thermal
> alerts and the like are not in this version of the driver.
> 
> Considerably edited and tidied up by Alan Cox, plus fixes and detection bits
> from Jean Delvare.
> 
> Signed-off-by: Kalhan Trisal <kalhan.trisal at intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/hwmon/Kconfig   |   10 +
>  drivers/hwmon/Makefile  |    1 
>  drivers/hwmon/emc1403.c |  344 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 355 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/emc1403.c
> 
> (...)

Fine with me, thank you. I've queued this new driver for merge in
2.6.35-rc1.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
