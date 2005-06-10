From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 10 Jun 2005 20:08:14 +0000
Subject: [lm-sensors] smsc47m1 FAN problem on MS-6796 chipset Intel 865G
Message-Id: <42A9D6FC.5040207@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050610172841.GA23885@upjs.sk>
In-Reply-To: <20050610172841.GA23885@upjs.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,
> Hi,
> 
> I have compiled kernel-2.6.12-rc6 with patch
> linux-2.6.12-rc3-i2c-smsc47m1-m15x-m192-support.diff
> and installed lm_sensors-2.9.1.
> I don't know how next solution is affected by patching.
> 
> Using sensors-detect gives:
> No i2c device files found. Use prog/mkdev/mkdev.sh to create them.
> After creating appropriate /dev/i2c-x I run sensors-detect.
> The process didn't detect sensors expect (after starting
> /etc/init.d/lm_sensors start)
> odule                  Size  Used by
> i2c_isa                 1920  0
> i2c_core               18064  1 i2c_isa
> 
> As you see, the list doesn't contain smsc47m1 module as I expected.
> So I continued loading by hands, modprobe smsc47m1
> lsmod
> Module                  Size  Used by
> smsc47m1                8968  0
> i2c_sensor              3072  1 smsc47m1
> i2c_isa                 1920  0
> i2c_core               18064  3 smsc47m1,i2c_sensor,i2c_isa
> 
> sensors 
> command gives:
> smsc47m1-isa-0800
> Adapter: ISA adapter
> fan1:        0 RPM  (min = 5120 RPM, div = 1)
> fan2:        0 RPM  (min = 2560 RPM, div = 2)
> 
> Image of the driver si located at:
> /sys/bus/i2c/devices/0-0800/
> where are files as follows:
> -r--r--r--  1 root root 4096 Jun 10 18:55 alarms
> lrwxrwxrwx  1 root root    0 Jun 10 18:55 bus -> ../../../../bus/i2c
> lrwxrwxrwx  1 root root    0 Jun 10 18:55 driver -> ../../../../bus/i2c/drivers/smsc47m1
> -rw-r--r--  1 root root 4096 Jun 10 18:55 fan1_div
> -r--r--r--  1 root root 4096 Jun 10 18:55 fan1_input
> -rw-r--r--  1 root root 4096 Jun 10 18:55 fan1_min
> -rw-r--r--  1 root root 4096 Jun 10 18:55 fan2_div
> -r--r--r--  1 root root 4096 Jun 10 18:55 fan2_input
> -rw-r--r--  1 root root 4096 Jun 10 18:55 fan2_min
> -r--r--r--  1 root root 4096 Jun 10 18:55 name
> drwxr-xr-x  2 root root    0 Jun 10 18:55 power
> -rw-r--r--  1 root root 4096 Jun 10 18:57 pwm1
> -rw-r--r--  1 root root 4096 Jun 10 18:57 pwm1_enable
> -rw-r--r--  1 root root 4096 Jun 10 18:57 pwm2
> -rw-r--r--  1 root root 4096 Jun 10 18:57 pwm2_enable
> 
> Stopping and working in the maximum regime can be done by
> echo 0 > pwm1_enable
> echo 0 > pwm2_enable
> echo 1 > pwm1_enable
> echo 1 > pwm2_enable
> 
> The speed regulation can be controled writing a value from the range
> 0 - maximal speed, to 255 - stop spining, the polarity is reversed.

Ok. I will check the datasheet if there is some polarity bit.

> Sorry Rudolf, but I don't understand you how can I play with pwmX_clock?
> I have files as listed above only. What is the fan speed? Is it possible
> to measure it?

The pwmX_clock is base clock of PWM changing it affects the curve (fanspeed versus PWM value)
I suggesed that because I was trying you to help you with your problem. You dont need to play with it unless the fans are doing the high pitch noise. (you can change the frq to get rid of it)

Fan speed is measured but not in correct range. You need to change the fan divisor. (It is described in FAQ)
But all you need is to write echo 4 > fan1_div and fan2_div too. If the fans are slow try 8 instead.

You can edit /etc/sensors.conf for that (just add correct set fanX_div statements to correct sections)

> Thank you Rudolf for your advice. I lowered speed of fans and I can
> hear my typing fingers on keyboard, uhfff!
> 
> I read somewhere that my chip has HW block. I don't know if I will be able to write
> support, but I can try. If you have any advice how to start, I will be glad.

Ah it seems that someone is working on that results after summer. So be patient please.

Regards

Rudolf
