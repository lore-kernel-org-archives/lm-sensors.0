From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Tickets #1322 and #1323
Message-Id: <20030708103016.476e2186.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030708093213.642bde1a.khali@linux-fr.org>
In-Reply-To: <20030708093213.642bde1a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I'm a bit troubled by your tickets. First, I guess that you were
> > using i2c & lm_sensors CVS, not 2.7.0.
> 
> no!
> 
> I'm using:
> i2c-2.7.0.tar.gz
> lm_sensors-2.7.0.tar.gz
> 
> I  download  only  the  Makefile  and  the  etc/config.c file from the
> web-to-CVS interface.

OK, I understand it better now.

> > You say that the depmod commands at the end of our Makefile were
> > preventing you from compiling lm_sensors. I can't understand, since
> > they are run by "make install", not make. Also, didn't you have the
> > same problem with installing i2c? The very same commands are run
> > when you run"make install" for i2c.

> I have not this problem with i2c compiling.

This is normal since you only took the lm_sensors Makefile from CVS, not
the i2c Makefile.

> Ok, here is the log from the ORIGINAL Make file from CVS tree with the
> etc/config.c
> 
> - --- BEGIN ------
> 
> [root@voice lm_sensors-2.7.0]# make
> Makefile:246: kernel/busses/i2c-ali1535.d: No such file or directory
> (...)
> Makefile:246: prog/detect/dmidecode.rd: No such file or directory
> Makefile:257: *** missing separator.  Stop.
> [root@voice lm_sensors-2.7.0]#

> so  as  you can see there is an error on the line 257 I look into the
> makefile,  and I can see only the lines with depmods. I make some test
> with  the  condition  "ifeq ($(DESTDIR),)", because if the is only the
> line  with  depmod, all runs successfully. So I try to comment out the
> lines and all troubles go away.

How did you get the lm_sensors Makefile from our CVS repository? I
suspect you copied-and-pasted it directly from your web browser and that
tabs were converted into spaces. Please double-check that lines 257 and
259 have leading *tabs* and not spaces. That would explain the error you
see. If I'm right, running "make help" for example would give you the
same kind of error at line 288.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
