From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 16 Nov 2009 16:02:29 +0000
Subject: Re: [lm-sensors] ASUS P6T, 2.6.31-14, no pwm devices
Message-Id: <68676e00911160802x3c2ab503v7965cf5fea2d1913@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
In-Reply-To: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 14, 2009 at 8:38 PM, Matt Sheumack <matt@sheumack.com> wrote:
> Hi All,
>
> Been scanning the recent activity around how 2.6.31 has broken fan control
> on many m/boards, and am hoping to make a contribution so this problem can
> be fixed. Given that my coding skills are limited to Fortran 77, best I can
> do is help with data and test. I've not (yet) enabled the "lax" workaround,
> so I don't know if it works. Happy to follow instructions from here to
> provide H/W input.
[...]
> # sensors
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:      +1.05 V  (min =  +0.80 V, max =  +1.60 V)
>  +3.3 Voltage:      +3.30 V  (min =  +2.97 V, max =  +3.63 V)
>  +5 Voltage:        +4.97 V  (min =  +4.50 V, max =  +5.50 V)
>  +12 Voltage:      +11.97 V  (min = +10.20 V, max = +13.80 V)
> CPU FAN Speed:     2481 RPM  (min =  600 RPM)
> CHASSIS1 FAN Speed:3590 RPM  (min =  600 RPM)
> CHASSIS2 FAN Speed:3245 RPM  (min =  600 RPM)
> POWER FAN Speed:      0 RPM  (min =    0 RPM)
> CPU Temperature:    +45.0°C  (high = +60.0°C, crit = +75.0°C)
> MB Temperature:     +40.0°C  (high = +45.0°C, crit = +75.0°C)

atk0110 does not support fan control. If you want it then you have to:
- blacklist asus_atk0110 module
- pass "acpi_enforce_resources=lax" on kernel command list
- load w83627ehf

Be sure to read the FAQ before trying it:
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
