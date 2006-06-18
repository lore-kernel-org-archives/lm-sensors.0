From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Jun 2006 15:08:55 +0000
Subject: [lm-sensors] Dedicated mailing list for i2c
Message-Id: <20060618170855.8e49033c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060613142005.0d4e4763.khali@linux-fr.org>
In-Reply-To: <20060613142005.0d4e4763.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> I think it is about time to have a dedicated list for i2c, instead of
> having a single list for hardware monitoring (sensors) and i2c. There
> are more and more non-sensors users for the i2c bus (for example
> media/video adapters, RTC chips) and more different connectivities for
> sensors (for example SPI) so having a single list makes less and less
> sense.

The balance being in favor of a separate list for i2c by 3 to 0, let's
do that. This raises the question of what w1 will become. If i2c has a
seperate list, keeping w1 in the lm-sensors list would be confusing.

Evgeniy, I think you should have a separate list for w1, like we plan
to do for i2c. We can host the list for you on lm-sensors.org's mailman
if you want, or if you prefer you can move to a different place. Your
call, just let us know.

-- 
Jean Delvare

