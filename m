From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 24 Apr 2006 06:26:34 +0000
Subject: [lm-sensors] asb100 not working in kernel 2.6.16
Message-Id: <20060424082634.8d58364e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44496569.6030100@superig.com.br>
In-Reply-To: <44496569.6030100@superig.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, Paulo,

Mark M. Hoffman wrote:
> So, two possibilities: 
> 
> 1) We can't depend on the link order, so the quirks need to be fixed.
> 
> 2) We *can* depend on link order, but FC4 breaks it somehow.

Since 2.6.17-rc1, there is a new kernel option available for arch
x86_64:

config REORDER
	bool "Function reordering"
	default n
	help
         This option enables the toolchain to reorder functions for a more 
         optimal TLB usage. If you have pretty much any version of binutils, 
	 this can increase your kernel build time by roughly one minute.

This option does the following (in arch/x86_64/Makefile)
cflags-$(CONFIG_REORDER) += -ffunction-sections

I understand that you are investigating an issue on 2.6.16, arch i386,
so this doesn't apply directly, but maybe the latest FC4 kernels use a
similar compilation flag for arch i386?

-- 
Jean Delvare

