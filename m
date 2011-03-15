From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Mar 2011 16:16:54 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/5] hwmon: lis3 patches
Message-Id: <20110315171654.0d87b7da@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300204965-7209-1-git-send-email-ilkka.koskinen@nokia.com>
In-Reply-To: <1300204965-7209-1-git-send-email-ilkka.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ilkka Koskinen <ilkka.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 15 Mar 2011 18:02:40 +0200, Ilkka Koskinen wrote:
> The first patch fixes a bug in lis3 i2c driver when probe() fails.
> 
> The rest of the patches converts statically allocated lis3 device
> to dynamically allocated one, which enables support for
> multiple lis3 devices on board. In addition, this patch set makes
> it possible to load both i2c and spi drivers so that they don't
> disturb each other. hp_accel is hacked to work and, thus, doesn't
> support multiple devices.
> 
> I have tested the i2c based driver on target device, but haven't
> the other two. 
> 
> The patches apply on top of hwmon-staging branch in 
> git://localhost/pub/scm/linux/kernel/git/groeck/staging.git

I already have patches pending, which kick lis3lv02d out of
drivers/hwmon:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/

I'll get this tree merged into Linus' tree at the end of the week. Then
you will have to rebase your patches and send them again (but not to
the lm-sensors list, we do NOT want to see them there.) Thanks.

> Ilkka Koskinen (5):
>   hwmon: lis3: Free regulators if probe() fails.
>   hwmon: lis3: Change naming to consistent
>   hwmon: lis3: Change exported function to use given device
>   hwmon: lis3: Remove the referencies to the global variable in core
>     driver
>   hwmon: lis3: Register hwif and remove references to global variable
> 
>  drivers/hwmon/hp_accel.c      |   52 ++++---
>  drivers/hwmon/lis3lv02d.c     |  392 +++++++++++++++++++++++------------------
>  drivers/hwmon/lis3lv02d.h     |   11 +-
>  drivers/hwmon/lis3lv02d_i2c.c |   67 ++++---
>  drivers/hwmon/lis3lv02d_spi.c |   35 +++--
>  5 files changed, 319 insertions(+), 238 deletions(-)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
