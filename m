From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 Mar 2011 13:05:33 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads1015) Make gain and datarate
Message-Id: <20110321140533.1e5faa76@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110318220240.399ade64@endymion.delvare>
	<1300703865-23939-1-git-send-email-eibach@gdsys.de>
In-Reply-To: <1300703865-23939-1-git-send-email-eibach@gdsys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dirk Eibach <eibach@gdsys.de>
Cc: lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, rdunlap@xenotime.net, devicetree-discuss@lists.ozlabs.org, w.sang@pengutronix.de

On Mon, 21 Mar 2011 11:37:45 +0100, Dirk Eibach wrote:
> Configuration for ads1015 gain and datarate is possible via
> devicetree or platform data.
> 
> This is a followup patch to previous ads1015 patches on Jean Delvares
> tree.
> 
> Changes since v1:
> - replaced exported_channels bitmask with an enable entry per channel
> - improved platform data example in Documentation
> - improved patch description
> 
> Changes since v2:
> - fixed spelling and whitespace in Documentation
> - marked default data_rate
> - replaced FS by full scale
> - removed structure definition from Documentation
> - used DIV_ROUND_UP()
> - improved comments
> - improved waiting for conversion
> - moved devicetree stuff to ads1015_get_channels_config_of()
> - renamed ads1015_get_exported_channels() to ads1015_get_channels_config()
> - renamed ADS1015_CONFIG_CHANNELS to ADS1015_CHANNELS
> - fixed some style inconsistencies
> 
> Signed-off-by: Dirk Eibach <eibach@gdsys.de>
> ---
>  .../devicetree/bindings/hwmon/ads1015.txt          |   88 +++++++++---
>  Documentation/hwmon/ads1015                        |   49 ++++---
>  drivers/hwmon/ads1015.c                            |  151 ++++++++++++++------
>  include/linux/i2c/ads1015.h                        |   10 ++-
>  4 files changed, 212 insertions(+), 86 deletions(-)

Applied, thanks.

I'll send all my hwmon patches to Linus later today.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
