From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 11 Mar 2007 14:40:23 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <20070311154023.55b759d0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 5 Mar 2007 12:34:21 +0100, Hans-J?rgen Koch wrote:
> Hi Jean,
> I updated the driver once again. Basically, I made these changes:
> 
> * "mode" is now not only a module parameter, but also a sysfs file. This is 
> needed to simply switch the fan fully on/off. Depending on the other 
> settings, this might not be possible with the "speed" attribute alone.
> 
> * Setting "speed" really only sets the speed value. The original 
> implementation changed "mode" between "off" and "closed loop" when speed was 
> 0 or >0, respectively. I consider this bad style, a driver should do what 
> it's told to do and not make guesses about what the user might wish.
> 
> * Updated documentation.
> 
> I left the other values as module parameters. I think it's unlikely that 
> somebody wants to set these to different values if he has more than one chip. 
> Of course we could make all of them sysfs files, too, but I think this is not 
> necessary. Let's wait and see if somebody actually wants that.

I can't get this version to compile:

  CC [M]  drivers/hwmon/max6650.o
drivers/hwmon/max6650.c: In function `max6650_attach_adapter':
drivers/hwmon/max6650.c:350: error: incompatible type for argument 1 of `dev_driver_string'
drivers/hwmon/max6650.c:350: error: invalid type argument of `->'
drivers/hwmon/max6650.c:354: error: incompatible type for argument 1 of `dev_driver_string'
drivers/hwmon/max6650.c:354: error: invalid type argument of `->'
drivers/hwmon/max6650.c: In function `max6650_detect':
drivers/hwmon/max6650.c:374: error: incompatible type for argument 1 of `dev_driver_string'
drivers/hwmon/max6650.c:374: error: invalid type argument of `->'
drivers/hwmon/max6650.c:377: error: incompatible type for argument 1 of `dev_driver_string'
drivers/hwmon/max6650.c:377: error: invalid type argument of `->'
drivers/hwmon/max6650.c:423: error: incompatible type for argument 1 of `dev_driver_string'
drivers/hwmon/max6650.c:423: error: invalid type argument of `->'
drivers/hwmon/max6650.c:455: error: incompatible type for argument 1 of `dev_driver_string'
drivers/hwmon/max6650.c:455: error: invalid type argument of `->'
make[2]: *** [drivers/hwmon/max6650.o] Error 1
make[1]: *** [drivers/hwmon] Error 2
make: *** [drivers] Error 2

I guess you didn't try with debug enabled...

Also, Corentin Labbe made interesting comments here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019017.html
(at the end of the post)
Please fix the problems he mentioned.

Thanks,
-- 
Jean Delvare

