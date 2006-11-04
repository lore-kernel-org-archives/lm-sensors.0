From: riku.voipio@iki.fi (Riku Voipio)
Date: Sat, 04 Nov 2006 15:07:15 +0000
Subject: [lm-sensors] Driver for Fintech F75375S?
Message-Id: <20061104150715.GA28792@kos.to>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060810174246.GB8333@deprecation.cyrius.com>
In-Reply-To: <20060810174246.GB8333@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 04, 2006 at 03:48:54PM +0100, Martin Michlmayr wrote:
> Jean,
> 
> * Jean Delvare <khali at linux-fr.org> [2006-11-04 15:23]:
> > That's still interesting that they provided a Linux driver. If it is
> > publicly available, can you please point me to it?
 
> It's included in their GPL source tar ball which can be found at
> http://www.thecus.com/dl.php  The current URL seems to be
> http://www.thecus.com/Downloads/n2100_2.1.01_GPL.tar.bz2

and a direct link to the file:

http://piipiip.net/~nchip/All6500_2.0.00/build/linux/drivers/i2c/chips/thecus_rtc.c

functions starting with "f75373_" are related to the fintek chip.
Notice that they don't implement a hwmon device, but rather their own
/proc/thecus_io interface.


