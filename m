From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Nov 2009 18:35:39 +0000
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon:driver support for Kionix
Message-Id: <20091110193539.7e1392f3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257877729-25647-1-git-send-email-chudson@kionix.com>
In-Reply-To: <1257877729-25647-1-git-send-email-chudson@kionix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Hudson <chudson@kionix.com>
Cc: linux-omap@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, 10 Nov 2009 13:28:47 -0500, chudson@kionix.com wrote:
> From: Chris Hudson <chudson@kionix.com>
> 
> This is a request for comments for adding driver support for the Kionix KXTE9 
> digital tri-axis accelerometer.  This part features built-in tilt position 
> (orientation), wake-up and back-to-sleep algorithms, which can trigger a 
> user-configurable physical interrupt.  The driver uses i2c for device 
> communication, a misc node for IOCTLs, and input nodes for reporting 
> acceleration data and interrupt status information.
> 
> Signed-off-by: Chris Hudson <chudson@kionix.com>

Nack. We want less accelerometer drivers polluting drivers/hwmon, not
more.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
