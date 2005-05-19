From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: 2.8.1
Message-Id: <20031104203127.1b633f3d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F6484BA.24E78516@paradyne.com>
In-Reply-To: <3F6484BA.24E78516@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Is it split up into small, incremental patches, each patch only doing
> one thing?  That is what is going to be required if it will be
> accepted into the kernel tree.

Basically, it's all or nothing. The core patch updates the i2c subsystem
to 2.8.1. Then you have to patch Config.in and Makefile to make it work
(two more patches). At this point, you have a working i2c subsystem, but
all drivers using it (and not being part of i2c 2.8.1) are broken, so
all of them need to be fixed. Some of them are in drivers/i2c (8 more
patches, possibly merged into a few less), and the other ones spread
other the whole kernel tree (6 more patches).

The only patch left apart is the one that updates MAINTAINERS. Not even
worth mentioning I guess.

The way the patches are split might be reviewed somehow, but it won't
change the fundamental idea: you have to apply them all at once. I guess
it'll make it harder to get them accepted in the kernel, but there's no
other way I can imagine. And, although many files are affected, it's
always the same way. Patches are very, very simple, so there shouldn't
be much to be discussed on a per file basis.

I hope thet the kernel guys will be convinced that this is a good thing,
worth doing, though. Among positive points I can see, are:

1* It'll make it easier to use lm_sensors. Since 2.8.0, people can't
build lm_sensors without patching their kernels.

2* It'll make it easier to write "independant" (neither in kernel nor in
i2c/lm_sensors2 CVS) i2c drivers. For now, if authors want to support
both 2.4 and 2.6, they have to play with ifdef's all over their code. If
i2c 2.8.1 makes it through Linux 2.4, authors will be able to get rid of
that extra code.

3* The change makes it possible to (and was actually designed to) get
rid of MOD_{INC,DEC}_USE_COUNT in i2c drivers. I think that's something
they are wanting.

If there are other advantages worth mentioning, let me know so that I
can add them to the list.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
