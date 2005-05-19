From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [patch] i2c 2.9.1 compile fix
Message-Id: <20050430213243.5e996d2d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200504291721.34111.thomas.jarosch@intra2net.com>
In-Reply-To: <200504291721.34111.thomas.jarosch@intra2net.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

> attached is a patch to fix i2c-algo-bit.c compilation.
> It was lacking the KERNEL_VERSION macro.
> 
> Please CC: comments.

Great catch. For some reason it wasn't blocking the compilation for me,
nor anyone else I guess, or we would have heard of it before - but that
was still bad.

I opted for a different fix, dropping the conditional altogether. This
branch of i2c is meant for Linux 2.4 only, so there's no point in
keeping Linux 2.5+ compatibility code in there.

Thanks the report.
-- 
Jean Delvare
