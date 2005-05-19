From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: Need support for Ticket #: 1643
Message-Id: <20040421205751.3d858dda.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <63715.192.91.147.36.1082567214.squirrel@www.shoptalkforums.com>
In-Reply-To: <63715.192.91.147.36.1082567214.squirrel@www.shoptalkforums.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brian,

> I searched the lists, and tickets but could not find the solution. 
> And was told to email if I still needed help.  The problem as reported
> in the help ticket is below.
> Thanks,
> Brian
> 
> This is probably releated to my other problem where sensors -s says
> "No sensors found!", but I found that the /proc/sys/dev/sensors/vt1211
> is updating.  But I notice that if I do a ls in the sensors diretory
> chips shows up twice.
> lsmod:
> vt1211                  6736   0  (unused)
> i2c-proc                6836   0  [vt1211]
> i2c-isa                  748   0  (unused)
> i2c-core               15652   0  [vt1211 i2c-proc i2c-isa]
> 
> ls -l
> total 0
> -rw-r--r--    1 root     root            0 Apr  4 19:52 chips
> -rw-r--r--    1 root     root            0 Apr  4 19:52 chips
> dr-xr-xr-x    2 root     root            0 Apr  4 19:52 vt1211-isa-6000

In one of your tickets or on IRC (can't remember) I think I saw
something that resembled a kernel oops or similar. If I remember
correctly it was related to i2c-dev. If you have not rebooted your
system since, I don't think you have any chance to get it to work.

I suspect that your problems are caused by an incorrect installation of
i2c and/or lm_sensors on your system. I invite you to ensure that i2c is
correctly installed and that lm_sensors is compiled using the matching
i2c headers (you may have to change I2C_HEADERS in the Makefile. Make
sure that you have no old i2c kernel module lying around, that could be
the cause of your problems. Also, be sure you run "depmod -a" after
installing the new kernel modules. Once all that in done, load the
modules in order and watch the kernel logs and dmesg for hints. Check
that the versions advertised by the drivers are correct and that they
don't complain about anything.

Hopefully your system will work then.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
