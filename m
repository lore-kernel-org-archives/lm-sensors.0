From: DavidB@mail.interclean.com (David Brodbeck)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: lm_sensors 2.7.0 and bmcsensors.o
Message-Id: <C823AC1DB499D511BB7C00B0D0F0574C1DF89B@serverdell2200.interclean.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm having an odd problem with lm_sensors 2.7.0.  I can't get the bmcsensors
module to compile.  'make' simply doesn't generate a .o file from
bmcsensors.c.  I'm sure there's some silly piece of configuration I'm
missing, but I can't figure it out.  According to sensors_detect I need to
load this module.

----------

David Brodbeck, System Administrator
InterClean Equipment, Inc.
Ypsilanti, Michigan
davidb@mail.interclean.com
(734) 975-2967 x221

