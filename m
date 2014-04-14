From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 14 Apr 2014 07:21:14 +0000
Subject: Re: [lm-sensors] Asus M5A88-M motherboard, "no pwm-capable sensor modules"
Message-Id: <20140414092114.341aca00@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <534B5355.5090102@gmail.com>
In-Reply-To: <534B5355.5090102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bernd,

On Mon, 14 Apr 2014 12:17:41 +0900, Bernd Bausch wrote:
> I would like to run my PC as silently under Linux as I can under
> Windows. Unfortunately I am pretty ignorant about hardware monitoring
> and control.
> 
> Asus provides a fan control utility that allows me to throttle the CPU
> fan (not the case fan unfortunately), but I have been unable to do the
> same using lm_sensors. pwmconfig reports that there are no pwm-capable
> sensors.
> 
> So I wonder, does pwmconfig tell the truth? If yes, how can the CPU
> fan be controlled (it obviously can)? What are my options apart from
> leaving things as they are?

What does "sensors" say? Before you go with fan control, you must
ensure that hardware monitoring itself is properly setup.

> This is on Centos 6.5 with an unchanged kernel (2.6.32-431, 64 bit). I
> use the standard lm_sensors packages but the newest version of
> sensors-detect. I also tried the newest version of pwmconfig.
> sensors-detect and pwmconfig output below.
> 
> Thanks for listening, and more thanks for replying :)
> 
> Bernd
> 
> --------------------------------------------
> 
> sudo /tmp/sensors-detect
> Stopping lm_sensors:                                       [  OK  ]
> # sensors-detect revision 6243 (2014-03-20 11:23:35 +0100)
> # Board: ASUSTeK Computer INC. M5A88-M
> (...)
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `it87':
>   * ISA bus, address 0x290
>     Chip `ITE IT8721F/IT8758E Super IO Sensors' (confidence: 9)

Support for this chip was added in kernel 2.6.37.

> Driver `fam15h_power' (autoloaded):
>   * Chip `AMD Family 15h power sensors' (confidence: 9)
> 
> Driver `k10temp' (autoloaded):
>   * Chip `AMD Family 15h thermal sensors' (confidence: 9)

Support was added in kernel 3.0.

I'm afraid your kernel is simply too old for your hardware, unless
Centos backported support for newer hwmon devices.

Actually for Centos you may be lucky and be able to use Phil Perry's
kmods. Check out at:
  http://elrepo.org/tiki/Packages#K

I see kmod-k10temp and kmod-it87, which are what your board needs. Give
it a try. I've added Phil in Cc, hopefully he can drive from here if
things don't work out of the box.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
