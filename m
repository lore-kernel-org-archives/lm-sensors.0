From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: PWM on a W83697HF
Message-Id: <1079973316.405f15c4abd09@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Uwe Andersen:

> do you know how to work with the fan control capability (PWM) of a
> Winbond W83697HF?
> I tried various values in the bank0-registers 0x00, 0x01, 0x02, 0x03,
> 0x04 with various fans(do PWM need special fans?) but the fan
> rotation never changed.

PWM doesn't need special fans AFAIK (unlike fan speed reporting).

The W83697HF has two PWM channels (registers 0x01 and 0x03) which are
handled by our drivers (w83781d and w83627hf). You should not have to
play with registers directly, simply use the the pwm1 and pwm2 files
exported through procfs (2.4 kernels) or sysfs (2.6 kernels). The value
to write to/read from the file is between 0 and 255 (these are the
values of the registers, unchanged).

For gory details, see the W83697HF datasheet, but it should not be
needed (unless you suspect there is some bug in our drivers).

You may want to take a look at the tools under prog/pwm and
doc/fancontrol.txt in our package.

Note that for PWM to work, your motherboard manufacturer must have wired
the chip and fans correctly. If you cannot get it to work, this may
simply mean that this wasn't done. Which motherboard is it after all?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
