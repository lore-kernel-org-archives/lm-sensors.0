From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 05 Mar 2012 16:25:13 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Add support for ST Microelectronics STTS2002 and STTS3000
Message-Id: <1330964713.23014.328.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120305143200.676d045b@endymion.delvare>
In-Reply-To: <20120305143200.676d045b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-03-05 at 08:32 -0500, Jean Delvare wrote:
> These are fully compatible with Jedec JC 42.4 as far as I can see.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/jc42 |    6 ++++++
>  drivers/hwmon/Kconfig    |    3 ++-
>  drivers/hwmon/jc42.c     |   10 ++++++++++
>  3 files changed, 18 insertions(+), 1 deletion(-)

Thanks, applied.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
