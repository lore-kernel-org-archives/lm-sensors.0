From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: S3C2410 I2C driver
Message-Id: <PbTNzqVC.1097565370.3649820.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041008130842.GK12218@home.fluff.org>
In-Reply-To: <20041008130842.GK12218@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On 2003-10-10, Ben Dooks wrote:
> I also need an allocation for I2C_ALGO_S3C2410

On 2004-10-12, Greg KH wrote:
> Hm, I thought we didn't need ids allocated anymore.  Doesn't your driver
> work just fine without it?

This is certainly true for i2c chip drivers. I am not certain when it
comes to adapters and algorithms though. I remember seeing checks on
these in some code (maybe not from the main 2.6 tree though). It is
probably worth verifying, especially if we intend to get rid of this
struct member at some later time.

Thanks,
Jean
