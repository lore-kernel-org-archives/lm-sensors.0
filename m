From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Nov 2006 21:51:17 +0000
Subject: [lm-sensors] Driver for Fintech F75375S?
Message-Id: <20061104225117.e017ab9d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060810174246.GB8333@deprecation.cyrius.com>
In-Reply-To: <20060810174246.GB8333@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 4 Nov 2006 17:07:15 +0200, Riku Voipio wrote:
> On Sat, Nov 04, 2006 at 03:48:54PM +0100, Martin Michlmayr wrote:
> > Jean,
> > 
> > * Jean Delvare <khali at linux-fr.org> [2006-11-04 15:23]:
> > > That's still interesting that they provided a Linux driver. If it is
> > > publicly available, can you please point me to it?
>  
> > It's included in their GPL source tar ball which can be found at
> > http://www.thecus.com/dl.php  The current URL seems to be
> > http://www.thecus.com/Downloads/n2100_2.1.01_GPL.tar.bz2

A 120 MB archive, took me 2 hours to fetch. Not exactly convenient.

> and a direct link to the file:
> 
> http://piipiip.net/~nchip/All6500_2.0.00/build/linux/drivers/i2c/chips/thecus_rtc.c
> 
> functions starting with "f75373_" are related to the fintek chip.
> Notice that they don't implement a hwmon device, but rather their own
> /proc/thecus_io interface.

Indeed, it might be GPL source code, but it's proprietary code in the
sense it doesn't follow any standard. A single driver for three
distinct I2C devices isn't exactly smart, and many values appear to be
hardcoded for the exact Thecus N2100 hardware, so the code is hardly
reusable.

I admit I don't understand companies who base their products on Linux,
and play fair by contributing their code back to the comunity, but in a
way that it'll never get merged. It means they spent efforts inventing
interfaces when standard ones existed. It also means they have to
maintain their contribution by themselves forever, and that their
contribution won't integrate well with the rest of the Linux software.
So in the end the user doesn't benefit at all.

-- 
Jean Delvare

