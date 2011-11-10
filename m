From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 10 Nov 2011 13:25:06 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] IIO:CORE add in kernel interface
Message-Id: <20111110132506.GF3832@opensource.wolfsonmicro.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320680681-5635-1-git-send-email-jic23@kernel.org>
 <1320680681-5635-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1320680681-5635-4-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, guenter.roeck@ericsson.com, khali@linux-fr.org, dmitry.torokhov@gmail.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org, lars@metafoo.de, maxime.ripard@free-electrons.com, lm-sensors@lm-sensors.org, thomas.petazzoni@free-electrons.com, zdevai@gmail.com, Jonathan Cameron <jic23@cam.ac.uk>

On Mon, Nov 07, 2011 at 03:44:39PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Two elements here:
> * Map as defined in include/linux/iio/inkern.h
> * Matching code to actually get the iio_dev and channel
> that we want from the global list of IIO devices.

I've not read it thoroughly but this certainly this looks sensible from
an external interface point of view, I'd expect that issues can be
worked through incrementally.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> +extern struct list_head iio_map_list;

It's surprising that this is part of the external interface of IIO
rather than something hidden within the implementation.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
