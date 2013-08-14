From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 14 Aug 2013 22:39:52 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <20130814223952.GA920@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 14, 2013 at 04:45:43PM -0400, Dev, Kapil wrote:

[ ... ] 

> Kapil: After making above changes, I think it seems to work now. Now I am
> getting following output from sensors:
> f71869-isa-0e80
> Adapter: ISA adapter
> in0:         +1.69 V
> in1:         +0.90 V
> in2:         +1.21 V
> in3:         +1.22 V
> in4:         +1.49 V
> in5:         +1.22 V
> in6:         +1.19 V
> in7:         +1.73 V
> in8:         +1.66 V
> fan1:       2177 RPM
> fan2:          0 RPM  ALARM
> fan3:          0 RPM  ALARM
> temp1:       +24.0 C  (high = +85.0 C, hyst = +81.0 C)
>                       (crit = +100.0 C, hyst = +96.0 C)  sensor = thermistor
> temp2:       +32.0 C  (high = +85.0 C, hyst = +81.0 C)
>                       (crit = +100.0 C, hyst = +96.0 C)  sensor = thermistor
> temp3:       +48.0 C  (high = +70.0 C, hyst = +68.0 C)
>                       (crit = +85.0 C, hyst = +83.0 C)  sensor = thermistor
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +4.5 C  (high = +70.0 C, crit = +70.0 C)
> 
> I believe temp1 from PCI adapter denotes the core-temperature? But, it is

Correct.

> definitely off by 20-30C; its hard to believe that the temperature would be
> 4.5C under fan based cooling system. I ran a SPEC hmmer benchmark and
> plotted the temperature over time. temp1 seems to change now. I am
> attaching the plots herewith.
> 
Yes, that is pretty common with AMD chips.

> Please let me know if there is a way to calibrate the core-temperature.
> 
Yes, you'll have to do it in /etc/sensors3.conf. Basically you'll have to
figure out what you think the real temperature is and add it to the raw
temperature provided by the driver.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
