From: jeff@jdfiles.org (Jeff Sacksteder)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: i2c for Alpha
Message-Id: <200310261722.09474.jeff@jdfiles.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have located a block diagram for my server. It appears that the I2C bus 
hangs off the XBUS(?), whatever that is. Perhaps this is why I can't detect 
anything?

From a description of the Alpha 2100- I don't know if this is the same as 
mine. 

"Electrical and architectural restrictions prohibited the
interrupt control logic from being directly accessed by either
the system bus or the PCI bus. As a result, the interrupt control
logic is physically located on a utility bus called the XBUS. The
XBUS is an 8-bit slave ISA bus placed nearby the PCI-to-EISA
bridge chips."

The two pages from the docs are at 

http://www.jdfiles.org/a.pdf and
http://www.jdfiles.org/b.pdf

