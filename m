From: laytonjb@comcast.net (Jeffrey B. Layton)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: Problems with 2.4.22 kernel with 2.8.2
Message-Id: <3FE9981D.8090607@comcast.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FE79F84.7090702@comcast.net>
In-Reply-To: <3FE79F84.7090702@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Merry Christmas Eve!

   I didn't hear from anyone so I thought I would attempt a few
things on my own and managed to figure what I did wrong.
I thought I would answer my own email so it makes it into the
archives someone so if anybody does the same bone-head
thing I did they will know what to do. :)
   First off, I didn't have i2c-core.o loaded (I know, silly me).
Instead I put it in the kernel. That got me through the loading
of the i2c modules. Then the sensor modules wouldn't load
without errors (forgot what they were to be honest). I then
looked at my module configuration and found that I wasn't
loading the /proc module from i2c (i2c-proc.o?). I put that in
my kernel and rebooted. Bingo! It worked this time.
   I'm not sure why I had to either load the i2c-proc module
or put it in the kernel because for my 2.4.21-pre3 kernel I
did not have to do that and it loaded correctly. Hmm...
   Just one final thought. I know the sensors list is for developers.
I follow the list for other reasons, but occasionally I run into
a problem so I ask a question or two. In the year or two I've
been following the list I think I've gotten a response maybe
once or twice (thanks Mark!). I think with lm_sensors in the
2.6 kernel now we're going to see many more questions.
Perhaps splitting the lists into a 'users' and 'devel' list would
help?
   Anyway, merry Christmas to everyone!

Jeff


> Hello,
>
>   I'm having trouble with a 2.4.22 kernel I just built
> with patches from i2c-2.8.2 and lm_sensors-2.8.2.
> I've built some previous kernels (2.4.21) with the
> 2.8.0 patches and they have worked fine.
>   Anyway, here are the lines in my /etc/rc.d/rc.local
> file:
>
> #----cut here----
> # I2C adapter drivers
> /sbin/modprobe i2c-sis630
> /sbin/modprobe i2c-isa
> # I2C chip drivers
> /sbin/modprobe eeprom
> /sbin/modprobe sis5595
> #/sbin/modprobe it87
> /sbin/modprobe it87 temp_type=0x31
> #----cut here----
>
> When I try running modprobe by hand on the first line,
> I get the following,
>
>
> # /sbin/modprobe i2c-sis630
> /lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: unresolved 
> symbol i2c_add_adapter_Rb2b6afaa
> /lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: unresolved 
> symbol i2c_del_adapter_Rf78dd64d
> /lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: insmod 
> /lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o failed
> /lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: insmod 
> i2c-sis630 failed
> [root@admin1 rc.d]# /sbin/modprobe i2c-sis630
> /lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: unresolved 
> symbol i2c_add_adapter_Rb2b6afaa
> /lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: unresolved 
> symbol i2c_del_adapter_Rf78dd64d
> /lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: insmod 
> /lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o failed
> /lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: insmod 
> i2c-sis630 failed
>
>
> (BTW, this is a ECS P6STP-FN motherboard with a
> SiS630 chipset).
>   This has worked before and I just wanted to update the
> kernel and lm_sensors. Any ideas what I screwed up?
> (oh, this was compiled with gcc-3.2.2).
>
> Thanks!
>
> Jeff
>
>
>

