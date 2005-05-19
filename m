From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: 'sensors' never installed
Message-Id: <20030625111049.6d85972b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030615132841.54681.qmail@web40809.mail.yahoo.com>
In-Reply-To: <20030615132841.54681.qmail@web40809.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> because...
> 
> [root@localhost as99127f-i2c-0-2d]# cat < temp1 temp2
> temp3
> 60.0 50.0 22.0
> 60.0 50.0 112.2
> 
> it "eats" the output for the first value! don't ask me
> why, I am a linux noob. So I just wrote 'temp1' twice
> to be used as a dummy value. it means nothing.

This is because you don't *need* to use '<'. This is probably not the
place for a complete lesson about shell basics, but if you use "cat
temp1 temp2 temp3" (*without* the '<') you'll get what you want.

> I agree that temp1 is the motherboard temp in C. It
> agrees nicely with what the hardware monitor in my
> BIOS setup program displays. It also agree with the
> fact that temp1 computation doesn't exist in the
> sensors.conf file which has proven to be useless
> anyway.

At least one that is working :)

> For the processor, the BIOS program reports 58C/136F
> with case and HeatSink/Fan set to low. The minimum
> i've seen in the BIOS is 46C/114.5F with side door
> removed and proc/case fans set to highest. temp3 MIGHT
> have been close as F, EXCEPT for the fact that I just
> noticed it NEVER moves. I don't have any idea where it
> comes from. Temp2 is active, and SEEMS to be the
> processor, however, the original output of "26.0" or
> "22.0" is obviously miscalculated.

Temp3 may simply be not linked to anything. Most motherboards only have
two temperature sensors, one for the CPU and one for the motherboard.

> I think using that information, at the very least I
> should be able to interpolate the final values, but
> depending on the computation used to obtain "22/26",
> it may not be very accurate since when dealing with
> temperature, the value/starting point of 0 you would
> use when comparing two sets of values is meaningless,
> especially since I don't know if "22/26" is C, F, or
> neither.

This is a raw value, that is actually in "neither" unit, as you say. See
below for more details.

> NOTE: in the previous e-mail I incorrectly stated my
> mobo as A7V-266-E, when it is actually A7V-133-C. My
> Windoze computer is the A7V-266-E. Same sensor chip
> for both, so it doesn't change anything.

It changes much if you consider that I own an A7V133C here, which means
I *must* have a working config for it :)

(skipped, the last part which is pointless I think)

OK, Let's make things clear.

1* You *need* the "sensors" program to have your sensors working
correctly.

2* Compiling and installing the "sensors" program is easy, if not
trivial. The program is included in the source package you say you
downloaded and installed. It is installed by default in /usr/local/bin
when you run "make install".

So, you please carefully take another walk through the installation
process and see if anything fails there. Check in /usr/local/bin that
the program is installed. Check that /usr/local/bin is in your PATH
environment var ('echo "$PATH"' will let you know). If anything fails,
we can't guess what it is unless you give us a details log of what you
did and how the installation process behave.

For what it's worth, the correct temp2 formula for your motherboard is:
    compute temp2 @*2.0, @/2.0
Which means that the 22-26 values you are seeing are actually in a "2
deg C" unit. Your CPU must be living around 48 deg C (which makes
sense).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
