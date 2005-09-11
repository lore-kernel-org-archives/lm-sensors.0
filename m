From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Sun, 11 Sep 2005 23:14:56 +0000
Subject: [lm-sensors] RFC: Acoustics enhancement interface
Message-Id: <20050911211327.GA23393@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I am fixing/enhancing the LM85 driver, and I need to add some way to
interface with the acoustics enhancement controls of the chip.
Unfortunately, such an interface appears to not have been defined yet, so
here is my proposal:

When no acoustics enhancement functionality is provided, all of the
folowing sysfs entries should be missing.

auto_acoustics_enhancement:
   Global toggle, RW
     0: disable
     1: enable, lowest level of enhancement
     2: enable, mid-to-lowest level of enhancement
     3: enable, mid level of enhancement
     4: enable, mid-to-highest level of enhancement
     5: enable, highest level of enhancement
    -1: set to manual control
   Default: usually 0 or -1, depending on chip state at module loading.

   -1 should not be available if no further acoustics enhancement sysfs
   entries are implemented (i.e. one cannot manually control anything
   anyway!)

auto_acoustics_enhancement_pwm#:
auto_acoustics_enhancement_fan#:
   per pwm line/fan control of acoustics level enhancement. If the chip
   or driver cannot provide such a control, the entry is missing. Usually
   a chip will provide controls for pwm lines OR fans, but not both.

   Exactly WHAT the acoustics enhancement functionality does is not
   specified. Some chips will smooth out temperature variance. Others
   will smooth out variations on the PWM duty cycle, etc.

   RW if the global toggle is set to -1. RO otherwise (writes ignored).

   When the global control is set to 1-5, these entries should read 
   -1 to -5 accordingly.  Otherwise, they must read the time constant
   programmed in the chip (or zero, if the filtering is disabled for
   this pwm line/fan).

   Values higher than zero need not be supported.

     0: disabled for this fan/pwm line
    >0: time constant (in 0.1s) for the smoothing filter for this line
    -1: enable, lowest level of enhancement
    -2: enable, mid-to-lowest level of enhancement
    -3: enable, mid level of enhancement
    -4: enable, mid-to-highest level of enhancement
    -5: enable, highest level of enhancement

Is the smoothing filter time constant granularity (0.1s) good enough?
Do we need more decimal places (0.01s, 0.001s) ?

Is the proposed interface good enough to be adopted for the other drivers
as well?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
