From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Jul 2008 11:26:33 +0000
Subject: Re: [lm-sensors] [PATCH 0/3] lm87 changes for Solarflare NICs [2nd
Message-Id: <20080706132633.5753fcfb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080609110604.GX11300@solarflare.com>
In-Reply-To: <20080609110604.GX11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Mon, 9 Jun 2008 12:06:04 +0100, Ben Hutchings wrote:
> This patch series splits the previous patch into 3 parts.
> 
> Ben.
> 
> Ben Hutchings (3):
>   lm87: Converted into a new-style driver
>   lm87: Add support for configuration through platform_data
>   lm87: Expose sensor values to kernel users
> 
>  drivers/hwmon/lm87.c |  363 +++++++++++++++++++++++++++++++-------------------
>  include/linux/lm87.h |  132 ++++++++++++++++++
>  2 files changed, 357 insertions(+), 138 deletions(-)
>  create mode 100644 include/linux/lm87.h

I have been delaying the review of these patches because I am working
in parallel on a better way to handle both legacy i2c clients and
new-style ones in the same driver. This would basically obsolete your
first patch in this series. I'd rather get this ready in time to be
merged in 2.6.26-rc1, for the lm87 driver and all other hwmon drivers
alike, and then I will have more time to look into the other patches
you sent.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
