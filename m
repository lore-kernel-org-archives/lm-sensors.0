From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: i2c/kernel i2c-algo-8xx.c i2c-algo-bit.c i2c-algo-biths.c
Message-Id: <20041120112023.672d6b33.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> Update of /home/cvs/i2c/kernel
> In directory mordac.netroedge.com:/tmp/cvs-serv9891/kernel
> 
> Modified Files:
> 	i2c-algo-8xx.c i2c-algo-bit.c i2c-algo-biths.c 
> 	i2c-algo-ibm_ocp.c i2c-algo-pcf.c i2c.h 
> Log Message:
> (Khali) Drop owner field of i2c_algorithm. Breaks compatibility with
> Linux 2.4 and was never used anyway.

This is the first step towards return to compatibility with the 2.4
kernels. Second step is i2c_adapter and is already ready on my disk and
tested. Will commit in a few days.

Third step is the client part, not ready yet.

Please test as I commit and object if necessary. Once we're done we have
2.9.0.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
