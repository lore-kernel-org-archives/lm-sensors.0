From: lists.lm-sensors@duinheks.xs4all.nl (lists.lm-sensors@duinheks.xs4all.nl)
Date: Fri, 25 Nov 2005 12:45:17 +0000
Subject: [lm-sensors] ALARM messages - why ?
Message-Id: <20051125114444.819C4D7D9@duinheks.xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051121154527.6F4D34BEC5@duinheks.xs4all.nl>
In-Reply-To: <20051121154527.6F4D34BEC5@duinheks.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Jean,

Op 22 Nov 05 schreef Jean Delvare aan johannes.beekhuizen@duinheks.xs4all:

 >> JD>     set in0_min 1.5 * 0.92
 >> JD>     set in0_max 1.5 * 1.08
 >> Why the 8% margin?
 JD> Why not? :) Our 10% default is a bit too permissive IMHO, I would expect
 JD> a good power supply unit to be within 5%. As I don't know what hardware
 JD> you have, I proposed 8% as a compromise.

OK, that's a good enough reason :)

 JD> The final choice is really up to you, depends on how good you
 JD> hardware is, and how picky you are.

I don't know how good my hardware is either :) The Intel mother board was 
recommended as being very reliable and good value for money. The original 
Intel power supply died quite soon, after a little more then a year. I don't 
even know which make the current one is. Our local computer shop only had one 
make and I can't get into town without help. What I like is that it hardly 
makes any sound. The main reason I got lm_sensors was that I saw the name very 
often in newsgroups and was just curious. But I like it a lot!

 >> JD> and the bogus +12V line should be gone.
 >> It has gone indeed. But the change causes another problem. Now
 >> 'sensors -s' reports an error: adm1025-i2c-0-2d: Can't access
 >> procfs/sysfs file for writing; Run as root?  After a cold boot and
 >> when I don't use i2cset I do not see this error. Any ideas?
 JD> Simply comment out the "set in4_min" and "set in4_max" lines in your
 JD> configuration file, and the error should disappear. The program is

That makes sense. I'm not very technical, otherwise I mihght have thought of 
it myself.

 JD> complaining that you are trying to set limits for a voltage channel
 JD> which the adm1025 driver no more has.

I believe you :)

 JD> If the i2cset command works OK, you should consider adding it in some
 JD> boot script on your system before the adm1025 driver is loaded.

It is.

 JD> Have you searched Intel's website for an updated BIOS? I believe this is
 JD> the BIOS' job to configure the chip properly.

I've got one, but found out that I don't have any working Dos boot diskettes 
any more.

 JD> Ideally, if the latest BIOS available doesn't configure the chip
 JD> properly, you should report the problem to Intel and ask them for an
 JD> updated BIOS. However, their site clearly states that this motherboard
 JD> is no more supported, so it's probably not even worth trying.

I won't bother...

Groetjes,

           Hans.

--- GoldED+/LNX 1.1.5/050823
 * Origin: The Wizard is using MBSE/Linux (2:280/1018)
