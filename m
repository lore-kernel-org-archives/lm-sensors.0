From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 03 Dec 2013 16:37:54 +0000
Subject: Re: [lm-sensors] Strange sensor values ASUS M5A97 Pro
Message-Id: <20131203163754.GB16048@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4a2b86669bfcfeb87b592fc7bb443eb0@secure.lordvan.com>
In-Reply-To: <4a2b86669bfcfeb87b592fc7bb443eb0@secure.lordvan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 03, 2013 at 04:12:45PM +0100, Thomas Raschbacher wrote:
> On 2013-12-02 20:48, Guenter Roeck wrote:
> >On Mon, Dec 02, 2013 at 08:23:15PM +0100, Thomas Raschbacher wrote:
> >>On 2013-12-02 19:10, Guenter Roeck wrote:
> >>>On Mon, Dec 02, 2013 at 10:49:24AM +0100, Thomas Raschbacher wrote:
> >>>>Hi.
> >>>>
> >>>>I get rather strange values for temperature ranges:
> >>>>
> >>>>it8721-isa-0290
> >>>>Adapter: ISA adapter
> >>>>in0:          +2.84 V  (min =  +1.54 V, max =  +0.84 V)  ALARM
> >>>>in1:          +2.80 V  (min =  +1.33 V, max =  +0.54 V)  ALARM
> >>>>in2:          +1.02 V  (min =  +0.56 V, max =  +1.86 V)
> >>>>+3.3V:        +3.24 V  (min =  +4.58 V, max =  +5.95 V)  ALARM
> >>>>in4:          +2.05 V  (min =  +2.66 V, max =  +0.91 V)  ALARM
> >>>>in5:          +2.50 V  (min =  +1.51 V, max =  +1.67 V)  ALARM
> >>>>in6:          +1.80 V  (min =  +1.09 V, max =  +2.27 V)
> >>>>3VSB:         +0.70 V  (min =  +4.56 V, max =  +4.46 V)  ALARM
> >>>>Vbat:         +3.34 V
> >>>>fan1:        2213 RPM  (min =   12 RPM)
> >>>>fan2:        1336 RPM  (min =   13 RPM)
> >>>>fan3:        1300 RPM  (min =   12 RPM)
> >>>>temp1:        +45.0 C  (low  = -36.0 C, high = -36.0 C)  ALARM
> >>>>sensor = thermistor
> >>>>temp2:        +51.0 C  (low  = +91.0 C, high = -93.0 C)  ALARM
> >>>>sensor = thermistor
> >>>>temp3:       -128.0 C  (low  = -11.0 C, high = +94.0 C)  sensor > >>>>disabled
> >>>>intrusion0:  OK
> 
> Actually I was just thinking ... somethign is not right with those
> values anyway ..
> 
> I mean look at the voltages ..t he only one that sounds vaguely
> reasonable is the 3.3V one .. and one of the other ones might be CPU
> ..
> but where is the CPU one ..
> 
> also i got 2 chassis fans (and the bios can show all values properly)
> 
> So I got a missing fan value and voltages that don'T make sense ..
> any clue what to do about this?
> 
Voltages have to be scaled.

Useful resources:
	http://www.lm-sensors.org/wiki/AsusFormulaHacking
	http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling
	http://www.lm-sensors.org/wiki/Configurations/Asus

As for the missing fan speed, many ASUS boards implement GPIO based multiplexers
to support additional fans. Those multiplexers are not supported in Linux.
Since ASUS does not release specifications, there is little chance to ever add
support for those multiplexed fans.

Asking ASUS for support won't help, since ASUS officially does not support Linux
on its desktop boards.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
