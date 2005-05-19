From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: New Chip Dvelopment
Message-Id: <4064DAFA.7060302@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040324215754.63075.qmail@web41211.mail.yahoo.com>
In-Reply-To: <20040324215754.63075.qmail@web41211.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I would start from the pcf8574.c code and copy in fan code from some other driver.
Do you plan on submitting the code to us?
Do you want an entry on our new drivers page?

See doc/developers/new-drivers for more info.

mds



zebo25@yahoo.com wrote:
> It looks like I am going to be developing a sensors
> chip driver for the Micrel 74 Serial I/O Expander
> & Fan Controller. The chip is somewhat related to
> the Phillips PCA9555 (one of your new chip
> developments).
> 
> As far as I could tell, I didn't see a new chip
> development project for this chip type.
> 
> I already use other sensors project code so I am
> pretty familiar with what I need to do, but I want
> to make sure. Is there anything I need to do, be
> familiar with, provide? 
> 
> Thanks
> 
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Finance Tax Center - File online. File on time.
> http://taxes.yahoo.com/filing.html
> 
> 
