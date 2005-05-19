From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: lm_sensors compiled problem
Message-Id: <200407051306.i65D6rZ2027196@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407010220.WAA29129@vizcacha.cox.net>
In-Reply-To: <200407010220.WAA29129@vizcacha.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I get a similar problem when I downgrade lm_sensors to 2.7.0.  I tried
>using my existing i2c 2.8.7, and I also tried dropping back to i2c
>2.7.0.  Using the approved combination of lm_sensors 2.70 with i2c
>2.7.0 I got this:
>
>gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.16/build/include   -O2   -c kernel/busses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
>kernel/busses/i2c-amd8111.c:500: initializer element is not constant
>kernel/busses/i2c-amd8111.c:500: (near initialization for `amd8111_driver.remove')
>kernel/busses/i2c-amd8111.c:501: initializer element is not constant
>kernel/busses/i2c-amd8111.c:501: (near initialization for `amd8111_driver')
>make: *** [kernel/busses/i2c-amd8111.o] Error 1

My bad. I thought the problem had been introduced after 2.7.0, while it
obviously has been introduced before.

This means you would need to go back to 2.6.x. It only makes sense if you
don't have any recent hardware, else such an old version won't be of
any help to you anyway. BTW I believe that Suse has packages for
lm_sensors 2.6.x so you shouldn't have to compile it by yourself.

>I'm afraid that I don't know how to write the fixes, so I guess that
>leaves upgrading the kernel as the sole option.  (I'm planning to move
>to a 2.6 kernel.)

Moving to a 2.6 kernel would definitely help since drivers are now part
of the main kernel tree. Not all drivers have been ported though, but
the more popular ones tend to be.

Jean Delvare
