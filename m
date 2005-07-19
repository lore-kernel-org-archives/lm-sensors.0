From: bunk@stusta.de (Adrian Bunk)
Date: Tue, 19 Jul 2005 02:06:59 +0000
Subject: [lm-sensors] drivers/w1/w1_int.c compile error with NET=n
Message-Id: <20050719000549.GD5031@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: johnpol@2ka.mipt.ru
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

I'm seeing the following compile error in 2.6.13-rc3-mm1 (but it doesn't 
seem to be specific to -mm) with CONFIG_NET=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `w1_alloc_dev':
w1_int.c:(.text+0x65d81f): undefined reference to `netlink_kernel_create'
w1_int.c:(.text+0x65d881): undefined reference to `sock_release'
drivers/built-in.o: In function `w1_free_dev':
w1_int.c:(.text+0x65d8e9): undefined reference to `sock_release'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


