From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 05 Jul 2010 11:59:00 +0000
Subject: Re: [lm-sensors] [PATCH v4 1/2] hwmon: w83627ehf driver cleanup
Message-Id: <20100705135900.457764e7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1278195202-2683-1-git-send-email-guenter.roeck@ericsson.com>
	<1278195202-2683-2-git-send-email-guenter.roeck@ericsson.com>
	<20100704132442.07a5ef40@hyperion.delvare>
	<20100704135010.GA21500@ericsson.com>
In-Reply-To: <20100704135010.GA21500@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ethan Lawrence <e.law87@yahoo.com>, Jim Cromie <jim.cromie@gmail.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, Iain <selsinork@gmail.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lars4910@hotmail.com" <lars4910@hotmail.com>, "birdie@permonline.ru" <birdie@permonline.ru>, "jadcock@cox.net" <jadcock@cox.net>, "binximeng@gmail.com" <binximeng@gmail.com>

Hi Guenter,

On Sun, 4 Jul 2010 06:50:10 -0700, Guenter Roeck wrote:
> On Sun, Jul 04, 2010 at 07:24:42AM -0400, Jean Delvare wrote:
> > I'm skeptical. data->has_fan refers to fan inputs, not fan outputs.
> > There is no guarantee that pwm1 is mapped to fan1, etc., so you can't
> > use data->has_fan to discard fan outputs.
>
> Maybe, but they are treated as 1:1 for fan4 when creating the pwm files,
> and the pwm files for fan4 are not created if the matching bit isn't set.
> This applies to all chips supported by this driver. And for fan1..3, the
> mapping is supposed to be 1:1 per the driver documentation.

The driver documentation was written by ourselves, I wouldn't trust it ;)

Oh well, I hadn't noticed that sysfs file creation already assumes a
1:1 fan to pwm mapping. I am still unsure if it is correct, but it might
be good enough on practice, and your patch isn't changing it anyway, so
it's not the time to discuss it.

> I figured that it does not make sense to read the registers for a non-existing
> attribute file.

I agree that we want to skip register reads when possible (not that it
matters as much as when reading over slow SMBus though.) 

I have no further objections to your patch, so I'll apply it now. Then
I'll publish the patches and update the stand-alone driver, and we can
call for testers.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
