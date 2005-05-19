From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: lm87 ported to Linux 2.6
Message-Id: <20040829100110.57ed7c70.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040823215206.0609831f.khali@linux-fr.org>
In-Reply-To: <20040823215206.0609831f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> The patch is available here:
> http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.8.1-mm4-i2c-lm87-alpha1.diff
> It should apply and work on linux-2.6.8.1-mm1, -mm2, -mm3 and -mm4
> kernels.
> (...)
> This first patch is untested beyond compilation, as I don't own a LM87
> myself.

And actually it'll deadlock your system if you give it a try. Shame on
me.

Thanks a lot to Mark M. Hoffman for his i2c-stub test bus driver, which
help me notice and fix that problem. An updated patch is available here:

http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.9-rc1-i2c-lm87-beta1.diff

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
