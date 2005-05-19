From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: I2C_CLASS_HWMON vs. I2C_CLASS_ALL for i2c adapter driver
Message-Id: <20050329225451.7f06fec5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4249B8C9.9030408@mvista.com>
In-Reply-To: <4249B8C9.9030408@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> Chris Elston pointed out an oversight that I made in 
> drivers/i2c/busses/i2c-mv64xxx.c.  I didn't set the adapter owner and 
> class fields.  (The ctlr is a basic i2c ctlr residing on the 
> hostbridge/Northbridge.)
> 
> My question is, should I set the class field to I2C_CLASS_HWMON or 
> I2C_CLASS_ALL?  Theoretically [AFAIK], this ctlr can talk to any type
> of  i2c client so I2C_CLASS_ALL seems like the right one to use. 
> However,  no other driver uses it which worries me.

In theory, almost any client could be connected to almost any adapter.
The class field was added to express the known, existing combinations,
not the theoretical ones. Use I2C_CLASS_HWMON. If you now you need
another class, OR it. No adapter should ever use I2C_CLASS_ALL (in fact
I see very little reason why it was defined in the first place).

Basically, the idea is to prevent hardware monitoring chip drivers from
accessing the video i2c busses.

Hope that helps,
-- 
Jean Delvare
