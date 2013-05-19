From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 19 May 2013 15:38:52 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] Add ds1631 chip support to ds1621 driver
Message-Id: <20130519153852.GA22408@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368742242-15191-1-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1368742242-15191-1-git-send-email-rob.coulson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 16, 2013 at 03:10:40PM -0700, Robert Coulson wrote:
> This set of patches adds ds1631 chip support into the ds1621 driver,
> documentation, and Kconfig.
> 
> It is based on the 3.9 source base and intended for hwmon-next since it is
> dependent on the previously applied ds1721 chip support patch set.
> 
> In addition, this code has been tested and validated with the ds1621,
> ds1625, ds1721, and ds1631 chips, using sensors, sensors-detect, and
> explicit device instantiation
> 
> Robert Coulson (2):
>   hwmon (ds1621): Add ds1631 chip support to ds1621 driver
>   hwmon (ds1621): Add ds1631 information to ds1621 Documentation and

Hi Rob,

Folded both patches into one, and applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
