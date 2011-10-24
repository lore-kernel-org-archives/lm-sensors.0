From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 24 Oct 2011 19:33:42 +0000
Subject: Re: [lm-sensors] [PATCH 5/6] IIO:hwmon interface client driver.
Message-Id: <20111024193342.GA27011@n2100.arm.linux.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1319103187-27791-1-git-send-email-jic23@cam.ac.uk> <1319103187-27791-6-git-send-email-jic23@cam.ac.uk> <1319123566.3720.297.camel@groeck-laptop> <4EA03E8D.1010303@cam.ac.uk> <4EA53973.9080102@cam.ac.uk> <1319470784.2583.46.camel@groeck-laptop> <4EA58B39.8030608@cam.ac.uk>
In-Reply-To: <4EA58B39.8030608@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: guenter.roeck@ericsson.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linus.ml.walleij@gmail.com" <linus.ml.walleij@gmail.com>, "zdevai@gmail.com" <zdevai@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "gregkh@suse.de" <gregkh@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>, "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>

On Mon, Oct 24, 2011 at 04:58:49PM +0100, Jonathan Cameron wrote:
> On 10/24/11 16:39, Guenter Roeck wrote:
> > Is div_s64 really necessary, or would
> > 
> > 		result = (long)val * (long)scaleint +
> > 			DIV_ROUND_CLOSEST((s64)val * (s64)scalepart,
> > 					 1000000000LL);
> > 
> > work as well ?
> Not if you want it to compile on arm v5 by the look of it.
> 
> ERROR: "__aeabi_ldivmod" [drivers/staging/iio/iio_hwmon.ko] undefined!

You know, div64 is there to deal with the case of _sanely_ dividing
a 64-bit number by a 32-bit number - there should be absolutely no
question about _not_ using it if that's the operation you are wanting
to perform.

Expecting gcc to do a better job without using div64 is just asking for
bad code on 32-bit platforms.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
