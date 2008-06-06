From: Pau Oliva Fora <pau@eslack.org>
Date: Fri, 06 Jun 2008 15:30:57 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <48495831.3050404@eslack.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost>	<4846EBF5.2030406@tremplin-utc.net>	<20080604225830.1dff64fc@hyperion.delvare>	<20080604230510.GB30475@elf.ucw.cz>	<484728B2.1000209@tremplin-utc.net> <20080605082950.6957f1a2@hyperion.delvare> <4847B415.2080708@cam.ac.uk> <48484DD6.3050706@tremplin-utc.net> <4848683E.4070709@eslack.org> <48495017.8040003@tudelft.nl>
In-Reply-To: <48495017.8040003@tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Piel <E.A.B.Piel@tudelft.nl>
Cc: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>, Jonathan Cameron <jic23@cam.ac.uk>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>, Torokhov <dmitry.torokhov@gmail.com>, Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Pavel Machek <pavel@suse.cz>, Yan@ATrpms.net, Dmitry@ATrpms.net, Arjan van de Ven <arjan@infradead.org>

Eric Piel wrote:
> Pau Oliva Fora wrote:
>> Here's an i2c version of the driver for the LIS3LV02DL accelerometer,
>> please try to combine it too, so we'll end up having ACPI, SPI and I2C.
> Whaoo, you went fast!
> As there is a dmi_match, that shouldn't be too hard to incorporate it 
> nicely :-)
> 
> BTW, do you really need the invert_x and invert_y and swap_xy 
> parameters? Don't all the HTC shift laptops have the sensors soldered 
> the same way? We've worked hard to remove those parameters in mdps ;-)
> 

Yes, you can remove the module params, and use the same approach you 
have based in DMI table.

Cheers,

	Pau Oliva

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
