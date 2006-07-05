From: com.ea@tinet.org (com.ea)
Date: Wed, 05 Jul 2006 12:54:05 +0000
Subject: [lm-sensors] w83627hf, fan speed always high, unchangeable?
Message-Id: <q6dna2l8qoo4lqoeg3icfo6c8ni6db7n3d@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43692C12.90301@gmail.com>
In-Reply-To: <43692C12.90301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hello

>> I use lm-sensors version 2.9.2-5ubuntu3 (I am on the last stable Ubunutu 6.06).
>> My chipset is a Winbond W83697HF and my mobo is a MSI K8T Neo-FIS2R (MS-6702).
>> I have the same problem :

be careful, the topic reads w83627hf and its registers are different
from the ones in w83697hf and w83627ehf.

>> However, I'm sure the fan is controllable in speed because under Windows (only
>> :( ), MSI provides a software (CoreCenter) that works perfectly (in "thermal"
>> or "speed cruise", speed regulated between 1500 and 2600 rpm). Still under
>> windows XP, I tested SpeedFan and I had the same problem than with pwmconfig.
>> The only way I succeeded in reducing the speed was to low the clock of PWM
>> clock frequency, which you propose.

w83697hf is supported by rtsensors, rtsensors is an applicattion i
wrote some time ago, but it works like a charm for me

you can get it here
http://www.tinet.org/~com.ea/rtsensors/

as w83697HF and w83627EHF are the same in terms of pwm and pwmclock
registers ... (correct me if not) they both can be controlled with
rtsensors

>
>1) rmmod w83627hf
>   so the driver wont be confused
>2) reprogram the chip to bank 0
>    isaset 0x295 0x296 0x4e 0x00
>3) reprogram the value
>     isaset 0x295 0x296 0x0 0x84
>
>For fan2 it would be in register 2 bank 0
>     isaset 0x295 0x296 0x2 0x84
>
>4) modprobe w83627hf
>5) pwmconfig
>

this will only work for w83627ehf and w83697hf, NOT for w83627hf !
be careful

Carlos

