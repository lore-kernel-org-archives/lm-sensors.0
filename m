From: Sebastian Flothow <lists@flothow.de>
Date: Sat, 11 Aug 2007 22:29:56 +0000
Subject: Re: [lm-sensors] Andigilog aSC7621 on Intel 975XBX2 - mostly working
Message-Id: <c0b343af652d690dca0928841b30e907@flothow.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <92c1df30b17dfff3995ea85f5562ddfc@flothow.de>
In-Reply-To: <92c1df30b17dfff3995ea85f5562ddfc@flothow.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am 11. Aug 2007 um 22:57 Uhr schrieb George Joseph ((dev)):
> Oops...
> Turn off "Hardware monitoring chip debugging messages".  That's what's 
> causing it to not compile and I'll take a look at it.

Yeah, I just noticed this too, but you were faster to post it :)

With debugging turned off, it compiles nicely, even against 
2.6.16.52-xen.
After enabling PECI (why is it disabled by default?), and also enabling 
temp 6 through 8, I get these readings:

| temp1_input:34750
| temp2_input:39000
| temp3_input:38500
| temp4_input:-49000
| temp5_input:-49000
| temp6_input:-92969
| temp7_input:-31953
| temp8_input:-29969

So temp4 essentially duplicates temp5, while 6 through 8 seem to be 
random garbage for lack of real data. temp1-temp4 is always about 85 
degrees or slightly less, which makes sense.
I tried setting peci_domain to 1 in the hopes of getting separate 
readings for the CPU cores, but this behaves rather weird: temp4 reads 
-128 degrees, while temp5 retains the correct value, and all fans go to 
full speed.

BTW, there's a small mistake in the docs: it mentions files 
temp[5-8]_enable
however they're actually called peci_temp[5-8]_enable.

As to the fan readings:

| fan1_input:361
| fan2_input:357
| fan3_input:302
| fan4_input:300

1 and 2 are fine, but 3 and 4 are about half the correct value.
(This is just an estimate - the BIOS shows them at about 800 rpm, but 
the BIOS enables pulse stretching upon entering the monitoring screen, 
resulting in an audible speed increase, and the very first readings 
still show them at something in the 600 range.)
In fact, when reading the files repeatedly, they are sometimes, rarely, 
shown at about 600.
I then decided to twiddle pwm3_freq, which defaults to 10: When set to 
15 or 23, the readings seem pretty random. Set to 30, I get readings 
slightly below 600 most of the time, but sometimes it's too high (about 
900 to 1000). 38 is OK too, but the too-high values occur more often. 
Anything higher causes wrong readings almost all of the time, sometimes 
way beyond the fans' max speed. The high-frequency settings are 
unsuitable for 3-wire fans and result in a 0 reading.

So for now im running with pwm3_freq = 30, which seems to give correct 
readings most of the time, but this is just a kludge; it would be great 
to have support for pulse stretching in the drivers.

Voltage readings are fine.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
