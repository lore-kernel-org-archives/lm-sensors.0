From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 21 Jun 2005 21:07:05 +0000
Subject: [lm-sensors] I2C 2.9.1 driver support for High Speed I2C (draft
Message-Id: <20050621210640.50be6e27.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <520AB2AD990DC04082102F77CA1726385B8994@dlee03.ent.ti.com>
In-Reply-To: <520AB2AD990DC04082102F77CA1726385B8994@dlee03.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nishanth,

> In continuance of the discussion about HSI2C support
> (http://archives.andrew.net.au/lm-sensors/msg31155.html ), I would
> like to present for discussion a strategy to incorporate HSI2C support
> to the current I2C driver (ver 2.9.1). 
> (...)
> 5.       Should be simple enough to carry forward into various kernel
> versions.

No. Whatever you plan, this must be based on the Linux 2.6 i2c
subsystem. i2c-CVS (for Linux 2.4) is in maintenance state, we are not
adding any new feature in there.

-- 
Jean Delvare
