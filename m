From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c/kernel i2c.h i2c-velleman.c i2c-rpx.c i2c-proc.c i2c-pport.c  i2c-philips-par.c i2c-pcf-epp.c i2
Message-Id: <3E23647B.2070805@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

uncommenting 8xx and rpx in kernel/Module.mk causes compile errors for me
(non-8xx kernel)

Also, for my info, why is 2.4.9 and not 2.4.0 the minimum kernel now?


author@mordac.netroedge.com wrote:
> Update of /home/cvs/i2c/kernel
> In directory mordac.netroedge.com:/tmp/cvs-serv26879/kernel
> 
> Modified Files:
> 	i2c.h i2c-velleman.c i2c-rpx.c i2c-proc.c i2c-pport.c 
> 	i2c-philips-par.c i2c-pcf-epp.c i2c-frodo.c i2c-elv.c 
> 	i2c-elektor.c i2c-dev.h i2c-dev.c i2c-core.c i2c-algo-pcf.c 
> 	i2c-algo-ibm_ocp.c i2c-algo-biths.c i2c-algo-bit.c 
> 	i2c-algo-8xx.c i2c-adap-ibm_ocp.c Module.mk 
> Log Message:
> (Ky?sti)
>    Check in changes from 2.5.53 to 2.5.54).
>    Apply respective changes to other drivers in CVS.
> 
