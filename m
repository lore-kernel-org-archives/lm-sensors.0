From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c/kernel i2c.h i2c-velleman.c i2c-rpx.c i2c-proc.c i2c-pport.c  i2c-philips-par.c i2c-pcf-epp.c i2
Message-Id: <3E2365EB.6060706@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E23647B.2070805@paradyne.com>
In-Reply-To: <3E23647B.2070805@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

kernel/i2c-pcf-epp.c:216: warning: initialization from incompatible pointer typekernel/i2c-pcf-epp.c:218: warning: initialization makes integer from pointer without a cast
kernel/i2c-pcf-epp.c:219: warning: initialization makes integer from pointer without a cast
kernel/i2c-pcf-epp.c:219: initializer element is not computable at load time
kernel/i2c-pcf-epp.c:219: (near initialization for `pcf_epp_ops.name[2]')
kernel/i2c-pcf-epp.c:220: `pcf_epp_inc_use' undeclared here (not in a function)
kernel/i2c-pcf-epp.c:220: initializer element is not constant
kernel/i2c-pcf-epp.c:220: (near initialization for `pcf_epp_ops.name[3]')
kernel/i2c-pcf-epp.c:221: `pcf_epp_dec_use' undeclared here (not in a function)
kernel/i2c-pcf-epp.c:221: initializer element is not constant
kernel/i2c-pcf-epp.c:221: (near initialization for `pcf_epp_ops.name[4]')
kernel/i2c-pcf-epp.c:222: warning: initialization makes integer from pointer without a cast
kernel/i2c-pcf-epp.c:222: initializer element is not computable at load time
kernel/i2c-pcf-epp.c:222: (near initialization for `pcf_epp_ops.name[5]')
kernel/i2c-pcf-epp.c:223: warning: initialization makes integer from pointer without a cast
kernel/i2c-pcf-epp.c:223: initializer element is not computable at load time
kernel/i2c-pcf-epp.c:223: (near initialization for `pcf_epp_ops.name[6]')
make: *** [kernel/i2c-pcf-epp.o] Error 1


Also, should be do C99 initializers before the branch?

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
