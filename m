From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 24 Sep 2005 19:07:22 +0000
Subject: [lm-sensors] [PATCH] fix emulated block write
Message-Id: <20050924190819.773d2766.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509221817.AA01314@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509221817.AA01314@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Konbanwa Hideki,

> Excessive byte is written to the buffer.
> 
> Index: kernel/i2c-core.c
> =================================> RCS file: /home/cvs/i2c/kernel/i2c-core.c,v
> retrieving revision 1.110
> diff -u -r1.110 i2c-core.c
> --- kernel/i2c-core.c	12 Aug 2005 20:39:21 -0000	1.110
> +++ kernel/i2c-core.c	22 Sep 2005 18:02:47 -0000
> @@ -1292,7 +1292,7 @@
>  			}
>  			if(size = I2C_SMBUS_BLOCK_DATA_PEC)
>  				(msg[0].len)++;
> -			for (i = 1; i <= msg[0].len; i++)
> +			for (i = 1; i < msg[0].len; i++)
>  				msgbuf0[i] = data->block[i-1];
>  		}
>  		break;
> @@ -1315,7 +1315,7 @@
>  				"invalid block write size (%d)\n", data->block[0]);
>  			return -1;
>  		}
> -		for (i = 1; i <= msg[0].len; i++)
> +		for (i = 1; i < msg[0].len; i++)
>  			msgbuf0[i] = data->block[i-1];
>  		
>  		/* set recv message */

It took me some time to figure it out, but once again you are right,
our code was broken. Will fix in CVS and Linux 2.6.

Arigato,
-- 
Jean Delvare
