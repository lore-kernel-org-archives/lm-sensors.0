From: henk@god.dyndns.org (henk)
Date: Mon, 24 Oct 2005 10:48:16 +0000
Subject: [lm-sensors] Re: [PATCH 2.6] i2c: Fix incorrect ID uses
Message-Id: <20051024084737.GA21900@god.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051022154830.0b7688ab.khali@linux-fr.org>
In-Reply-To: <20051022154830.0b7688ab.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Oct 22, 2005 at 03:48:30PM +0200, Jean Delvare wrote:
> Hi all,
> 
> I am enqueuing the following patch. Driver authors are invited to Ack
> their respective parts, or voice in if anything doesn't look OK.
> 
> Thanks.
> 
> Fix several incorrect uses and redefinitions of i2c IDs.
> In particular:
> * i2c algorithm IDs are gone;
> * i2c IDs must not be defined outside of i2c-id.h.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> CC: Henk Vddergonet <henk.at.god.dyndns.org>
> CC: Antonino Daplas <adaplas@pol.net>
> CC: Mark McClelland <mark@alpha.dyndns.org>
> CC: Ladislav Michl <ladis@linux-mips.org>
> CC: Mikael Nousiainen <tmnousia@cc.hut.fi>
> 
> ---
>  drivers/i2c/busses/i2c-prosavage.c |    5 -----
> +++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-prosavage.c	2005-10-22 14:23:00.000000000 +0200
> @@ -83,11 +83,6 @@
>  /*
>   * i2c configuration
>   */
> -#ifndef I2C_HW_B_S3VIA
> -#define I2C_HW_B_S3VIA	0x18	/* S3VIA ProSavage adapter		*/
> -#endif
> -
> -/* delays */
>  #define CYCLE_DELAY	10
>  #define TIMEOUT		(HZ / 2)
>  
Signed-off-by: Henk Vergonet <henk.at.god.dyndns.org>

Good to see some ifdefs removed.

regards,

Henk
