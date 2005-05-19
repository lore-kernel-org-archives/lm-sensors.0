From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: News about PC87366
Message-Id: <20040521194331.2382a0b0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516104801.568f2ad0.khali@linux-fr.org>
In-Reply-To: <20040516104801.568f2ad0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sandeep,

Here is an experimental configuration file that should match your
motherboard settings quite well. Please test with the latest version of
the driver from CVS and let me know how it works!

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
-------------- next part --------------
chip "pc87366-*"

# Voltage inputs

   ignore in0
   label in1   "+5V"
   label in2   "Vcore"
   ignore in3
   ignore in4
   label in5   "+12V"
   label in6   "5VSB"
   label in7   "Vsb"
   label in8   "Vdd"
   label in9   "Vbat"
   label in10  "AVdd"

   compute in1   @*(28/10+1), @/(28/10+1)
   compute in5   @*(210/28+1), @/(210/28+1)
   compute in6   @*(28/10+1), @/(28/10+1)
   compute in7   @*2, @/2
   compute in8   @*2, @/2
   compute in10  @*2, @/2

   set in1_min    5 * 0.90
   set in1_max    5 * 1.10
   set in5_min   12 * 0.90
   set in5_max   12 * 1.10
   set in6_min    5 * 0.90
   set in6_max    5 * 1.10
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

#   set temp1_min    0
#   set temp1_max   70
#   set temp1_crit  85
#   set temp2_min    0
#   set temp2_max   70
#   set temp2_crit  85
   set temp3_min    5
   set temp3_max   60
   set temp3_crit  70

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

   compute temp4  3435 / (` (1 / (1 - @ / in10) - 1) + 3435 / 298.15) - 273.15, \
                  in10 * (1 - 1 / (1 + (^ (3435 / (273.15 + @) - 3435 / 298.15))))
   compute temp5  3435 / (` (1 / (1 - @ / in10) - 1) + 3435 / 298.15) - 273.15, \
                  in10 * (1 - 1 / (1 + (^ (3435 / (273.15 + @) - 3435 / 298.15))))
   compute temp6  3435 / (` (1 / (1 - @ / in10) - 1) + 3435 / 298.15) - 273.15, \
                  in10 * (1 - 1 / (1 + (^ (3435 / (273.15 + @) - 3435 / 298.15))))

   set temp4_min    0
   set temp4_max   70
   set temp5_min    0
   set temp5_max   70
   set temp6_min    0
   set temp6_max   70

# Fan inputs

# Ignore fans you don't have
#   ignore fan2
   ignore fan3

   set fan1_min 3000
   set fan2_min 2000
#   set fan3_min 2000
