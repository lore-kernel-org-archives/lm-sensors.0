From: bunk@stusta.de (Adrian Bunk)
Date: Wed, 07 Dec 2005 18:12:34 +0000
Subject: [lm-sensors] [PATCH 1/3] i386: CS5535 chip support - cpu
Message-Id: <20051207181234.GF31922@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512070931k607cd7a9g404d131ded8c014b@mail.gmail.com>
In-Reply-To: <808c8e9d0512070931k607cd7a9g404d131ded8c014b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Gardner <gardner.ben@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 11:31:09AM -0600, Ben Gardner wrote:
>...
> --- linux-2.6.14.orig/arch/i386/kernel/Makefile
> +++ linux-2.6.14/arch/i386/kernel/Makefile
> @@ -42,6 +42,14 @@ EXTRA_AFLAGS   := -traditional
>  
>  obj-$(CONFIG_SCx200)		+= scx200.o
>  
> +obj-$(CONFIG_CS5535)		+= cs5535.o
> +ifeq ($(CONFIG_CS5535_SMB), y)
> +EXTRA_CFLAGS += -DCS5535_SMB
> +endif
> +ifeq ($(CONFIG_CS5535_UART2), y)
> +EXTRA_CFLAGS += -DCS5535_UART2
> +endif
>...

Please use CONFIG_CS5535_{SMB,UART2} in cs5535.c instead of setting 
EXTRA_CFLAGS.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


