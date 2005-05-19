From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Ticket #: 1737 sensors-detect output
Message-Id: <20040927214852.26078d55.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1096310310.11070.4.camel@drevil.aslab.com>
In-Reply-To: <1096310310.11070.4.camel@drevil.aslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi,
> 
> Here is the output of sensors-detect for the ASUS NCCH-DL motherboard.
> 
> This is with the CVS snapshot of lmsensors and i2c from 9/27/2004.

OK, I see two interesting things here.

First, you have a monitoring on the I2C bus but sensors-detect fails to
detect it. Addresses 0x2f, 0x48 and 0x49 are typical for hardware
monitoring chips so this doesn't leave much room for doubt.

Please provide the output of the following commands so that we can find
out what chip this is:
  i2cdump 0 0x2f
  i2cdump 0 0x48
  i2cdump 0 0x49
(This assumes that your i2c-i801 bus has number 0, which seems to be the
case.)

Second, there is some kind of doubt or conflict for what (ISA) chip is
at address 0x290. Sensors-detect hesitate between Winbond W83627THF and
ITE 87xx. One possibility is that the IT87xx is a misdetection. Another
possibility is that your BIOS is misconfigured, you have both chips and
they are mapped to the same address. I hope not...

Please provide the output of the following command:
  isadump 0x295 0x296

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
