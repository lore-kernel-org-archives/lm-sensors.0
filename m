From: ben-i2c@fluff.org (Ben Dooks)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH] s3c2410 i2c build fix
Message-Id: <20041101192505.GC13105@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041031154945.GA29973@home.fluff.org>
In-Reply-To: <20041031154945.GA29973@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Oct 31, 2004 at 09:53:30PM +0100, Jean Delvare wrote:
> Hi Ben,
> 
> > the attach patch seems to have gotten lost somewhere
> > down the line, it fixes an include error, as well as
> > the removal of the I2C_ALGO_S3C2410 which seems to have
> > crept back in. 
> 
> I don't think it was lost, Greg has it in its bk-i2c tree, has can been
> seen here:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/broken-out/bk-i2c.patch

thanks, I didn't think to look in the mm patches.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
