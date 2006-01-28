From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 28 Jan 2006 20:56:26 +0000
Subject: [lm-sensors] packaging problem with latest CVS snapshot ?
Message-Id: <43DBDA7A.6090804@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43DBB097.2020100@gmail.com>
In-Reply-To: <43DBB097.2020100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> OK.   neccessary but insufficient:
> 
> [jimc at harpo lm_sensors2]$ make user
> ...
> gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
> -I/usr/local/include  -Wundef -Wall -O2  prog/dump/i2cdump.c | \
> sed -e 's@^\(.*\)\.o:@prog/dump/i2cdump.rd prog/dump/i2cdump.ro:
> Makefile '`dirname prog/dump/i2cdump.rd`/Module.mk' @' >
> prog/dump/i2cdump.rd
> gcc -M -MG -DETCDIR="\"/etc\"" -I. -Ikernel/include
> -I/usr/local/include  -Wundef -Wall -O2  prog/detect/i2cdetect.c | \
> sed -e 's@^\(.*\)\.o:@prog/detect/i2cdetect.rd prog/detect/i2cdetect.ro:
> Makefile '`dirname prog/detect/i2cdetect.rd`/Module.mk' @' >
> prog/detect/i2cdetect.rd
> make: *** No rule to make target `sysfs/libsysfs.h', needed by
> `lib/sysfs.ad'.  Stop.
> 
> 
> its there:
> $ ll /usr/local/include/sysfs/
> total 20
> -rw-r--r--  1 root root 7401 Jan 28 12:35 dlist.h
> -rw-r--r--  1 root root 8586 Jan 28 12:35 libsysfs.h
> 
> 
> still looking..  any idea ?
hmm no, sorry, I'm not very good with Makefiles...
Please try to fix it and send a patch.

Thanks,
regards
Rudolf

