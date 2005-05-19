From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: "prog/sensord/rrd.h" missing in "lm_sensors-2.8.0.tar.gz"
Message-Id: <20030811102825.534fbe8d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FAEFKBPPKHJGEAFNAHKKKEMKCBAA.maarteng@xs4all.nl>
In-Reply-To: <FAEFKBPPKHJGEAFNAHKKKEMKCBAA.maarteng@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I tried to compile the sensor daemon, but I didn't succeed because
> it looks like a file is missing in the distribution.
> 
> After:
> 
> # make PROG_EXTRA:=sensord
> 
> make returned:
> 
> make: *** No rule to make target `rrd.h', needed by
> `prog/sensord/rrd.rd'. Stop.
> 
> prog/sensord/rrd.rd and rrd.c are pointing to a file called "rrd.h"
> which is missing as far as I can see.

This header, and the rrd library as well, are not part of our package.
They are distributed in the rrdtool package by Tobi Oetiker. As written
in prog/sensord/README:

The RRD (Round Robin Database) development headers and libraries are
REQUIRED. Get this package from:
  http://ee-staff.ethz.ch/~oetiker/webtools/rrdtool

(I think we should update the URI to:
  http://people.ee.ethz.ch/~oetiker/webtools/rrdtool/
Still the old one works.)

So I guess you did not install rrdtool properly, and this is why you get
that missing header error.

> Anyway, nice job!!

Thanks, we are working hard to make everyone satisfied with lm_sensors
:)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
