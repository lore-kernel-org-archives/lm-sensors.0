From: mgreer@mvista.com (Mark A. Greer)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: I2C_CLASS_HWMON vs. I2C_CLASS_ALL for i2c adapter driver
Message-Id: <4249B8C9.9030408@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Chris Elston pointed out an oversight that I made in 
drivers/i2c/busses/i2c-mv64xxx.c.  I didn't set the adapter owner and 
class fields.  (The ctlr is a basic i2c ctlr residing on the 
hostbridge/Northbridge.)

My question is, should I set the class field to I2C_CLASS_HWMON or 
I2C_CLASS_ALL?  Theoretically [AFAIK], this ctlr can talk to any type of 
i2c client so I2C_CLASS_ALL seems like the right one to use.  However, 
no other driver uses it which worries me.

I searched the FAQ and googled for previous email threads.  There was a 
discussion around a year ago that touched on it but I couldn't find 
anything definitive.

What is the correct one to use?

Thanks,

Mark
