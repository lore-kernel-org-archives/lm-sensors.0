From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: ref 1501
Message-Id: <20040213211448.2d571037.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <19808.1073178613@www49.gmx.net>
In-Reply-To: <19808.1073178613@www49.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> this is sensors-detect output but also the output that sensors gave me
> in the kernel 2.4.22, i know the modules are i2c-ali1535 and w83781d
> cause i've used it before in there, what i see strange is that in the
> kernel 2.4.22 the algorithm says Non-i2c SMBus adapter and in the 2.6
> Algorithm unavailable, maybe that's not the problem and i'm doing
> something wrong About ticket 839, i know the error i'm using one
> a7a266, the only diference is the chipset revision, lspci says the
> chip is M1533 but it's M1535D+ so the error is the old one

Sorry for the delay.

If you still don't have it working, please upgrade to Linux 2.6.2,
lm_sensors 2.8.4, enable all debugging options when configuring the
Linux i2c drivers, retry and report.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
