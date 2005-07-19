From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Tue, 19 Jul 2005 08:49:47 +0000
Subject: [lm-sensors] Re: drivers/w1/w1_int.c compile error with NET=n
Message-Id: <20050719104931.A22238@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050719000549.GD5031@stusta.de>
In-Reply-To: <20050719000549.GD5031@stusta.de>; from bunk@stusta.de on Tue, Jul 19, 2005 at 02:05:49AM +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 02:05:49AM +0200, Adrian Bunk (bunk@stusta.de) wrote:
> I'm seeing the following compile error in 2.6.13-rc3-mm1 (but it doesn't 
> seem to be specific to -mm) with CONFIG_NET=n:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `w1_alloc_dev':
> w1_int.c:(.text+0x65d81f): undefined reference to `netlink_kernel_create'
> w1_int.c:(.text+0x65d881): undefined reference to `sock_release'
> drivers/built-in.o: In function `w1_free_dev':
> w1_int.c:(.text+0x65d8e9): undefined reference to `sock_release'
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 

Something changed...
Those functions were exported before even with NET disabled.
There is a NETLINK_DISABLE config option which guards message
sending, now it should guard socket creation too.

Thanks, Adrian, I will create a patch for it.

> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 

-- 
	Evgeniy Polyakov
