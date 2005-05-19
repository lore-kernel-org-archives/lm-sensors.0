From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH] s3c2410 i2c build fix
Message-Id: <20041031215330.06d3b1e1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041031154945.GA29973@home.fluff.org>
In-Reply-To: <20041031154945.GA29973@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> the attach patch seems to have gotten lost somewhere
> down the line, it fixes an include error, as well as
> the removal of the I2C_ALGO_S3C2410 which seems to have
> crept back in. 

I don't think it was lost, Greg has it in its bk-i2c tree, has can been
seen here:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/broken-out/bk-i2c.patch

-- 
Jean Delvare
http://khali.linux-fr.org/
