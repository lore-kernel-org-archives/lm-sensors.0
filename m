From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: CVS?
Message-Id: <20040407223645.22cdf96b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440564855E@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440564855E@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Sensors-detect sees it (at address 0x7C) but cannot identify it.
> The documentation calls it "Embedded PCI-X On Board Registers".
> Does that mean anything to anyone?

In case you didn't notice it already, 0x7C isn't a standard address.
It's marked "Reserved for future use" in the SMBus 2.0 specification,
and latest version of i2cdetect and sensors-detect don't even scan it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
