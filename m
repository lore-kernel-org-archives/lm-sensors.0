From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Nov 2005 13:18:53 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <KCCkzhPP.1132748311.9647150.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Daniel, Keith,

On 2005-11-23, Daniel Nilsson wrote:
> Last night I reported ticket #2116[1] which is related to the kernel
> hanging when attempting to set the sensor limits with sensors -s. I
> started reading on the list of other open tickets on other chips to
> see if I could find something similar, and I found ticket #2111[2]
> reported by Keith.
>
> The common thing between both our problems is that:
>
> 1. We both use kernel 2.6.14 (either 2.6.14 or 2.6.14.2).
> 2. We both use the i2c-i801 driver.
> 3. We both have SMP enabled kernels running on P4 CPUs with HT enabled.

4. You both have the eeprom module loaded.

> In my case I have the w83792d driver for my sensor chip while Keith is
> using the lm85 driver. But since we both experience the same lockup
> under the same conditions I'm more suspicious of the i2c-i801 driver
> and how that driver is behaving in kernel 2.6.14 on SMP systems. Any
> other experience where this driver is find under these conditions?

No other report I can think of. Most reported problems of "sensors -s"
causing problems are either CPU throttling or instant power-off, not
lockups.

The i2c-i801 did not receive any recent change which could explain the
problem, and the driver is widely used (including by me on UP) so it is
certainly not fundamentally broken. It must have been widely tested on
SMP systems too. You have an ICH7 though, which is one of the most
recent incarnation of the i801, and this one may not have received
extended testing. Keith, is it an ICH7 on your system too, or another
incarnation?

"sensors -s" does too many things so it'll be hard to find out what
exactly causes the hang. Could be any write on the bus, or a specific
limit change. Better would be to try writing to the /sysfs files
directly, manually, and see if any write causes the problem, or only to
certain files.

Please also try to reproduce the hang without loading the eeprom driver.
I would additionally be interested in the SMBus topology (output of
"i2cdetect 0" to start with, or whatever the bus number is for
i2c-i801). Do you happen to know if the SMBus on that board is
multiplexed or shared with another bus type.?

--
Jean Delvare
