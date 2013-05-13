From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 13 May 2013 01:28:15 +0000
Subject: Re: [lm-sensors] [lm-sensors 2/2] hwmon: (ds1621) Add ds1721 update interval sysfs attribute
Message-Id: <20130513012815.GB15839@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368078354-26298-3-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1368078354-26298-3-git-send-email-rob.coulson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 08, 2013 at 10:45:54PM -0700, Robert Coulson wrote:
> The ds1721 device can be configured for 9..12 bit resolutions;
> add a sysfs attribute for userspace to configure this attribute.
> The definition, description, details, and usage are shown in the
> documentation and were crafted from an LM73 driver patch done by
> Chris Verges & Guenter Roeck).
> 
> Signed-off-by: Robert Coulson <rob.coulson@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
