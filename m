From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Nov 2011 15:42:04 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] IIO:CORE add in kernel interface
Message-Id: <CACRpkdbKPL6=t-YGSNZdb2aGXERvk6zPkb40ytOMbYXLQ7H2Vg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320680681-5635-1-git-send-email-jic23@kernel.org>
	<1320680681-5635-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1320680681-5635-4-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, guenter.roeck@ericsson.com, khali@linux-fr.org, dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk, arnd@arndb.de, lars@metafoo.de, maxime.ripard@free-electrons.com, lm-sensors@lm-sensors.org, thomas.petazzoni@free-electrons.com, zdevai@gmail.com, Jonathan Cameron <jic23@cam.ac.uk>

On Mon, Nov 7, 2011 at 4:44 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jic23@cam.ac.uk>
>
> Two elements here:
> * Map as defined in include/linux/iio/inkern.h
> * Matching code to actually get the iio_dev and channel
> that we want from the global list of IIO devices.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Overall this is what we want:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
