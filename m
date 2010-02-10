From: Paul Thomas <pthomas8589@gmail.com>
Date: Wed, 10 Feb 2010 00:08:37 +0000
Subject: Re: [lm-sensors] [PATCH] ads787x A/D driver for hwmon
Message-Id: <c785bba31002091608p7eaec920j18282c33c82dfc8f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1265759943-19863-1-git-send-email-pthomas8589@gmail.com>
In-Reply-To: <1265759943-19863-1-git-send-email-pthomas8589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK, this patch is for the TI ads787x A/D converter. I'm using the
ads7871, but I know the ads7870 is almost the same. This is by no
means a final version, but I wanted to get something out there to
review. This patch is against net-next because that's the kernel I'm
currently using with all the SPI stuff.

The main thing I'm missing is doing something sane and gracefully
exiting with several of the returns.

Also I don't have any locking in the show_voltage function. I think
this is OK, if two people start a conversion at the same time that
should be OK. The main thing is to check MUX_CNV. I would have liked
to have reported the voltage out in volts instead of units out of
8,192, but I guess the kernel doesn't handle floating point math or
printing correctly.

Currently the driver only supports single-ended reads, but I would
like to include differential reads. How would that config be done? A
file in sysfs?

thanks,
Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
