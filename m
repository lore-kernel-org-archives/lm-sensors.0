From: ajohnson@lastaccess.com (Andrew D. Johnson)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: PC87366 with the net4801
Message-Id: <1088361935.3tfych5kzmps@lastaccess.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun 27 Jun 2004 07:08:11 AM CDT Jean Delvare <khali@linux-fr.org> said:

> (Could you please inline files you are sending instead of gziping
> and attaching them? It would make my work easier.)

No problem. I typically do that because wrapping can get rather ugly, but it's
not much of a concern here.

> I just fixed it into libsensors. Please do "cvs update lib/chips.c" and
> update the library with "make user && make user_install". The errors
> should go away and we may have more interesting readings to go with.
>
> Please let me know how it goes after that.
> So I invite you to add the following lines in your configuration file:
>
>    set temp4_min    0
>    set temp4_max   85
>    set temp5_min    0
>    set temp5_max   85
>
> *after* the compute lines. Don't attempt to set temp4/5_crit yet (if
> ever). Run "sensors -s" for the new limits to take effect.

I applied your chils.c patch, but unfortunately I'm still seeing the "Can't get
TEMP4/5 data" errors. I'm NOT seeing the "Can't get TEMP4/5 overtemperature
data" errors, though.

pc87366-isa-6620
Adapter: ISA adapter
in0:       +2.95 V  (min =  +0.00 V, max =   2.95 V)
in1:       +2.24 V  (min =  +1.18 V, max =   1.45 V)       ALARM
in2:       +2.79 V  (min =  +0.00 V, max =   2.95 V)
in3:       +0.77 V  (min =  +0.00 V, max =   2.95 V)
in4:       +2.76 V  (min =  +0.00 V, max =   2.95 V)
in5:       +2.77 V  (min =  +1.27 V, max =   1.55 V)       ALARM
in6:       +0.00 V  (min =  +1.18 V, max =   1.45 V)       ALARM
Vsb:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
Vdd:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
Vbat:      +2.95 V  (min =  +2.40 V, max =   2.95 V)
AVdd:      +3.64 V  (min =  +2.99 V, max =   3.59 V)       ALARM
S-IO Temp:   +83 C  (low  =    +0 C, high =   +70 C)   ALARM
S-IO Crit:   +85 C
ERROR: Can't get TEMP4 data!
temp4_crit:
              -9 C
ERROR: Can't get TEMP5 data!
temp5_crit:
              -9 C
temp6:      -273 C  (low  =  +109 C, high =  +179 C)   ALARM
temp6_crit:
              -9 C

Here's my sensors.conf:
chip "pc87366-*"

# Voltage inputs

# Set VRM version (default 9.0)
#   set vrm     9.0

   label in7   "Vsb"
   label in8   "Vdd"
   label in9   "Vbat"
   label in10  "AVdd"

   compute in7   @*2, @/2
   compute in8   @*2, @/2
   compute in10  @*2, @/2

# These are the operating conditions as recommended by National
# Semiconductor
   set in7_min   3.0
   set in7_max   3.6
   set in8_min   3.0
   set in8_max   3.6
   set in9_min   2.4
   set in9_max   3.6
   set in10_min  3.0
   set in10_max  3.6

# Temperature inputs

   label temp1       "CPU0 Temp"
   label temp1_crit  "CPU0 Crit"
   label temp2       "CPU1 Temp"
   label temp2_crit  "CPU1 Crit"
   label temp3       "S-IO Temp"
   label temp3_crit  "S-IO Crit"

   set temp3_min    0
   set temp3_max   70
   set temp3_crit  85

# Thermistors
# On some systems, thermistors are used instead of thermal diodes.
# Note that these are the same pins used differently, so you really
# can't have them all on a given system.
   ignore temp1
   ignore temp2
#   ignore temp4
#   ignore temp5
#   ignore temp6

# 3435 is the thermistor beta.
# This assumes that the thermistor forms a resistor divider with a resistor
# equal to its nominal value at 25 degres Celcius. If not, change the values.
# We also assume that you have a working in10 (which is forcibly enabled by
# default). If not, use 3.3 instead, but you lose accuracy.

   compute temp4  3435 / (` (1 / (1 - @ / in10) - 1) + 3435 / 298.15) - 273.15,
\
                  in10 * (1 - 1 / (1 + (^ (3435 / (273.15 + @) - 3435 /
298.15))))
   compute temp5  3435 / (` (1 / (1 - @ / in10) - 1) + 3435 / 298.15) - 273.15,
\
                  in10 * (1 - 1 / (1 + (^ (3435 / (273.15 + @) - 3435 /
298.15))))
   compute temp6  3435 / (` (1 / (1 - @ / in10) - 1) + 3435 / 298.15) - 273.15,
\
                  in10 * (1 - 1 / (1 + (^ (3435 / (273.15 + @) - 3435 /
298.15))))

set temp4_min    0
set temp4_max   85
set temp5_min    0
set temp5_max   85

# Fan inputs

# Ignore fans you don't have
   ignore fan1
   ignore fan2
   ignore fan3

#   set fan1_min 2000
#   set fan2_min 2000
#   set fan3_min 2000

> > I've also sent that email off to Soekris. Hopefully they'll
> > respond to it soon.
>
> I hope too, but in my experience directing technical questions to sales@
> rarely works. Don't they have a support@ contact?

I was surprised to see that the sales@ address is where they want technical
questions to be addressed. They're a relatively small company, though. I did
manage to forget to stick a subject on that message... hopefully their spam
filter doesn't catch that :)
http://www.soekris.com/about.htm

--
Andrew D. Johnson
PGP Fingerprint: 77BD 80B1 4918 1D98 9EBF 2E62 073B 9B31 A1DC 41F4
KeyID: 0xA1DC41F4
