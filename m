From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 31 Aug 2012 16:07:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add Maxim MAX197 support
Message-Id: <20120831160750.GC5756@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346351995-9038-1-git-send-email-vivien.didelot@savoirfairelinux.com>
 <20120830210959.GA11153@roeck-us.net>
 <20120831163718.38144c01@endymion.delvare>
In-Reply-To: <20120831163718.38144c01@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Fri, Aug 31, 2012 at 04:37:18PM +0200, Jean Delvare wrote:
> On Thu, 30 Aug 2012 14:09:59 -0700, Guenter Roeck wrote:
> > I have the solution for the platform driver.
> > 
> > enum chips { max197, max199 };
> > 
> > [ ... ]
> > 
> > static struct platform_device_id max197_driver_ids[] = {
> >         {
> > 		.name = "max197",
> > 		.driver_data = max197,
> > 	}, {
> > 		.name = "max199",
> > 		.driver_data = max199,
> > 	}
> > };
> > MODULE_DEVICE_TABLE(platform, max197_driver_ids);
> 
> Wow, I thought this did not exist and this made me rumble a number of
> times, and now I see this was finally introduced over 3 years ago.
> Cool! And spi has it too now, wonderful world :)
> 
Same here ... and now I feel a bit embarassed that I didn't know :)

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
