From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 Mar 2012 17:36:28 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (jc42) Add support for AT30TS00, TS3000GB2, TSE2002GB2, and MCP98
Message-Id: <20120307183628.0499efea@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331140926-16412-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331140926-16412-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed,  7 Mar 2012 09:22:06 -0800, Guenter Roeck wrote:
> Also update IDT datasheet locations.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Only use two prefixes for TSE2002xx, TS3000xx.
> 
>  Documentation/hwmon/jc42 |   20 ++++++++++++++------
>  drivers/hwmon/Kconfig    |    6 +++---
>  drivers/hwmon/jc42.c     |   20 ++++++++++++++++++--
>  3 files changed, 35 insertions(+), 11 deletions(-)
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
