From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: lm87 ported to Linux 2.6
Message-Id: <20040831225008.54d3bc94.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040823215206.0609831f.khali@linux-fr.org>
In-Reply-To: <20040823215206.0609831f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> Thanks a lot to Mark M. Hoffman for his i2c-stub test bus driver,
> which help me notice and fix that problem. An updated patch is
> available here:
> 
> http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.9-rc1-i2c-lm87-beta1.diff

I made further testing using i2c-stub and found that everything was
working fine but negative temperatures. I updated the patch to fix that
and also gave credit to Jeff. New patch is here:

http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.9-rc1-i2c-lm87-beta2.diff

I also updated the sensors.conf.eg file in CVS.

I would still appreciate some testing on real LM87 chips (and dumps
thereof as well).

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
