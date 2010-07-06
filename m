From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Jul 2010 14:10:29 +0000
Subject: Re: [lm-sensors] [RFC][PATCH] suspend resume lm75
Message-Id: <20100706161029.6b2aef3f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 6 Jul 2010 19:29:07 +0530, Datta, Shubhrajyoti wrote:
> There is a shutdown feature at suspend it can be enabled
> to reduce current consumption and resume it can be switched
> off.
> 
> - Removed the unnecessary cleanups 
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/hwmon/lm75.c |   37 +++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/lm75.h |    1 +
>  2 files changed, 38 insertions(+), 0 deletions(-)

I have this patch in my tree already. There is no point in sending it
over again, it won't be merged before 2.6.36-rc1.

ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-lm75-add-suspend-and-resume.patch

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
