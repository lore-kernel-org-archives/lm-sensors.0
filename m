From: Philip Guyton <phil.lxnet@gmail.com>
Date: Wed, 29 Jan 2014 16:29:59 +0000
Subject: [lm-sensors] configuration file for Asus Z87M-Plus motherboard attached inline
Message-Id: <CADbbYFMdSL9SKtRGisvXvHidAhFube6=7c+JVN0OtM4aN4y0Rw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADbbYFPspWipwkw4_hUfWuOsvXOpj-AUjpsgQfSt_kAFG+bYQA@mail.gmail.com>
In-Reply-To: <CADbbYFPspWipwkw4_hUfWuOsvXOpj-AUjpsgQfSt_kAFG+bYQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry to spam but last attachment in bin mode!

Could the following attached config file be added to the wiki, I would
do it myself but don't have and don't know how to get a wiki account,
guidance on this for future edits of this file would be appreciated.

I have 2 machines with different cpus using this motherboard and have
confirmed VCCIN (Haswell), +3.3V, 5V, and 12V on both to correspond
exactly with the bios readings.  Fan readings also look good and all 3
fan headers have been tested.  I have used stock 13.10 kubuntu
(default lm-sensors 3.3.3) but with the nct6775 module from
https://github.com/groeck/nct6775 to drive the nct6791d chip on this
board.

My thanks to all the lm-sensors and related teams.

There are still some unknowns but the basics are up and running.  I
have intentionally left the unknown / unlabelled values without min
and max settings so they still show alarm state.

There are notes within the config file and I believe it to be fit for
general use.

Philip G
In line contents of Asus-Z87M-Plus

chip "nct6791-*"
# nct6791d or compatible chip at 0x2e:0x290 Asus Z87M-PLUS bios 0903
# non current kernels will require more recent nct6775 module from
# https://github.com/groeck/nct6775

# Fans
  label fan2 "CPU Fan"
  label fan1 "System FAN1"
  label fan3 "System FAN2"
# only 3 fan headers on Asus Z87M-PLUS so ignore fan4, fan5
  ignore fan4
  ignore fan5

# add scale to in0 / VCCIN (Haswell) to change from 0.88 raw * 2 = 1.76V
# then agrees with VCCIN reading of bios with i4670K
# also agreed with bios readings with i4570 ie 0.872 raw * 2 = 1.744V
  label in0 "VCCIN"
  compute in0 @*2, @/2
# adjust range, just made these up on usual 5% of i4670K
  set in0_min 1.76*0.95
  set in0_max 1.76*1.05

# sensors -u gives 1.024 which *5 is exactly what bios gives 5V as
  label in1 "5V"
  compute in1 @*5, @/5
# add a 5% tolerance as per ATX spec
  set in1_min 5*0.95
  set in1_max 5*1.05

# sensor -u gives 3.280 which is exactly what bios gives 3.3V line
  label in2 "+3.3V"
# add a 5% tolerance as per ATX spec
  set in2_min 3.3*0.95
  set in2_max 3.3*1.05

# I have seen in3 give the following readings via sensor -u
# 3.280 3.264
# don't know what it is.

# sensors -u gives 1.016 which *12 is exactly what bios gives 12V as
  label in4 "12V"
  compute in4 @*12, @/12
# add a 5% tolerance as per ATX spec
  set in4_min 12*0.95
  set in4_max 12*1.05

# I have seen in6 give the following readings via sensors -u
# 0.848 0.856 0.864, 0.872, 0.880, 0.904, 0.912 so mostly 0.008 interval
# haven't matched it to anything.

# Assuming in7 is 3VSB (Stand By) from voltage as a little further off
# also from nct6776-* entry in /etc/sensors3.conf
  label in7 "3VSB"
# add a 5% tolerance as per ATX spec
  set in7_min 3.3*0.95
  set in7_max 3.3*1.05

# Assuming in8 as Vbat from nct6776-* entry in /etc/sensors3.conf
  label in8 "Vbat"
# add a 10% tolerance in battery voltage
  set in8_min 3.0*0.90
  set in8_max 3.3*1.10

# Haswell specs give max temp of 72C (case) 77C (core)
# This need checking.
# putting more conservative max temps on CPUTIN (temp2)
# using 72 to be safe but may be just plain wrong
  set temp2_max 72
  set temp2_max_hyst 67

# I have seen in9 give the following readings via sensor -u
# 1.008
# haven't matched it to anything.

# in5 & 10 always reads +0.15V on 2 boards, ignoring
  ignore in5
  ignore in10
# in11 & 14 always reads +0.13V on 2 boards, ignoring
  ignore in11
  ignore in14
# in12 & 13 always reads +0.13 or +0.12V on 2 boards, ignoring
  ignore in12
  ignore in13

# Assuming not connected to anything as very high values that don't change
# Don't know though!
  ignore SYSTIN
  ignore AUXTIN1
  ignore AUXTIN2
  ignore AUXTIN3
# Note AUXTIN0 reads about 34, 34.5 C on one machine
# and 34, 35, and 36 C on another machine
# but after first suspend resume it reads 115C on one box and 119C on the other.

# advised by Guenter at https://github.com/groeck/nct6775/issues/11 to
ignore the following 3
  ignore PCH_CHIP_CPU_MAX_TEMP
  ignore PCH_CHIP_TEMP
  ignore PCH_CPU_TEMP

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
