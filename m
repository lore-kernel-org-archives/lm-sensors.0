From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Sep 2005 20:10:06 +0000
Subject: [lm-sensors] [PATCH] synchronize i2c_msg structure in i2c and
Message-Id: <20050927200927.176367d9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509271754.AA01322@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509271754.AA01322@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Konbanwa Hideki,

> Without this, I2C_RDWR ioctl does not work correctly.
> 
> Index: kernel/include/i2c-dev.h
> =================================> RCS file: /home/cvs/lm_sensors2/kernel/include/i2c-dev.h,v
> retrieving revision 1.9
> diff -u -r1.9 i2c-dev.h
> --- kernel/include/i2c-dev.h	26 Sep 2005 17:35:48 -0000	1.9
> +++ kernel/include/i2c-dev.h	27 Sep 2005 17:45:03 -0000
> @@ -45,8 +45,6 @@
>  #define I2C_M_NO_RD_ACK		0x0800
>  	short len;		/* msg length				*/
>  	char *buf;		/* pointer to msg data			*/
> -	int err;
> -	short done;
>  };

My bad. I dropped these members from i2c_msg in i2c.h a few months ago
to solve compatibility problems between i2c CVS and Linux 2.4, but
completely forgot to change i2c-dev.h in a similar way. Thanks for
pointing this out, I've applied your patch.

Arigato,
-- 
Jean Delvare
