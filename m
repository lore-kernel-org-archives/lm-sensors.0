From: willy@w.ods.org (Willy Tarreau)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: [PATCH 2.4] Trivial changes to I2C stuff
Message-Id: <20031122154720.GA18110@alpha.home.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031122161510.7d5b4d20.khali@linux-fr.org>
In-Reply-To: <20031122161510.7d5b4d20.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Marcelo Tosatti <marcelo@cyclades.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, Greg KH <greg@kroah.com>

Hi !

On Sat, Nov 22, 2003 at 04:15:10PM +0100, Jean Delvare wrote:
> The changes are only white space and comment changes, and line reordering.

<...>

> @@ -199,7 +199,7 @@
>  #define I2C_HW_SMBUS_AMD756	0x05
>  #define I2C_HW_SMBUS_SIS5595	0x06
>  #define I2C_HW_SMBUS_ALI1535	0x07
> -#define I2C_HW_SMBUS_W9968CF	0x08
> +#define I2C_HW_SMBUS_W9968CF	0x0d

Is this one intentionnal or just a typo ?

Cheers,
Willy
