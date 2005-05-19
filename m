From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Works now (Re: my user-space work ? (3d attempt))
Message-Id: <3F9487E5.4C2F31B9@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1065896525.1059.14.camel@dell.roesel.skynet.be>
In-Reply-To: <1065896525.1059.14.camel@dell.roesel.skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

so you have 'sensors' working on 2.6?
I'm having trouble understanding what you did from looking at the diff.
Could you explain if this is a general fix compatible for both 2.4 and
2.6 or
is there much more to do...
thanks
mds

Danny Backx wrote:
> 
> I'm sure I'm boring you by now. Sorry.
> 
> The names of the files in /sys were all different than what
> chips.c said. This caused much of the mismatch. The hardcoded
> file names are completely gone now. Voltage values start to
> make sense :
> dell: {227} prog/sensors/sensors
> w83627hf-i2c-/sys/bus/i2c/devices/0-0290
> Adapter: Dummy adapter
> Algorithm: Dummy algorithm
> in_input0:+14.40 V  (min = +12.16 V, max = +14.88 V)
> in_input1:+24.80 V  (min = +12.16 V, max = +14.88 V)
> in_input2:+33.44 V  (min = +29.76 V, max = +36.32 V)
> in_input3:+29.92 V  (min = +26.88 V, max = +32.64 V)
> in_input4:+31.52 V  (min = +28.48 V, max = +34.56 V)
> in_input5:+12.16 V  (min =  +3.36 V, max =  +7.84 V)
> in_input6:+15.04 V  (min =  +7.04 V, max = +10.24 V)
> in_input7:+32.80 V  (min = +26.88 V, max = +32.64 V)       ALARM
> in_input8:+32.96 V  (min = +27.04 V, max = +32.96 V)       ALARM
> fan_input1:
>           1622 RPM  (min =  187 RPM, div = 32)
> fan_input2:
>           3013 RPM  (min =  187 RPM, div = 32)
> fan_input3:
>              0 RPM  (min =  375 RPM, div = 16)
> temp_input1:
>             +390??C  (limit =   +0??C, hysteresis =   +0??C) sensor > thermistor
> temp_input2:
>           +480.0??C  (limit =   +0??C, hysteresis =   +0??C) sensor > PII/Celeron diode
> temp_input3:
>           +2080.0??C  (limit =   +0??C, hysteresis =   +0??C) sensor > thermistor
> vid:      +1.350 V
> alarms:
> beep_enable:
>           Sound alarm disabled
> 
> I'll leave it to you to figure out RPM and temperatures.
> 
> New patch included.
> 
>         Danny
> 
> 
>                      Name: diff-to-cvs.gz
>    diff-to-cvs.gz    Type: application/x-gzip
>                  Encoding: base64
