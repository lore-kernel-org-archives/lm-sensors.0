From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <1082970828.408cd2ccbdde1@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> lm_sensors2 cvs 04/25/04 @ 8:30 est

8:30 PM I suppose?

> I haven't been able to notice any changes from yesterday's cvs, but
> I probably don't know exactly what to look for.

Nothing visible actually. There were a few fixes but other, more
important problems were still there, obviously.

> I cat'ed around in my /proc/sys/dev/sensors/pc87366-isa-ecc0 area,
> and the temperatures reported seem to be accurate farhenheit
> temperatures, but I don't know if this is coincidence.
> My bios only shows 1 temperature reading, and it says exactly: CPU 
> Temperature  46 C / 114.5 F (and the numbers keep rising).

It is a coincidence, see below.

> Here are the outputs of the isadumps:
> output of isadump 0x2e 0x2f 0x09 7
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> (...)
> f0: fc 07 07 00 00 00 00 00 00 00 00 00 00 00 00 00
      ^^^^^
Fan control is inverted, see below.

> I used the echo command to set the fan divisors for fans 1 and 2 to 1
> 2.  I get more updates, and they are very close to what my bios
> reports:
> CPU Fan Speed   3614RPM
> System Fan Speed 2194RPM

Great. At least this is working.

> I also tried echoing minimum values for these fans (3000 and 1500
> for fans 1 and 2) but nothing changed in sensors, but the proc
> entries for fan1 and fan2 did get updated. I echoed a value of 3000
> for fan2, but only the proc fan2 file got updated,

Sounds like a bug but I couldn't find it. Please provide the output of
"sensors", "sensors -u", "ls -l /proc/dev/sys/sensors/pc87366-isa-ecc0"
and "cat /proc/dev/sys/sensors/pc87366-isa-ecc0/*" at a given time
(after setting fam_min limits). This should help me determine whether
the bug is in libsensors or sensors itself.

> and no physical change (I was guessing that if I upped the minimum
> value, i could increase the speed). It might already be at a maxed
> out speed, so is there a way to test the fans by decreasing the
> speed?

No, it simply doesn't work that way. The fan min limit simply
determines
below which speed an alarm will be triggered. It doesn't tell the fan
to change speeds (this is what PWM is for).

> pwmconfig can still turn off the fans, but there are still overflow 
> messages in "sensors" and they don't go away (I left the computer
> idle for about half an hour to see if there would be any change).

As mentioned above, the fan speeds are inverted on your chip. This
means
that 0 is full speed and 255 is minimal speed, while most chips work
the other way around. The driver wasn't handling that case, which is
why pwmconfig was missing the point. I've fixed that (will commit this
evening). I don't know if it'll fix the overflow flags, please let me
know.

> temp1:      +128 C  (low  =  +201 C, high =    -1 C)
> temp1_crit:
>             +201 C
> temp2:      +128 C  (low  =  +201 C, high =    -1 C)
> temp2_crit:
>             +201 C
> temp3:       -76 C  (low  =  +201 C, high =    -1 C)
> temp3_crit:
>             +201 C

I've found the bug for these. It's even more stupid than the first
time... The temperature conversions were dead broken, it's now
hopefully fixed. There was also a bug with overtemperature (crit) limit
being read in the min limit register, which I fixed too. The output of
sensors should now read:

temp1:        +0 C  (low  =   -55 C, high =  +127 C)
temp1_crit:
            +127 C
temp2:        +0 C  (low  =   -55 C, high =  +127 C)
temp2_crit:
            +127 C
temp3:       +52 C  (low  =   -55 C, high =  +127 C)
temp3_crit:
            +127 C

> I am wondering where all this chip is measuring the temperature; my
> bios reports only the cpu temp.

Now you see, it does only really report one temperature. I'm a bit
surprised though, since temp3 is supposedly the PC87366's own
temperature, not an external one. If you confirm that the values are
inline with what the BIOS says, then either your BIOS is lying, or the
PC87366 datasheet is (or I read it wrong).

If you have an extra fan (or a hair dryer) and have a physical access
to
the system, it can be fun and useful to try to change the PC87366
environemental temperature, then do the same with the CPU, and see for
which one the temperature response of temp3 is the more relevant.

> I am going to go and see if there is a bios update for my
> motherboard (my bios is an AwardBios on an Asus board) so that I
> can see other sensor readings.

Yeah, it would help.

> If there is anything specific you guys would like me to do, I will 
> gladly see to it.

Test my new fixes after I commited them. I'll let you know when it's
ready.

Thanks!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
