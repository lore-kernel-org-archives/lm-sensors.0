From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: lm_sensors doesn't detect voltage measurements on HP Proliant
Message-Id: <20040915085608.M86764@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000201c49a51$c73208b0$aa790251@hytecelectronics.co.uk>
In-Reply-To: <000201c49a51$c73208b0$aa790251@hytecelectronics.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 15 Sep 2004 09:20:30 +0100, Jim Chen wrote
> Hi Jean,
> 
> Thank you very much for your help.
> 
> The attached file contains the results by using i2cdump. Hope this help.

First device at 0x33 is "nothing" as expected (most likely the protection
settings address of the eeprom at 0x53). You missed the second dump, I asked
for 0x60 and you did 0x69, so you dump the clock device instead of the unknown
device. You're lucky it didn't freeze your system, since some clock chips are
known for they moderatrely appreciate being dumped. Please try 0x60 now.

> I have contacted HP. They recommended me to use their "System Inside
> Manager" utility which can show all the measurements. That sounds 
> like they must have a sensor or sensors on the board. But they might 
> not provide the interface for the user to integrate. Is there 
> anything we can do about this that we can get the measurements out?

Sounds much like Compaq and their proprietary "cpqhealth" tool of yore. These
folks don't seem to like cooperating with us, which is quite strange since HP
seems to have embraced the open-source movement by now (they even were the
main sponsor for the Sucon '04 in Zurich in early september).

I would suggest that you give a try to their tool. If it does what you want, I
guess there is no need to complain. If not, tell them why. And if you think we
are more likely to provide what you need than they are, tell them, and ask
them to release details specs for their implementation. Maybe they'll listen...

As a paying customer, you have much more power than we will ever have,
especially if you have a large number of these machines and are likely to buy
more at some point in the future.

-- 
Jean Delvare
http://khali.linux-fr.org/
