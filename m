From: maarteng@xs4all.nl (Maarten Gerbrands)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: "prog/sensord/rrd.h" missing in "lm_sensors-2.8.0.tar.gz"
Message-Id: <FAEFKBPPKHJGEAFNAHKKKEMKCBAA.maarteng@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I tried to compile the sensor daemon, but I didn't succeed because
it looks like a file is missing in the distribution.

After:

# make PROG_EXTRA:=sensord

make returned:

make: *** No rule to make target `rrd.h', needed by `prog/sensord/rrd.rd'.
Stop.

prog/sensord/rrd.rd and rrd.c are pointing to a file called "rrd.h" which is
missing as far as I can see.

Anyway, nice job!!

Greetings,

Maarten Gerbrands.
