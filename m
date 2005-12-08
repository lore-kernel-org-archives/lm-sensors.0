From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 08 Dec 2005 20:13:40 +0000
Subject: [lm-sensors] lm75 on a ppc405
Message-Id: <20051208211340.44ae02fe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051207210919.GF3085@bork.org>
In-Reply-To: <20051207210919.GF3085@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,

> > The correct approach is to add I2C_CLASS_HWMON to i2c-ibm_iic's class
> > flags. I'd take a patch doing that.
> 
> Excellent.  Tested against 2.6.11.9, and compile tested with Linus'
> latest git tree.

Applied, thanks.

-- 
Jean Delvare

