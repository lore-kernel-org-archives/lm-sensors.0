From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: Some thoughts about the sysfs interface (repost)
Message-Id: <20031109125157.51f9d552.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

(Same player, try again, *with* the patch, that time.)

I had to update the doc/developers/proc document for the lm83 driver (it
has four temperature channels). The same change will be needed when the
driver makes it into Linux 2.6. Greg, attached is a patch I suggest you
apply at the same time you'll apply my lm83 patch to Linux-2.6.0.

Some points I'd like to discuss about:

1* Most entries are described using sentences like "Fixed point value in
form XXXXX and should be divided by 1000 to get degrees Celsius". I
don't understand the "fixed point" thing, nor do I understand the
informational value of "in form XXXXX". Wouldn't it be much clearer to
write "Integer value, thousandth of degrees Celsius"?

2* temp_min[1-3] reads: "Temperature min or hysteresis value.". This is
a Bad Idea (TM) IMHO. One very interesting point in the sysfs interface
over the procfs one is that it could be easily be made chip-independant
(libsensors and sensors could then be drastically simplified). If the
file is named temp_minN, it has to be a min temp. Be it a hysteresis
one, let's call the file temp_hystN instead. It's in no way harder to do
it that way, and it will be way easier for the interface users
(includind ourselves) if we stick to the one name, one use philosophy.

3* One additional note about hysteresis temperatures (and critical
temperatures also). Some chips have several temperature channels, but a
single hysteresis and/or critical temperature register, common to all
channels. For example, the LM83 has four temperature channels, four max
values, but one single critical value. The ADM1032 has two temperature
channels, two min values, two max values, two critical temperatures, but
a single, relative hysteresis value that applies to both critical
values.

I propose that chips that values that are common to all channels simply
have no digit appended. That's how I made it in the lm83 driver.

Now, for the hysteresis, that's more complicated, since not only it may
apply to one or more channels, but it can also happen to one or more
limit, and be relative or absolute. I think that hysteresis files should
be named after the limit they are an hysteresis for. In the case of the
lm90 driver, we would have the following files:
  temp1_input
  temp2_input
  temp1_min
  temp2_min
  temp1_max
  temp2_max
  temp1_crit
  temp2_crit
  temp_crit_hyst
Note that the digit is also omitted, since the value is common to both
channels. An hysteresis that would apply to all temperatures of one
channel would be named "temp1_hyst". An hysteresis that would apply to
more than one channel and more than one limit for each channel would be
called temp_hyst. I think you get the idea.

Remains the problem of relative hyst vs. absolute hyst temperature. The
docs say we should prefer absolute, but in the case of the lm90 driver,
it isn't possible (because the hysteresis value applies to two critical
limits that can have different values). The only thing I can think of is
having different names again. For example, relative hysteresis would be
appended _rhyst while absolute ones would be appended _ahyst (or simply
_hyst if we want to provide some kind of backward compatibility, or if
we consider that absolute values are the default).

A very different approach would be to simulate as much values as we
need, regardless of how many registers there are. In the case of the
lm83 driver, we would have temp1_crit and temp2_crit instead of
temp_crit, and both files would access the same register. The advantage
of this method is that all future chips will necessarily be supportable,
which isn't the case with my first proposal. We could imagine a chip
that has four temperature channels, one critical limit for channels 1
and 2, and one critical limit for channels 3 and 4. That's something my
first model doesn't handle, while the second does. I can say how likely
it is to see such a chip someday. All other scenarios I can think of at
the moment are OK with that first model. The drawbacks of the second
method are: we break the one-one link between sysfs and the hardware
(which helps a lot to understand how a chip works, IMHO), we create more
sysfs entries, and writing to a register might have side effects to the
other registers (might be already happening in some cases anyway).
Another good point is that it solves the relative hysteresis problem
mentioned above.

Other possibilities may exist (might involve symlinks for example). It
would be great to come to a decision before going on with porting chip
drivers, methinks.

Everyone let me know your opinion about the topic, should you have one.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
--- linux-2.6.0-test9/Documentation/i2c/sysfs-interface	Sun Nov  9 11:13:32 2003
+++ linux-2.6.0-test9/Documentation/i2c/sysfs-interface.lm83	Sun Nov  9 12:40:48 2003
@@ -144,7 +144,7 @@
 		Integers 1,2,3, or thermistor Beta value (3435)
 		Read/Write.
 
-temp_max[1-3]	Temperature max value.
+temp_max[1-4]	Temperature max value.
 		Fixed point value in form XXXXX and should be divided by
 		1000 to get degrees Celsius.
 		Read/Write value.
@@ -156,13 +156,22 @@
 		NOT a delta from the max value.
 		Read/Write value.
 
-temp_input[1-3] Temperature input value.
+temp_input[1-4] Temperature input value.
+		Fixed point value in form XXXXX and should be divided by
+		1000 to get degrees Celsius.
 		Read only value.
 
+temp_crit	Temperature critical value, typically greater that all
+		temp_max values.
+		Fixed point value in form XXXXX and should be divided by
+		1000 to get degrees Celsius.
+		Common to all temperature channels.
+		Read/Write value.
+
 		If there are multiple temperature sensors, temp_*1 is
 		generally the sensor inside the chip itself, generally
-		reported as "motherboard temperature".  temp_*2 and
-		temp_*3 are generally sensors external to the chip
+		reported as "motherboard temperature".  temp_*2 to
+		temp_*4 are generally sensors external to the chip
 		itself, for example the thermal diode inside the CPU or
 		a thermistor nearby.
 
