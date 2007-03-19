From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Mon, 19 Mar 2007 12:44:38 +0000
Subject: [lm-sensors] [PATCH 1/3] lm78: No longer use i2c-isa
Message-Id: <45FE85B6.1010608@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070319133231.b2a2a2a0.khali@linux-fr.org>
In-Reply-To: <20070319133231.b2a2a2a0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, all,

I see that you're using a platform here not a isa driver. There was mention of 
maybe mentioning the isa driver structure/class in the future does this mean 
that the plan is to keep using platfrom driver for isa sensor chips?

Regards,

Hans

p.s.

I'm very interested in the work as the PC8374L chip for which I'm planning to 
write a driver can be accessed through both isa and i2c too.

I notice that you always register the i2c driver in case of the lm78, for the 
PC8374L I was thinking about only registering then i2c driver if ISA access is 
disabled. ISA access can be disabled through the superio config registers, in 
this case the i2c address can still be read from those superio config registers 
and one can try to fallback to i2c access. What do you think is best?


