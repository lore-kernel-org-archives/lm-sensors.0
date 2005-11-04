From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 04 Nov 2005 10:11:43 +0000
Subject: [lm-sensors] lm-sensors install changed/corrupted
Message-Id: <j4pRiGvD.1131094719.9293590.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <43699477.5000809@earthlink.net>
In-Reply-To: <43699477.5000809@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi David,

On 2005-11-04, David Haertig wrote:
> Now the sensors program is reporting good data, more or less.
> Below are the results from sensors and the results that BIOS
> reports during boot.  Looks like the it8712 section gets the two
> fan speeds correct, and some of the voltages.  Notable is that
> the it8712 reports the +3.3 as +6.5 whereas BIOS reads the +3.3
> as +3.23

Take a look at /etc/sensors.conf should, there's a beautiful comment in
the it87-* section about that problem exactly:

  # If 3.3V reads 2X too high (Soyo Dragon and Asus A7V8X-X, for example),
  # comment out following line.
     compute in2   2*@ , @/2

Given the number of times users reported about this, I wonder if we
shouldn't comment out that line by default.

> If you ignore the it8712 bad readings on -5 and -12
> (these seem totally bogus), the rest of the it8712 voltage
> readings look good.

It's quite frequent that negative voltage lines are not monitored (as
stated in our FAQ). I'm not even sure these lines are used on modern
systems. If the BIOS doesn't list them, they are probably not wired for
monitoring. Add the following to your configuration file:

   ignore in5
   ignore in6

And comment out the set in{5,6}_{min,max} lines.

> The it8712 gets all the temperatures wrong however.
>
> Scroll down to the lm90 section and you'll see good readings
> for both the CPU and system temps.

No surprise here, it all makes sense. They wanted to use a dedicated chip
for temperature monitoring (LM90), so they don't use the IT8712F
temperature monitoring feature. You may try changing the sensor types
between 2 (thermistor) and 3 (diode) and see if it provides plausible
measurements, but chances are it won't.

You can set the thermal sensor types to 0 to disable these inputs, add
"ignore" statements and comment out the "set" statements.

> The eeprom section looks pretty useless to me, but the data
> it reports is correct.  I didn't know you needed a "sensor"
> to tell you how much memory you have!  ;-)

Future versions of libsensors will not show non-hardware-monitoring chips
anymore. Eeproms were listed for historical reasons.

--
Jean Delvare
