From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Jun 2007 20:53:37 +0000
Subject: Re: [lm-sensors] Change in reported CPU temperatures
Message-Id: <20070626225337.645b32d7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070613223645.40f82f42.rkimber@ntlworld.com>
In-Reply-To: <20070613223645.40f82f42.rkimber@ntlworld.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Richard,

On Mon, 25 Jun 2007 22:09:34 +0100, R Kimber wrote:
> On Mon, 25 Jun 2007 20:42:16 +0200
> Jean Delvare wrote:
> 
> > > IT8716 reports temp1 as 42C, though I'm not sure what it relates to.
> > 
> > What thermal sensor type does "sensors" report? If a diode, that would
> > be the CPU temperature. If a thermistor, more likely the temperature
> > in the CPU socket.
> 
> It doesn't say.  I've added the output of the sensors command at the
> end.  They are not explicitly set in sensors.conf and I don't know what
> they should be.

Hmm, output is broken, see below.

> Sensors gives:-
> 
> k8temp-i2c--5-c3

Are there really two dashes following each other? That would be a bug.
And the k8temp driver isn't an i2c driver anyway so it shouldn't be
displayed like that. Very odd.

> Adapter: PCI adapter
> Core0 Temp: 37.00 (temp1)
> Core1 Temp: 38.00 (temp3)
> 
> it8716-isa-0290
> Adapter: ISA adapter
> VCore: 0.98 (in0)
>   in0_min: 0.00 (in0_min)
>   in0_max: 4.08 (in0_max)
> VDDR: 3.25 (in1)
>   in1_min: 0.00 (in1_min)
>   in1_max: 4.08 (in1_max)
> +3.3V: 0.00 (in2)
>   in2_min: 0.00 (in2_min)
>   in2_max: 4.08 (in2_max)
> +5V: 4.84 (in3)
>   in3_min: 0.00 (in3_min)
>   in3_max: 6.85 (in3_max)
> +12V: 11.58 (in4)
>   in4_min: 0.00 (in4_min)
>   in4_max: 16.32 (in4_max)
> in5: 0.00 (in5)
>   in5_min: 0.00 (in5_min)
>   in5_max: 4.08 (in5_max)
> in6: 0.00 (in6)
>   in6_min: 0.00 (in6_min)
>   in6_max: 4.08 (in6_max)
> 5VSB: 4.87 (in7)
>   in7_min: 0.00 (in7_min)
>   in7_max: 6.85 (in7_max)
> VBat: 2.98 (in8)
> fan1: 1683.00 (fan1)
>   fan1_min: 0.00 (fan1_min)
> ERROR: Can't get feature `fan1_div' data!
> fan2: 0.00 (fan2)
>   fan2_min: 0.00 (fan2_min)
> ERROR: Can't get feature `fan2_div' data!
> fan3: 890.00 (fan3)
>   fan3_min: 0.00 (fan3_min)
> ERROR: Can't get feature `fan3_div' data!
> temp1: 35.00 (temp1)
>   temp1_low: -1.00 (temp1_low)
>   temp1_over: 127.00 (temp1_over)
> temp2: 33.00 (temp2)
>   temp2_low: -1.00 (temp2_low)
>   temp2_over: 127.00 (temp2_over)
> temp3: 3.00 (temp3)
>   temp3_low: -1.00 (temp3_low)
>   temp3_over: 127.00 (temp3_over)
> vid: 1.10 (vid)
> alarms: 25600.00 (alarms)
> sensor1: 3.00 (sensor1)
> sensor2: 2.00 (sensor2)
> sensor3: 2.00 (sensor3)

And this is pretty wrong. Basically, it means that you are using a
version of "sensors" which is older than your version of "libsensors".
This isn't supposed to happen. What does "sensors -v" report? You need
to sort this out if you want a better display of the monitored values.

> I don't know why I get the fan div error, there is
> set fan1_div 4
> etc., in sensors.conf.  Maybe I have the syntax wrong.

The IT8716F has 16-bit fan speed registers, so no fanX_div is needed.
You shouldn't have "set fanX_div" statements in your configuration file
- delete them.

If you upgrade "sensors" to match your libsensors version, these errors
will go away.

> I'm not sure the voltages are reported correctly, but I don't know
> anything about MB voltages
> BIOS says Vcore is 1.34v; 3.3v is 3.43v; 5v is 5.18v and 12v is 12.43v

These don't seem to match the output of sensors, probably the scaling
factors are not standard. You'd need to ask your motherboard vendor for
the correct scaling factors, or you can simply adjust the formulae in
sensors.conf to make them look roughly the same.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
