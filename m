From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 05 Jul 2008 12:40:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: it87 support for 16-bit fan reading
Message-Id: <20080705144003.3bfa8421@neptune.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
In-Reply-To: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, 24 June 2008 "Andrew Paprocki" <andrew@ishiboo.com> wrote:
> I've reworked the code to just add a revision field as you noted and
> to only contain the 16-bit tach change. Please review and let me know
> what you think re: force enabling the fans via a module parameter
> bitmask or something similar.
> 
> Thanks,
> -Andrew  

I've run if for about 20 minutes on my system (Kino 690S1, IT8712F-S)
and FAN speed readings look fine (around 3200 RPM (with PWM control) for
CPU fan and 1500 for Artic Cooling self-regulated FAN)
The divisor files don't show up in sysfs anymore (as expected).

Andrew, do you have the links to docs for pre-8 revisions at
hand? The link on ITE homepage for datasheet revision 0.8.2 returns a
404 error...
I would like to check if there is any change regarding voltage
inputs as for change to FAN tacho register width. The voltage readings
reported by the driver look pretty improbable!

it8712-isa-0e80
Adapter: ISA adapter
VCore 1:     +1.17 V  (min =  +0.00 V, max =  +4.08 V)
VCore 2:     +0.82 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:       +3.01 V  (min =  +0.00 V, max =  +4.08 V)
+5V:         +4.92 V  (min =  +0.00 V, max =  +6.85 V)
+12V:        +4.99 V  (min =  +0.00 V, max = +16.32 V)
-12V:       -13.86 V  (min = -27.36 V, max =  +3.93 V)
-5V:         -3.11 V  (min = -13.64 V, max =  +4.03 V)
Stdby:       +4.95 V  (min =  +0.00 V, max =  +6.85 V)
VBat:        +3.26 V
fan1:       3183 RPM  (min =    0 RPM, div = 8)
fan2:       1520 RPM  (min =    0 RPM, div = 8)
CPU Temp:    +20.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = thermal diode
M/B Temp:    +48.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = thermal diode
cpu0_vid:   +1.550 V

Bruno

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
