From: Claus.Rosenberger@rocnet.de (Claus Rosenberger)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: lmsensors ticket #1144
Message-Id: <37554.10.20.2.100.1046454982.squirrel@deathstar.of.rocnet.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello,

i don't know why sensors reports "no sensors found" because i can get
following informations out of /proc :

/proc/bus/i2c:
i2c-0   dummy           ISA main adapter                        ISA bus
algorithm

/proc/bus/i2c-0:
290     IT87 chip                               IT87xx sensor driver

/proc/sys/dev/sensors/chips:
256     it87-isa-0290

/proc/sys/dev/sensors/it87-isa-0290/fan1:
3000 3245

there are a lot of files in /proc/sys/dev/sensors/it87-isa-0290 and
sometimes there are values in. why sensors don't report this values ?

regards

claus rosenberger

