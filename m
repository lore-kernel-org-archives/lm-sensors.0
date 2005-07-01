From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 01 Jul 2005 16:41:46 +0000
Subject: [lm-sensors] Re: [2.6 patch] SENSORS_ATXP1 must select I2C_SENSOR
Message-Id: <20050701164108.0bc4e364.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050630234709.1ad1512a@DreaM.darnet>
	<20050630221727.GE27478@stusta.de>
In-Reply-To: <20050630221727.GE27478@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: Sebastian Pigulak <dreamin@interia.pl>, linux-kernel@vger.kernel.org, Sebastian Witt <se.witt@gmx.net>, Greg KH <greg@kroah.com>, lm-sensors@lm-sensors.org

Hi Adrian,

> > I've tried patching linux-2.6.13-RC1 with patch-2.6.13-rc1-git2 and
> > building atxp1(it allows Vcore voltage changing) into the kernel.
> > Unfortunately, the kernel compilation stops with:
> > 
> > LD      init/built-in.o
> > LD      vmlinux
> > drivers/built-in.o(.text+0x92298): In function `atxp1_detect':
> > : undefined reference to `i2c_which_vrm'
> > drivers/built-in.o(.text+0x921ae): In function
> > `atxp1_attach_adapter': : undefined reference to `i2c_detect'
> > make: *** [vmlinux] B??d 1
> > => ERROR: Build Failed.  Aborting... 
> > 
> > Could someone have a look at the module and possibly fix it up?
> 
> The patch below should fix it.

Good catch. However, this fix will conflict with a larger patch I am
working on (moving hardware monitoring drivers to a different directory
[1]), so I applied a different fix on top of my own stack, and will send
all this stuff to Greg as soon as possible.

[1] http://lkml.org/lkml/2005/6/27/302

Thanks,
-- 
Jean Delvare
