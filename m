From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Jan 2011 19:18:07 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (lm93) Add support for LM94
Message-Id: <20110118201807.0d934533@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1295375190-3477-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1295375190-3477-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 18 Jan 2011 10:26:30 -0800, Guenter Roeck wrote:
> This patch adds basic support for LM94 to the LM93 driver. LM94 specific
> sensors and features are not supported.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> v2: Add additional MFR_ID value 0x7a for LM94
> 
>  Documentation/hwmon/lm93 |    7 +++++++
>  drivers/hwmon/lm93.c     |   21 +++++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)

Looks good,

Acked-by: Jean Delvare <khali@linux-fr.org>

though a mention of the LM94 in drivers/hwmon/Kconfig would be nice to
add?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
