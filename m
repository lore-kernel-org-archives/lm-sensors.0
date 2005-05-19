From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C busses documentation update
Message-Id: <20050306091228.77495cf7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0503042257570.25688@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0503042257570.25688@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Patch contains promised documentation update for i2c bus drivers.
> I would like to thank Jean Delvare and Aurelien Jarno for their
> comments.

Doesn't apply for me. The patch assumes that i2c/i2c-parport was moved
to i2c/busses/i2c-parport before, but this isn't the case neither in
linux-2.6.11-mm1 nor linux-2.6.11-bk1.

(Alright with me otherwise.)

-- 
Jean Delvare
