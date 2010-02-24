From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Feb 2010 22:03:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Andigilog aSC7621 family
Message-Id: <20100224230303.73ba5848@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <006b01caa1f9$486fb710$d94f2530$@joseph@fairview5.com>
In-Reply-To: <006b01caa1f9$486fb710$d94f2530$@joseph@fairview5.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 23 Feb 2010 15:15:35 -0700, George Joseph wrote:
> 
> Hi Hans.  All items we've discussed have been addressed.
> 
> --------------------
> From: George Joseph <george.joseph@fairview5.com>
> 
> Hwmon driver for Andigilog aSC7621 family monitoring chips
> 
> Signed-off-by: George Joseph <george.joseph@fairview5.com>
> ---
> 
> Patch against 2.6.33-rc8
> 
>   Documentation/hwmon/asc7621 |  296 ++++++++++
>   MAINTAINERS                 |    7
>   drivers/hwmon/Kconfig       |   13
>   drivers/hwmon/Makefile      |    1
>   drivers/hwmon/asc7621.c     | 1255 ++++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 1572 insertions(+)

Patch applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
