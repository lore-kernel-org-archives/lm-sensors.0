From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: Missing symbol I2C_ADAP_CLASS_SMBUS
Message-Id: <20040706200820.1537dcd1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407060903.18856.david.goodenough@btconnect.com>
In-Reply-To: <200407060903.18856.david.goodenough@btconnect.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> I am trying to test Jeff Oliver's new LM87 driver for 2.6, and I
> compiled it on a Debian 2.6.7 kernel only to find that the above
> symbol is undefined. Where is it suppose to be defined, do I need a
> later version of LmSensors than is in 2.6.7?

It has simply been renamed to I2C_CLASS_HWMON. Rename the symbol in
Jeff's driver and it should work OK.

-- 
Jean Delvare
http://khali.linux-fr.org/
