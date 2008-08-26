From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Aug 2008 19:29:07 +0000
Subject: Re: [lm-sensors] [PATCH] lm87: Add support for configuration
Message-Id: <20080826212907.0f3bc210@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080826131030.GZ7908@solarflare.com>
In-Reply-To: <20080826131030.GZ7908@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Aug 2008 14:13:40 +0100, Ben Hutchings wrote:
> The lm87 driver normally assumes that firmware configured the chip
> correctly.  Since this is not always the case, alllow platform code to
> set the channel register value via platform_data.  All other
> configuration registers can be changed after driver initialisation.
> 
> Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
> ---
>  Documentation/hwmon/lm87 |    9 ++++-----
>  drivers/hwmon/lm87.c     |   17 +++++++++++------
>  2 files changed, 15 insertions(+), 11 deletions(-)
> 
> This removes the line to override config in case platform_data is set.
> (This time with a Signed-off-by!)

Excellent. Thanks for the patch. All 3 lm87 patches are now in my
personal tree and I'll push them to Linus for 2.6.28.

I've tested that the lm87 driver still works OK on my test system that
has an LM87 chip.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
