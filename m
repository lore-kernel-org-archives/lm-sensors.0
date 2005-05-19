From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <20040425112214.51656572.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I downloaded lm_sensors2 from cvs on 04/24/04 at around 7:30 EST. It 
> compiled and installed successfully on a 2.4.26 kernel with i2c 2.8.4.
>
> The sensors-chip driver for my pc87366 was detected by sensors-detect 
> and I can now see output from the driver using gkrellm or by output
> from "sensors". (Full output at the end of document)

Good news :)

> My BIOS only displays sensor information about my 2 fans and the 
> temperature of my cpu. The fan sensors are accurate, but the I do not 
> understand the temperature readings.
> 
> Bios reports cpu fan speed of between 3614 and 3840 rpm; sensors
> reports fan 1 to be 3750 rpm
> Bios reports case fan to be 2194 rpm; sensors reports 2142 rpm

I'm a bit surprised by the 3614 and 2194. These values are theoretically
impossible to obtain. The three other values, OTOH, are correct. All
reported values should correspond to 480000/N for an integer value of N.

Could you please provide a list of all the readings reported by the BIOS
and sensors for both fans?

> Oddity: Running pwmconfig will restart both my fans correctly, but 
> reports that "fan has not returned to speed". Rerunning sensors states
> that there is an overflow, and the rpm is reported to be -1. Also, I 
> only have 2 fans controlled by this nat.semi. chip, but pwmconfig
> speaks strangely of 3 fans, and controllers overlapping. (Output of
> pwmconfig at end of document).

It's a bit early to try pwmconfig and fancontrol. These scripts run too
many commands at a time to give us tha slightest chance to understand
what happens if anything goes wrong (which is the case).

The PC87366 can monitor up to three fans. It looks like yours only uses
two, but the driver doesn't care at the moment (and possibly the BIOS
did not disabled the third channel anyway). And maybe you can add an
extra fan in the case and it would then be monitored.

> As for temperatures, I am not certain how they are to be read. I do
> not think they are getting updated. Both the closed case and open case
> reveal the exact same temperature (according to gkrellm). I am not
> sure how to use the offset or factor, or how to determine what really
> is my temperature before using those to adjust the numbers.

The remperature reading should require no offset nor scaling.

I would have expected the error flags not to wear off, but it's odd that
the temperature itself doesn't. I will add flags cleaning in the driver,
let's see if it helps.

> Here is output of sensors (before pwmconfig):
> pc87366-isa-ecc0
> Adapter: ISA adapter
> in0:       +0.00 V  (min =  +0.07 V, max =   0.00 V)
> in1:       +1.36 V  (min =  +0.00 V, max =   2.97 V)
> in2:       +1.40 V  (min =  +0.00 V, max =   2.97 V)
> in3:       +0.02 V  (min =  +0.00 V, max =   0.05 V)
> in4:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
> in4:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
> in5:       +1.43 V  (min =  +0.00 V, max =   2.97 V)
> in6:       +1.46 V  (min =  +0.00 V, max =   2.97 V)
> in7:       +1.64 V  (min =  +0.00 V, max =   2.97 V)
> in8:       +0.09 V  (min =  +0.00 V, max =   0.00 V)
> in9:       +1.58 V  (min =  +0.00 V, max =   0.00 V)
> in10:      +1.63 V  (min =  +0.00 V, max =   2.97 V)

Some of these seem to be unused. This isn't surprising since the chip
has a so many voltage channels. in0_min, in3_input, in3_max and
in8_input are a bit surprising. The rest looks good. However, most
readings would need scalling, but the exact forumlae depend on the
motherboard. Since your BIOS doesn't seem to report them, there's not
much we can do. Let's concentrate on fans and temperatures, since your
BIOS provides values for these.

> fan1:     3529 RPM  (min =    0 RPM, div = 8)
> fan2:     2142 RPM  (min =    0 RPM, div = 8)
> fan3:       -1 RPM  (min =    0 RPM, div = 8)          OVERFLOW

Looks OK. However, divisors are way too high. It doesn't hurt, but you
would have more accurate readings with lower ones. I'd suggest a divisor
of 1 for fan1 and 2 for fan2:

echo "1 2" > /proc/sys/dev/sensors/pc87366-isa-ecc0/fan_div

Then you should see the values changing more frequently around the
average value.

You can also try setting min values:

echo 3000 > /proc/sys/dev/sensors/pc87366-isa-ecc0/fan1
echo 1500 > /proc/sys/dev/sensors/pc87366-isa-ecc0/fan2

> temp1:       +64 C  (low  =  +201 C, high =    -1 C)  ALARM
> temp1_crit:
>             +128 C
> temp2:       +19 C  (low  =  +201 C, high =    -1 C)
> temp2_crit:
>             +128 C
> temp3:       +19 C  (low  =  +201 C, high =    -1 C)  ALARM
> temp3_crit:
>              -79 C

Looks admittedly strange. Will investigate.

> Screenshot of gkrellm with all sensors turned on with default values
> for offset and factor:
> http://www.angelfire.com/ny3/mitechnologies/linux/snapshot6.jpeg

Gkrellm is of no interest actually. It doesn't know of the PC87366 at
all and obviously treats it in a generic way, applying arbitrary
conversions to the readings. Only the output of sensors is interesting
for now.

> If possible, I would like to know if the temperature readings are a
> bug or if there is way to adjust them to display correct temperatures
> (my bios never reads more than about 130 degrees fahrenheit or about
> 55 degrees celcius).

I would need you to provide the output of the following commands, so
that I can compare the values the chip really holds with what the driver
reports:

isadump 0x2e 0x2f 7 0x09
isadump 0x2e 0x2f 7 0x0d
isadump 0x2e 0x2f 7 0x0e

isadump -f 0xecc0
isadump -f 0xecd0
isadump -f 0xecf0

There are other outputs I would need but isadump needs a few
improvements before it works. I'll let you know when it's ready.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
