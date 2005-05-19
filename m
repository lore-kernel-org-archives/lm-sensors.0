From: ben-i2c@fluff.org (Ben Dooks)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: S3C2410 I2C driver
Message-Id: <20041010220550.GA6902@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041008130842.GK12218@home.fluff.org>
In-Reply-To: <20041008130842.GK12218@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 08, 2004 at 02:08:42PM +0100, Ben Dooks wrote:
> I have the first version of my Samsung S3C2410 I2C bus driver
> available at http://www.fluff.org/ben/linux-26/i2c-s3cdrv1.patch
> 
> Tested against 2.6.9-rc3.
> 
> I would be grateful of any comment, as I would like to get this
> support into the 2.6 kernel soon.

Is the correct approach to getting this patch applied to email
linux-kernel@vger.kerne.org and cc greg@kroah.com and 
phil@netroedge.com

I also need an allocation for I2C_ALGO_S3C2410

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
