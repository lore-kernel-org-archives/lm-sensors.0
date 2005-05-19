From: ajohnson@lastaccess.com (Andrew D. Johnson)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <1088168375.2s9gci2o0vy8@lastaccess.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri 25 Jun 2004 06:37:16 AM CDT Jean Delvare <khali@linux-fr.org> said:
> >CPU0 Temp:  +127 C  (low  =   -55 C, high =  +127 C)   OPEN
> >CPU0 Crit:  +127 C ALARM
> >CPU1 Temp:  +127 C  (low  =   -55 C, high =  +127 C)   OPEN
> >CPU1 Crit:  +127 C ALARM
> >S-IO Temp:   +83 C  (low  =   -55 C, high =  +127 C)   ALARM
> >S-IO Crit:  +127 C
>
> This clearly means that your system doesn't use thermal diodes. It would
> be interesting to try thermistors. The driver relies on a Super-I/O
> configuration bit to decide what to use. Unfortunately it says "thermal
> diodes" here, which is why the driver decided to enable these. My
> driver may need a parameter to force the use of thermistors.
>
> For now, let's try to do it manually.
>
> First of all we want to disable temp1 and temp2 (thermal diode channels).
> First unload the driver, then:
>
> isaset -f 0x6649 0
> isaset -f 0x664a 0
> isaset -f 0x6649 1
> isaset -f 0x664a 0

Ok, I hit a snag running the second command here:

soekris1# isaset -f 0x664a 0
WARNING! Running this program can cause system crashes, data loss and worse!
I will write value 0x00 to address 0x664a
You have five seconds to reconsider and press CTRL-C!

Warning: Data mismatch, wrote 0x00, read back 0xcc

I stopped at this point.

> They look fine to me, except in0 and maybe in3. We'll now more when you
> use your configuration file again.

The configuration file I'm using is a slightly tweaked version of something you
had posted to a mailing list. I'll attach it. Below is the output I see from
sensors using it. It obviously still needs some tweaking. Some of the voltage
calculations must be inappropriate in this case. Is Soekris going to have to
let us know how the voltage inputs are wired before we can have any idea what
these represent?

soekris1# sensors
pc87366-isa-6620
Adapter: ISA adapter
+5V:       +8.50 V  (min =  +4.49 V, max =   5.50 V)       ALARM
Vcore:     +2.78 V  (min =  +0.00 V, max =   2.95 V)
+12V:     +23.54 V  (min = +10.83 V, max =  13.20 V)       ALARM
5VSB:      +0.00 V  (min =  +4.49 V, max =   5.50 V)       ALARM
Vsb:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
Vdd:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
Vbat:      +2.95 V  (min =  +2.40 V, max =   2.95 V)
AVdd:      +3.64 V  (min =  +2.99 V, max =   3.59 V)       ALARM
CPU0 Temp:  +127 C  (low  =    +0 C, high =   +70 C)   OPEN
CPU0 Crit:   +85 C ALARM
CPU1 Temp:  +127 C  (low  =    +0 C, high =   +70 C)   OPEN
CPU1 Crit:   +85 C ALARM
S-IO Temp:   +83 C  (low  =    +5 C, high =   +60 C)   ALARM
S-IO Crit:   +70 C ALARM
temp4:      -273 C  (low  =    +1 C, high =   +67 C)
temp4_crit:
            -273 C
temp5:      -273 C  (low  =    +1 C, high =   +67 C)
temp5_crit:
            -273 C
temp6:      -273 C  (low  =    +1 C, high =   +67 C)
temp6_crit:
            -273 C

> I'll do a few fixes to the driver this evening, including more debugging
> messages, this should help us deal with the temperatures. I'll let you
> know when I have something for you to test.

Thanks much,

--
Andrew D. Johnson
PGP Fingerprint: 77BD 80B1 4918 1D98 9EBF 2E62 073B 9B31 A1DC 41F4
KeyID: 0xA1DC41F4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors.conf.gz
Type: application/x-gzip-compressed
Size: 885 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040625/9a61f4c9/sensors.conf.bin
