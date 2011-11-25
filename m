From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Nov 2011 13:02:02 +0000
Subject: Re: [lm-sensors] [PATCH 04/11] hwmon: Remove redundant spi driver
Message-Id: <20111125140202.37cd4564@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1322148561-25138-1-git-send-email-lars@metafoo.de>
	<1322148561-25138-4-git-send-email-lars@metafoo.de>
	<20111125095823.GB8908@ericsson.com>
In-Reply-To: <20111125095823.GB8908@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, 25 Nov 2011 01:58:23 -0800, Guenter Roeck wrote:
> On Thu, Nov 24, 2011 at 10:29:14AM -0500, Lars-Peter Clausen wrote:
> > In ancient times it was necessary to manually initialize the bus field of an
> > spi_driver to spi_bus_type. These days this is done in spi_driver_register(),
> 
> s/spi_driver_register/spi_register_driver/
> 
> Otherwise
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Jean, ok if I take this and the others, or do you want to handle it ?

Please take them.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
