From: Michael Hampton <error@ioerror.us>
Date: Tue, 03 Mar 2009 14:49:39 +0000
Subject: Re: [lm-sensors] W83667HG driver test for in6 and temp3
Message-Id: <49AD4383.2060809@ioerror.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> To all potential testers: I've split support for the W83667HG into 3
> patches:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-w83627ehf-01-invert-fan-pin-logic.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-w83627ehf-02-add-support-for-w83667hg.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-w83627ehf-03-fix-temp3-vs-in6.patch
>
> These patches are now in linux-next and will be merged into kernel
> 2.6.30 if we receive positive feedback.
>
> Any further change should be in a new patch to be applied on top of
> these 3 patches we already have.
>
> Thanks,
>   

I've applied these 3 patches against the latest Fedora 10 kernel
2.6.27.19-170.2.35.fc10.x86_64 and it's working, only I get temp3 (with
an invalid value) instead of in6. The motherboard is an ASUS P6T6 WS
Revolution.

w83667hg-isa-0290
Adapter: ISA adapter
in0:         +1.34 V  (min =  +0.00 V, max =  +1.74 V)  
in1:         +1.70 V  (min =  +0.02 V, max =  +0.00 V)   ALARM
in2:         +3.22 V  (min =  +1.02 V, max =  +0.26 V)   ALARM
in3:         +3.18 V  (min =  +2.56 V, max =  +0.00 V)   ALARM
in4:         +1.69 V  (min =  +0.00 V, max =  +1.04 V)   ALARM
in5:         +2.04 V  (min =  +0.77 V, max =  +0.52 V)   ALARM
in7:         +3.34 V  (min =  +0.02 V, max =  +1.34 V)   ALARM
in8:         +3.31 V  (min =  +0.86 V, max =  +1.09 V)   ALARM
fan1:       1917 RPM  (min = 1288 RPM, div = 8)
fan2:       1875 RPM  (min = 14062 RPM, div = 16)  ALARM
fan3:       1795 RPM  (min = 5273 RPM, div = 4)  ALARM
fan4:       1875 RPM  (min = 1298 RPM, div = 8)
fan5:       2481 RPM  (min = 2636 RPM, div = 8)  ALARM
temp1:       +43.0°C  (high =  +0.0°C, hyst =  +4.0°C)  ALARM  sensor thermistor
temp2:       +60.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = diode
temp3:      +127.0°C  (high = +80.0°C, hyst = +75.0°C)  ALARM  sensor thermistor
cpu0_vid:   +1.950 V

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
