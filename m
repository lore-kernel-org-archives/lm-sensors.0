From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 10 Jan 2008 00:30:27 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] : hwmon - new chip driver for TI
Message-Id: <20080109163027.56fbb394.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <477D50CC.6020504@linuxrealtime.co.uk>
	<20080104073439.GA22033@toshiba-lt>
In-Reply-To: <20080104073439.GA22033@toshiba-lt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Hardy <steve@linuxrealtime.co.uk>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, khali@linux-fr.org, "Mark M. Hoffman" <mhoffman@lightlink.com>

On Fri, 4 Jan 2008 07:34:39 +0000
Steve Hardy <steve@linuxrealtime.co.uk> wrote:

> Andrew/Jean,
> 
> Sorry for the delay - christmas & getting mutt working delayed my
> revised patch.  Here is an updated patch against 2.6.24-rc6, which
> hopefully addresses all comments made so far.
> 
> Jean - you mentioned declaring the devices as platform data & writing
> a new-style I2C driver - are there any examples of this approach I can
> refer to?  I simply copied what is/was currently in-tree for this
> driver, which seems to work well with the hardware I'm working with (a
> COTS CPCI carrier)
> 
> Since I've dropped Thunderbird I hope the patch mangling will be
> fixed.
> 
> Any problem, please let me know.
>

The above doesn't constitute a usable changelog.  I guess we don't really
need anything in this patch but please do remember that the changelog text
should be included in each new rev of a patch.

> 
> Signed-Off by Steve Hardy <steve@linuxrealtime.co.uk>

"Signed-off-by:", please.

 Documentation/hwmon/ads7828 |   38 ++++
 drivers/hwmon/Kconfig       |   10 +
 drivers/hwmon/Makefile      |    1 
 drivers/hwmon/ads7828.c     |  296 ++++++++++++++++++++++++++++++++++
 4 files changed, 345 insertions(+)

I assumed that this is to be merged via Mark's git-hwmon tree.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
