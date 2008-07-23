From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Wed, 23 Jul 2008 17:48:01 +0000
Subject: Re: [lm-sensors] [Patch 0/4] IndustrialIO subsystem (ADCs,
Message-Id: <20080723174801.GC11009@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com>
In-Reply-To: <488763AD.4050400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, spi-devel-general@lists.sourceforge.net, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Dmitry Torokhov <dtor@mail.ru>, "Hans J. Koch" <hjk@linutronix.de>, David Brownell <david-b@pacbell.net>, mgross@linux.intel.com, Ben Nizette <bn@niasdigital.com>, Anton Vorontsov <avorontsov@ru.mvista.com>

On Wed, 23 Jul 2008, Jonathan Cameron wrote:
> The subsystem is now in a functional state with a small set of drivers:
> 
> Max1363 (supports numerous Maxim i2c ADC's) (tested with max1363 and max1238 chips)
>    - Uses a periodic timer to provide ring buffer mode.
>    - All reads form these devices are scan modes so direct single element access
>      is not provided.
>    - Monitor mode on max1363 is not yet supported (need to do a bit debugging of
>      the board I have so as to be able to test this).
> 
> ST LIS3L02DQ - SPI accelerometer.
>    - Uses a datardy interrupt to driver a software ring buffer.
>    - Most functionality of this device is supported.
> 
> VTI SCA3000 (tested with an e05)
>    - Hardware ring buffer.

I'd like to see something done to have the common parts of interfaces of the
same class (e.g. accelerometers) be standard.  Like hwmon does with
temp#_input, etc.

Otherwise you made it easier to write drivers, but did nothing to help
userspace to USE the drivers :-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
