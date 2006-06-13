From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 13 Jun 2006 12:20:05 +0000
Subject: [lm-sensors] Dedicated mailing list for i2c
Message-Id: <20060613142005.0d4e4763.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I think it is about time to have a dedicated list for i2c, instead of
having a single list for hardware monitoring (sensors) and i2c. There
are more and more non-sensors users for the i2c bus (for example
media/video adapters, RTC chips) and more different connectivities for
sensors (for example SPI) so having a single list makes less and less
sense.

I'm certain that some people refrain from subscribing to our list
because they are only interested in one of the topics and don't want to
bother filtering manually. Also, having different lists may help us
bring more neutrality to the i2c subsystem, which has been
sensors-oriented for a long time for historical reasons. I have already
taken several steps to separate both in the kernel but there's still a
significant way to go.

If we create a list for i2c, then we should have a dedicated list for
w1 as well. Thanks to Axel Thimm we have a nice Mailman installation so
creating new lists shouldn't be a problem.

What do others think?

-- 
Jean Delvare

