From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Intel S845WD1-E
Message-Id: <20040428213228.531f3cd9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200404280005.56044.lists@localguru.de>
In-Reply-To: <200404280005.56044.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I built all from source and it seems to work fine :)

Great :)

> lm85b-i2c-0-2e
> Adapter: SMBus I801 adapter at efa0
> in0:        +1.52 V  (min =  +0.00 V, max =  +3.32 V)
> in1:        +1.50 V  (min =  +0.00 V, max =  +2.99 V)
> in2:        +3.32 V  (min =  +0.00 V, max =  +4.38 V)
> in3:       +5.21 V  (min =  +0.00 V, max =  +6.64 V)
> in4:      +11.94 V  (min =  +0.00 V, max = +15.94 V)
> fan1:      4825 RPM  (min =    0 RPM)
> fan2:         0 RPM  (min =    0 RPM)
> fan3:         0 RPM  (min =    0 RPM)
> fan4:         0 RPM  (min =    0 RPM)
> temp1:       +28 C  (low  =  -127 C, high =  +127 C)
> temp2:       +23 C  (low  =  -127 C, high =  +127 C)
> temp3:       +23 C  (low  =  -127 C, high =  +127 C)
> pwm1:      255
> pwm2:      255
> pwm3:      255
> vid:      +1.525 V    (VRM Version  9.1)
>
> Any idea where to find a translation of in0, in1, fan1,
> pwm1 etc ?

I'm actually astonished that they are not in sensors.conf.eg. Philip,
care to provide a sample configuration section for lm85 and clones?

Wild guess:
in0 = Vcore1
in1 = Vcore2
in2 = +3.3V
in3 = +5V
in4 = +12V
fan1 = CPU Fan
temp1 = CPU Temp
temp2 & temp3 = Case Temp

Just guessing however.

-- 
Jean Delvare
http://khali.linux-fr.org/
