From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Date: Thu, 14 Oct 2010 11:51:48 +0000
Subject: Re: [lm-sensors] Detection of W83L771W/G in lm90
Message-Id: <201010141351.48398.alexander.stein@informatik.tu-chemnitz.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014114626.7c4be041@endymion.delvare>
In-Reply-To: <20101014114626.7c4be041@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean,

On Thursday 14 October 2010, 13:37:27 Jean Delvare wrote:
> > Please provide me a standalone driver, as the patch doesn't apply.
> > Neither on my 2.6.34 nor on my git kernel. It seems your lines are
> > messed up.
> > 
> > > @@ -1237,10 +1237,23 @@ static int lm90_detect(struct i2c_client
> > 
> > My driver has only 1072 lines.
> > 
> > > # wc -l lm90.c
> > > 1072 lm90.c
> 
> The patch goes on top of 11 other pending patches to the lm90 driver,
> that's why it doesn't apply on your vanilla kernel trees. The
> standalone driver will be easier to test:
> 
> http://khali.linux-fr.org/devel/misc/lm90/
> 
> Should work OK with any kernel >= 2.6.32.

Oh, well, I didn't mean _that_ standalone, but I just used lm90.c and removed 
#include "i2c-compat.h" and replaced the one in my v2.6.34 kernel tree. After 
make modules_install; rmmod lm90; modprobe lm90 it seems the sensor is auto-
detected, 'sensors' lists it.

Thanks a lot. Best regards,
Alexander

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
