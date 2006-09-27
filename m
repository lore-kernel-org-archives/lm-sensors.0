From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Sep 2006 08:55:43 +0000
Subject: [lm-sensors] k8temp and it8716 support
Message-Id: <20060927105543.8479a268.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451A348B.80205@boomerangsworld.de>
In-Reply-To: <451A348B.80205@boomerangsworld.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ralf,

> I just want to drop a note that the kernel patches for it8716 and k8temp
> work well so far on my GA-M55plus-S3G motherboard with an Athlon X2.
> It's a 2.6.18 kernel and a lm-sensors SVN version from a few days ago
> using the default configuration.

Thanks for reporting! Glad it works fine for you.

> The sensor values look reasonable. One of the three temperatures of the
> it8716 chip matches roughly the temperature from the k8temp driver.
> Another value should be the system/chipset temperature but I have no
> idea what the third is about (but it's not constant).

Could be a thermal sensor in the CPU socket, or anywhere on your
motherboard, we can't really say. You'd need to ask the motherboard
maker, but the probability that you get a valid answer is low.

> The voltages look okay but the min values are all zero.

These are the default limits, you are free (and actually invited) to
change them. If you look in the default configuration file, you'll see
that all "set" statements have been commented out. The reason is that
we cannot guess how each individual motherboard is wired. You can
uncomment them, then run "sensors -s" (as root) to program the chip
with the new limits. If your motherboard is wired differently, you will
have to adjust some of the limit values.

I just remembered that I do have a dedicated configuration file for
this motherboard:

http://khali.linux-fr.org/devel/lm-sensors/sensors-Gigabyte-M55plus-3SG.conf

It should save you most of the tweaking work. Note that this
configuration file disables temp3, but you say it reports sensible
values for you, so you will want to delete this line. If you make
changes to the configuration file, please send the updated version to
me so that I can update my copy.

-- 
Jean Delvare

