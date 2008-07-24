From: Eric Piel <eric.piel@tremplin-utc.net>
Date: Thu, 24 Jul 2008 09:01:40 +0000
Subject: Re: [lm-sensors] [Patch 1/4] Industrialio Core
Message-Id: <488844F4.1090809@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com> <488765A5.3040703@gmail.com>
In-Reply-To: <488765A5.3040703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, spi-devel-general@lists.sourceforge.net, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Dmitry Torokhov <dtor@mail.ru>, "Hans J. Koch" <hjk@linutronix.de>, hmh@hmh.eng.br, David Brownell <david-b@pacbell.net>, mgross@linux.intel.com, Ben Nizette <bn@niasdigital.com>, Anton Vorontsov <avorontsov@ru.mvista.com>

Jonathan Cameron schreef:
:
> +
> +static void __exit iio_exit(void)
> +{
> +	unregister_chrdev(IIO_MAJOR, "bob");
bob?! Maybe you meant "industrialio" ?

See you,
Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
