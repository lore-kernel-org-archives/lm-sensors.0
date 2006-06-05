From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 05 Jun 2006 07:57:13 +0000
Subject: [lm-sensors] an error when compile lm_sensors2
Message-Id: <20060605095713.9ab529ea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4483D5CE.40801@winbond.com>
In-Reply-To: <4483D5CE.40801@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> When i compile lm_sensors2 on kernel 2.4 i met a error
> 
> kernel/busses/i2c-viapro.c: In function `vt596_probe':
> kernel/busses/i2c-viapro.c:398: `PCI_DEVICE_ID_VIA_8237' undeclared (first use in this function)
> kernel/busses/i2c-viapro.c:398: (Each undeclared identifier is reported only once
> kernel/busses/i2c-viapro.c:398: for each function it appears in.)
> make: *** [kernel/busses/i2c-viapro.o] Error 1
> 
> I just copy the definition of PCI_DEVICE_ID_VIA_8237 above function vt596_probe to skip this error.
> did i missing some configure?

Good catch. We know that old kernels don't have these defines and we
redefine the values ourselves when needed, however improvements I made
to the i2c-viapro driver some times ago make use of the values _before_
they are defined. I've moved the defines at the top of the source file,
this should fix the issue.

Thanks for reporting!

-- 
Jean Delvare

