From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Intel D865GLC
Message-Id: <20050212124631.3cd97125.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cui0st$i6r$1@sea.gmane.org>
In-Reply-To: <cui0st$i6r$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Timo,

> I think Vcore is measured from pin 'in1', but it produces 'too' good
> stable reading of 1.500 anyway -from day to day. It's not exactly the
> same what I can see in bios, but the reading is quite stable there
> too. The slight difference (1.494 in bios) _could_ be caused by
> slightly different current consumption, maybe?

Yes it could. The LSB of that input voltage channel is worth 0.008V, so
the slightest change could result in the different reading.

> I have tested this both in console, and in a terminal window under X,
> both result always in 1.500. Strange?

Admittedly strange, although not impossible.

> Or am I thinking something in a wrong way again? Below is the output
> of 'sensors' and piece of sensors.conf.
> lm_sensors is version 2.8.7-2, from current FC3 rpm.
> 
> Limits of Vcore are based to VID, which equals to 0. Is it a variable
> that needs to be se manually in the file, or should it be
> automatically readable from somewhere.

VID is read from the chip and should not be 0. There are two reasons it
can be:

1* The motherboard manufacturer did not wire the VID input pins.
Unlikely with Intel.

2* You use a recent kernel and a not-so-recent lm_sensors. For a
2.6.9-rc1 or higher kernel, you need lm_sensors 2.8.8 or higher.

> adm1027-i2c-0-2e
> Adapter: SMBus I801 adapter at c400
> ERROR: Can't get alarm mask data!
> V1.5:      +1.471 V  (min =  +1.42 V, max =  +1.58 V)
> VCore:     +1.500 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> V3.3:      +3.403 V  (min =  +3.13 V, max =  +3.47 V)
> V5:       +5.156 V  (min =  +4.74 V, max =  +5.26 V)
> V12:      +12.313 V  (min = +11.38 V, max = +12.62 V)
> CPU_Fan:   3170 RPM  (min = 4000 RPM)                     ALARM
> Front/Power_Fan:
>            2881 RPM  (min =    0 RPM)
> Rear/Exit_Fan:
>            2884 RPM  (min =    0 RPM)
> CPU:      +27.00?C  (low  =   +10?C, high =   +50?C)
> Board:    +25.00?C  (low  =   +10?C, high =   +35?C)
> Remote:   +27.00?C  (low  =   +10?C, high =   +35?C)
> ERROR: Can't get PWM1 data!
> ERROR: Can't get PWM2 data!
> ERROR: Can't get PWM3 data!

Errors on PWM would also be explained by a "too" recent kernel.

I'd invite you to try a newer version of lm_sensors, that would
certainly help. If this isn't an option, then you can temporarily do the
following:

> chip "lm85c-*" "adm1027-*" "adt7463-*" "lm85-*" "lm85b-*"
> (...)
> # PWM Outputs
>    ignore pwm1
>    ignore pwm2
>    ignore pwm3
> (...)
>    set in1_min  1.500 * 0.95
>    set in1_max  1.500 * 1.05

That way the errors on PWM will ge hidden and the limits for Vcore will
be set correctly (after you run sensors -s).

-- 
Jean Delvare
