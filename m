From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: linux-2.6.7 parallel port adapter
Message-Id: <20050510202650.57935773.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <427B6E12.9000008@inf.ed.ac.uk>
In-Reply-To: <427B6E12.9000008@inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nils,

> > Except that i2c-parport-light didn't exist before 2.6.2-rc1. Which
> > driver are you using under 2.4.26?
>
> the philips parallel port adapter (i2c-philips-par.o)
> CONFIG_I2C_PHILIPSPAR=y
> 
> in 2.6.7 i assumed it would be
> CONFIG_I2C_PARPORT=y
> ?

It is. i2c-philips-par (2.4) is equivalent to i2c-parport with type=0
(2.6). It is *not* equivalent to i2c-parport-light. So I still believe
that i2c-parport-light is meant for x86 only by design, and this
explains the problem kernel panic you observed. Most probably Kconfig
should be fixed to limit i2c-parport-light to x86 and friends.

-- 
Jean Delvare
