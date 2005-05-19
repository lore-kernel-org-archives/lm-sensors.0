From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Can't access /proc file for writing
Message-Id: <20031103220040.302ef446.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
In-Reply-To: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > OK, file permissions look good (most files have mode 644, which
> > means you are supposed to be allowed to write to them). Now I'd like
> > you to try actually writing to a file. For example, go to
> > /proc/sys/dev/sensors/as99127f-i2c-0-2d and do:
> > echo 70 > temp1
> 
> Yes, it worked. I think I triggered some alarm or something like that.
> The internal speaker started to beep, but the things goes back to the
> normal after I echoed the previous value back to temp1. (Yes, I do
> "cat temp1", first ). Currently the temp1 value is "60.0 127.0 40.0".

OK, so the /proc interface is OK, which means the library is causing the
trouble.

> I set vrm to 9.0 too, without changes....

The VRM setting only impacts the VID computing, which in turns only
impacts VCore's limits.

> Is it fine the directories have permissions 0444 ? The error message
> show a write problem with the 0444 directory as99127f-i2c-0-2d, not
> with the files...just a idea, in case you haven't noticed....
> For your convenience, the error message was:
> 
> # sensors -s
> as99127f-i2c-0-2d: Can't access /proc file for writing;
> Run as root?

The message was about the chip id. It happens that the directory is
named after the chip id, still the directory's permissions are OK. Write
permission to a directory allows you to create files there, and that's
not something that can happen on the /proc virtual filesystem. 

Could you please run "strace sensors -s 2> /tmp/sensors-s.strace" (as
root) and send us the /tmp? I don't know much about strace but I
remember that it's what we asked last time a similar problem was
reported ;) Maybe someone else on the list will be able to interpret the
trace.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
