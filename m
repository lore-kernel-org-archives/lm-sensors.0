From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 05 Jul 2008 14:22:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: it87 support for 16-bit fan reading
Message-Id: <20080705162245.1a1c498e@neptune.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
In-Reply-To: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sat, 05 July 2008 Jean Delvare <khali@linux-fr.org> wrote:
> I don't remember any change in the voltage computations. More likely
> you simply need to tweak your configuration file to match your
> motherboard wiring, as is the case with all motherboards. This
> includes changing the labels and adjusting the compute statements as
> well. We can help you a bit with this if you tell us all the voltage
> labels and values displayed by your BIOS, and the voltages values
> reported by "sensors -c /dev/null".

Raw sensors readings:

  it8712-isa-0e80
  Adapter: ISA adapter
  in0:         +1.17 V  (min =  +0.00 V, max =  +4.08 V)
  in1:         +0.82 V  (min =  +0.00 V, max =  +4.08 V)
  in2:         +3.01 V  (min =  +0.00 V, max =  +4.08 V)
  in3:         +2.93 V  (min =  +0.00 V, max =  +4.08 V)
  in4:         +1.25 V  (min =  +0.00 V, max =  +4.08 V)
  in5:         +1.76 V  (min =  +0.00 V, max =  +4.08 V)
  in6:         +1.60 V  (min =  +0.00 V, max =  +4.08 V)
  in7:         +2.94 V  (min =  +0.00 V, max =  +4.08 V)
  in8:         +3.26 V
  fan1:       3245 RPM  (min =    0 RPM, div = 8)
  fan2:       1520 RPM  (min =    0 RPM, div = 8)
  temp1:       +20.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = thermal diode
  temp2:       +48.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = thermal diode
  temp3:       +25.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = transistor
  cpu0_vid:   +1.550 V

Bios readings:

  CPU Temp: 33°C
  System temp: 45°C
  CPU FAN: 5769 RPM
  Sys FAN: 1496 RPM

  CPU Core: 1.1V
  +1.2V:   1.168V
  +3.3V:   3.008V
  +5V:     4.992V
  +1.8V:   1.76V

Looking at those values there could be:
  in0 = +1.2V
  in2 = +3.3V
  in5 = +1.8V

For the other voltages which do seem to be wired somehow even tough far less
are mentionned in BIOS monitoring section it's hard to tell what they could
match...


For temperatures:
- temp1 is related to CPU temp (no idea what's the right formula, looks
  like combination of offset and multiplier when compared to value
  reported by k8temp-pci-00c3)
- temp2 is system temp
- temp3 is constant at 25°C and probably not wired at all

Bruno

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
