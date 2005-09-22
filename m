From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Sep 2005 22:53:14 +0000
Subject: [lm-sensors] [PATCH] I2C Documentation fix
Message-Id: <20050922225337.6ca4495b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509141420.AA01311@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509141420.AA01311@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Konbanwa Hideki,

> --- doc/functionality	28 Jul 2005 17:04:23 -0000	1.3
> +++ doc/functionality	14 Sep 2005 14:19:25 -0000
> (...)
> -  I2C_FUNC_PROTOCOL_MANGLING      Knows about the I2C_M_REV_DIR_ADDR,
> -                                  I2C_M_REV_DIR_ADDR and I2C_M_REV_DIR_NOSTART
> +  I2C_FUNC_PROTOCOL_MANGLING      Knows about the I2C_M_IGNORE_NAK,
> +                                  I2C_M_REV_DIR_ADDR and I2C_M_NOSTART

Good catch! Thanks for reporting. I just committed the fix to i2c CVS,
and I'll port it to Linux 2.6 too.

Arigato,
-- 
Jean Delvare
