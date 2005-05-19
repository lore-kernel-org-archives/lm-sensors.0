From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: [PATCH] i2c/CHANGES
Message-Id: <20040523163554.241c2d02.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405231420.AA00975@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200405231420.AA00975@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -  i2c-core.c: Fail to compile is kernel lacks sysctl support
> +  i2c-proc.c: Fail to compile is kernel lacks sysctl support

Oops, correct. Nice catching!

Applied, thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
