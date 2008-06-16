From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Jun 2008 06:36:16 +0000
Subject: Re: [lm-sensors] [PATCH] ad7414 driver
Message-Id: <20080616083616.7418e023@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080613221221.50c642ee@lappy.seanm.ca>
In-Reply-To: <20080613221221.50c642ee@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sean

On Sun, 15 Jun 2008 18:07:48 -0400, Sean MacLennan wrote:
> Thanks for the review... I will work on the changes.

Great.

> I just wanted to make a couple of general comments. This driver was
> based on the ad7418 driver, at least according to the copyrights at the
> top. I assumed that the basic functionality (show/set for example) was
> correct. I notice that many of the comments for this driver also apply
> to the ad7418 ;)

I just took a quick look at the current ad7418 driver and I didn't see
much that needs fixing, except for the missing inclusion of
<linux/sysfs.h>. Also, the ad7418 driver is a legacy i2c driver while
the ad7414 driver was turned into a new-style i2c driver, so all the
administrative part is different. Anyway, if you see things in the
ad7418 driver which you think needs fixing or could be improved, feel
free to send a patch and we'll review it.

> I am using the ad7414 on the PIKA Warp product. The ad7414 is a very
> important part of what we call DTM: Dynamic Thermal Management.
> Basically DTM controls the fan and shuts down the machine if it gets
> too hot.
> 
> The Warp does not have libsensors, let alone any apps to connect to
> libsensors. All of the DTM is done in the kernel itself.
> 
> I could give you a link to the DTM code, but we had a bad thunderstorm
> here and I can no longer connect to work :( I believe it is here:
> 
> http://svn.pikatech.com/appliance/branches/linux-2.6/arch/powerpc/platforms/44x/warp/warp.c

Almost...

http://svn.pikatech.com/appliance/branches/linux-2.6/arch/powerpc/platforms/44x/warp.c

Hmm, the code there is not exactly nice... Obviously the hwmon and i2c
subsystems were not designed with this use case in mind, there's room
for improvement. But that's a long way to go, and I really don't have
the time to dive into this at the moment. I'll try to keep in mind for
later though.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
