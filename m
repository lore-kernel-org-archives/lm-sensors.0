From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 06 Feb 2011 01:00:02 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110206010002.GA27852@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Ian,
On Sat, Feb 05, 2011 at 04:46:22PM -0500, Ian Dobson wrote:
> 
[ ... ]
> 
> Not bad, the results look almost the same as the standalone "hack" driver 
> for the n6776 I'm working on, looks as if I can stop now. The only thing I'm 
> seeing is that on fan headers where no fan is attached I'm seeing 164RPM.
> 
Can you try again ? I updated the code to address the problem.

> The NCT6776F seems to use a 13-bit counter for the fans. The RPM formula is 
> RPM = 1.35e6 / count. The value 1.35e6 value might come from a 22.5 kHz 
> counter. Now if the counter reaches the maximum value, which is 8191 for a 
> 13-bit counter, we get exactly an RPM of 164.815041.
> 
> nct6776-isa-0290
> Adapter: ISA adapter
> in0:         +1.18 V  (min =  +0.95 V, max =  +1.26 V)
> in1:         +1.02 V  (min =  +0.90 V, max =  +1.20 V)
> in2:         +3.36 V  (min =  +3.01 V, max =  +3.50 V)
> in3:         +3.34 V  (min =  +3.01 V, max =  +3.50 V)
> in4:         +1.03 V  (min =  +1.00 V, max =  +1.10 V)
> in5:         +2.04 V  (min =  +1.90 V, max =  +2.00 V)   ALARM
> in6:         +0.80 V  (min =  +0.77 V, max =  +0.90 V)
> in7:         +3.42 V  (min =  +3.01 V, max =  +3.50 V)
> in8:         +3.30 V  (min =  +3.01 V, max =  +3.50 V)
> fan1:        530 RPM  (min =    0 RPM)  ALARM
> fan2:       1030 RPM  (min =    0 RPM)  ALARM
> fan3:        164 RPM  (min =    0 RPM)  ALARM
> fan4:        784 RPM  (min =    0 RPM)  ALARM
> fan5:        164 RPM  (min =    0 RPM)  ALARM
> temp1:       +23.0°C  (high = +35.0°C, hyst = +37.0°C)  sensor = 
> thermistor
> temp2:       -60.0°C  (high = +50.0°C, hyst = +55.0°C)  sensor = diode

This doesn't look good either. Can you report the raw values you get when reading
registers 0x150/0x151, 0x75/0x76, 0x152, and 0x200 ?

I have been wondering if I should retrieve the temperature values from 0x73/0x75/0x77.
This is another set of temperature registers supported by both chips and used as
fan monitoring source. 0x150 and 0x200 specify the temperature source for 0x151 and
0x75, respectively.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
