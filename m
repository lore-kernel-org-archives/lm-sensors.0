From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Wed, 14 Sep 2011 18:45:31 +0000
Subject: Re: [lm-sensors] please help - sensors gives various ALARM but my
Message-Id: <2EF5E7BC479D43A88A414AFB9B516E12@portable2>
List-Id: <lm-sensors.vger.kernel.org>
References: <13133530.6959691316023010840.JavaMail.defaultUser@defaultHost>
In-Reply-To: <13133530.6959691316023010840.JavaMail.defaultUser@defaultHost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,
>
>From: corradoventu@libero.it
>Sent: Wednesday, September 14, 2011 7:56 PM
>To: sensors
>Subject: [lm-sensors] please help - sensors gives various ALARM but my 
>chipset w83697hf is listed as supported
>
>
>sensors gives various ALARM but my chipset w83697hf is listed as supported
>
>in: http://www.lm-sensors.org/wiki/Devices
>    W83627HF, W83637HF, W83627THF, W83697HF yes    w83627hf LPC 2.6.5
>my PC works fine ...
>the following messages are from UBUNTU Oneiric but I have similar messages 
>from Natty and Maverick
>
>may you help me?
>thanks
>
>corrado@corrado-oneiric:~$ uname -r
>3.0.0-11-generic
>corrado@corrado-oneiric:~$ sensors -v
>sensors version 3.3.0 with libsensors version 3.3.0
>corrado@corrado-oneiric:~$ sensors
>coretemp-isa-0000
>Adapter: ISA adapter
>Core 0:       +52.0°C  (high = +78.0°C, crit = +100.0°C)
>Core 1:       +52.0°C  (high = +78.0°C, crit = +100.0°C)
>
>w83697hf-isa-0290
>Adapter: ISA adapter
>in0:          +1.31 V  (min =  +0.74 V, max =  +0.06 V)  ALARM
>in2:          +3.23 V  (min =  +0.70 V, max =  +1.22 V)  ALARM
>in3:          +3.02 V  (min =  +2.69 V, max =  +2.13 V)  ALARM
>in4:          +2.96 V  (min =  +1.62 V, max =  +0.38 V)  ALARM
>in5:          +3.07 V  (min =  +1.60 V, max =  +1.18 V)  ALARM
>in6:          +3.18 V  (min =  +0.35 V, max =  +1.79 V)  ALARM
>in7:          +3.30 V  (min =  +0.13 V, max =  +0.51 V)  ALARM
>in8:          +3.41 V  (min =  +0.32 V, max =  +1.09 V)  ALARM
>fan1:           0 RPM  (min = 3668 RPM, div = 8)  ALARM
>fan2:        2596 RPM  (min = 2343 RPM, div = 8)
>temp1:        +40.0°C  (high = +53.0°C, hyst = +60.0°C)  sensor = 
>thermistor
>temp2:        +38.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = 
>thermistor
>beep_enable: enabled

sensors is doing what it should. You actual values are outside the limits so 
it's alaming.

Edit your sensors3.conf file (/etc/sensors3.conf)

Look for the section for your chip (w83697hf)

and add the min/max alarm limits for each input. So for example for in0 add 
the following lines
    set in0_min 1.2
    set in0_max 1.5

and for fan1 just add
  ignore fan1

after running sensors -s, it should use the new alarm limits

Regards
Ian Dobson


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
