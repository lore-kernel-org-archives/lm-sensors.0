From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Feb 2013 16:21:13 +0000
Subject: Re: [lm-sensors] [PATCH 4/7] hwmon: (pmbus/ltc2978) Use detected chip ID to select supported functio
Message-Id: <20130227172113.745d37e3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361585975-5604-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1361585975-5604-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 27 Feb 2013 08:12:06 -0800, Guenter Roeck wrote:
> On Wed, Feb 27, 2013 at 10:35:48AM +0100, Jean Delvare wrote:
> > That being said, probe() isn't supposed to do device detection in the
> > first place. If you want devices to be auto-detected, there is the
> > detect() function for that. Right now there is no way for the user to
> > instantiate a device if it doesn't have exactly the expected ID. This
> > could happen though, if using a compatible part from a different
> > manufacturer, or a recent part with a new ID, for example.
>
> Yes. Problem with PMBus devices, though, is that most of them can reside on any
> I2C address, so a detect function would have to cover too many i2c addresses
> and is not really feasible.
> 
> If there is a new part, people should use the generic PMBus driver,
> not any of the device specific drivers. I have not seen an instance where the
> device specific driver could be used for another chip or chip variant without
> a change in the driver. Call it over-cautious, but one of the concerns I have
> is that a wrongly addressed or programmed PMBus chip can easily make a board
> unusable or even physically destroy it. I managed to do both several times
> myself - last time just a couple of days ago with a LM25066, which went up in
> smoke after writing a wrong value into one of its registers. I want to have
> as many safeguards as I can in place to prevent that from happening.

OK, fair enough. Might be worth a comment in the driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
