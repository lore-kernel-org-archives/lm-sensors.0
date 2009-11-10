From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Nov 2009 21:39:07 +0000
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon:driver support for Kionix
Message-Id: <20091110223907.1f47b07f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257877729-25647-1-git-send-email-chudson@kionix.com>
	<20091110193539.7e1392f3@hyperion.delvare>
	<4AF9B5E3.1060902@kionix.com>
	<4AF9B847.3070008@cam.ac.uk>
	<4AF9CDF2.2070003@kionix.com>
In-Reply-To: <4AF9CDF2.2070003@kionix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Hudson <chudson@kionix.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-omap@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, 10 Nov 2009 15:32:50 -0500, Chris Hudson wrote:
> Thank you for your insight Jonathan.  The driver was originally written 
> for the 2.6.29 omap-android kernel to facilitate integration of the 
> kxte9 into customer projects.  Unfortunately, it seems that things in 
> the kernel have changed since then, but I'm not sure how much we can 
> change without sacrificing compatibility with the Android sensor API.  
> Is there a different place where this driver could go without requiring 
> significant redesign?

I don't think a move implies a redesign. You could put exactly the same
driver under drivers/misc, drivers/accel, drivers/input or what do I
know. I don't want it in drivers/hwmon, but I don't care about anything
else.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
