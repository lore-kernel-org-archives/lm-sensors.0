From: =?UTF-8?Q?David_Santamar=C3=ADa_Rogado?= <howl.nsp@gmail.com>
Date: Fri, 06 May 2011 18:32:51 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GM-US2H motherboard configuration
Message-Id: <BANLkTimfWi2BiiLa=0n0X6y7N2F20mW4aw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTimA9Uj9DbC+cG8hrpDXZL+6jTGW9w@mail.gmail.com>
In-Reply-To: <BANLkTimA9Uj9DbC+cG8hrpDXZL+6jTGW9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Yes that's is the config, but I could, or I think so, confirm that 12V
has exactly x4 multiplier, despite a very little more voltage than the
bios is shown.

Just some comments before, the fan1 speed is setup for my case, with
the minimum pwm it doesn't go slower. The other fans are like the UD2H
on internet and should be the same here. Also I made "compute  in4  @
* 4,            @ / 4", but I one config I can't remember I saw the
(30/10)+1 as multiplier and then I used the same formula, doesn't know
if could be issues bi putting only one number. This file should work
with MA785GMT-UD2H like the other config on internet but I think also
could work with MA785GPM-UD2H as it has a very very similar PCB. In
the config file there are more comments, perhaps you could clean up a
little. Here we go:

# lm_sensors 3 configuration file for the Gigabyte MA785GMT-US2H motherboard
# 2011-04-17, David Santamaría Rogado <howl.nsp@gmail.com>
# Written for board revision 1.0, may or may not be suitable for other
# revisions.
# Comments welcome!

chip "it8718-*"

### Voltages

  # in7 is mysterious, it lives in the range 2.19 to 2.94 V, change with
  # CPU frequency (if you take the highest clock speed of all the cores
  # you can guess it's value). No idea what it can be.

  label  in0  "Vcore"
  label  in1  "Vram"    # "DDR2" in BIOS
  label  in2  "+3.3V"
  label  in3  "+5V"     # Not in BIOS
  label  in4  "+12V"
  ignore in5            # Always fixed at 4.08 V
  ignore in6            # Always fixed at 4.02 V
  ignore in7            # Commented above
  label  in8  "Vbat"    # Not in BIOS

  # Vcore, Vram, +3.3V and Vbat are connected directly, so no compute
  # line is needed for these. For +5V the chip is configured to use
  # internal scaling. Scaling for +12V is apparently not standard, my
  # guess is that the BIOS uses 4 as the scaling factor. Not sure
  # if it matches the physical reality. BIOS values varies between
  # 12.048 and 12.112 V, lm-sensors in4 between 3.040 and 3.056 V, is
  # exactly a x4 scale +0.112 offset.

  compute  in3  @ * (6.8/10+1),   @ / (6.8/10+1)
  compute  in4  @ * ((30/10)+1),  @ / ((30/10)+1)

  # The BIOS won't set any limit for voltages.
  # You should set Vcore and Vram to match you setup, mine is:
  # - CPU: AMD Athlon II X2 250 (VCore 0.85-1.425)
  # - Mem: KHX8500D2/2G (Vram 1.8-2)

  set in0_min  0.85  * 0.95
  set in0_max  1.425 * 1.05
  set in1_min  1.8   * 0.95
  set in1_max  2     * 1.05
  set in2_min  3.3   * 0.95
  set in2_max  3.3   * 1.05
  set in3_min  5     * 0.95
  set in3_max  5     * 1.05
  set in4_min  12    * 0.95
  set in4_max  12    * 1.05

### Temperatures

  # The BIOS only shows 2 temperature values, corresponding to Sys and CPU,
  # temp3 is usually similar to Sys temp but under heavy load it raises more.

  label  temp1  "Sys Temp"
  label  temp2  "CPU Temp"
  label  temp3  "NBr Temp"    # Guessed

  set temp1_min  10
  set temp1_max  50
  set temp2_min  10
  set temp2_max  60
  set temp3_min  10
  set temp3_max  50

### Fans

  # I only have CPU fan, the other ones have to be tested.

  label  fan1  "CPU Fan"
  label  fan2  "Case Fan"
  ignore fan3
  label  fan4  "NBr Fan"

  # Adjust for your own fans
  set fan1_min 450
  #set fan2_min 1000
  #set fan4_min 1000

El día 3 de mayo de 2011 13:47, Jean Delvare <khali@linux-fr.org> escribió:
> Hi David,
>
> On Wed, 27 Apr 2011 22:10:54 +0200, David Santamaría Rogado wrote:
>> The configuration for Gigabyte MA785GM-US2H
>> http://www.lm-sensors.org/wiki/Configurations/Gigabyte/MA785GM-US2H is
>> wrong, at least for rev 1.0 of the mobo. in7 is not +12V, is an
>> strange voltage that varies with the frequency of the cores. Is
>> possible to determinate approximately it's value knowing the highest
>> freq of all the cores in the system. If there are doubts, with that
>> config and an Athlon II 250 the voltage show by in7 with the
>> multiplier is about 24 V.
>
> Thanks for reporting.
>
>> I can provide the config the works with my MA785GM-US2H rev 1.0.
>
> Yes, please do, and I'll update the wiki with your fixed version.
>
>> The
>> only thing I doesn't know sure are the fans because I have only tested
>> cpu fan. Anyway it's based on a UD2H cfg found on the internet, being
>> identical motherboards only differing in dolby theatre support over
>> spdif.
>
> "Found on the internet" as in
> http://khali.linux-fr.org/devel/lm-sensors/sensors3-Gigabyte-MA785GMT-UD2H.conf
> ? ;)
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
