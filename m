From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Temperatures on Gigabyte GA-8PE667
Message-Id: <20041219143443.09ecd767.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <JA8AAAAAA4jS8QABYQABj6DB09hU@proteusworld.com>
In-Reply-To: <JA8AAAAAA4jS8QABYQABj6DB09hU@proteusworld.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sebastian,

FYI, lm78@ is an alias on sensors@. No need to send the same message
twice ;)

> I was wondering if anyone on this mailing list has managed to properly
> read temperatures on a Gigabyte GA-8PE667 mainboard or similar?
> 
> I have lm_sensors 2.8.7 installed and working, but the CPU and MB
> temperatures (temp1 and temp2) are definetly wrong. With sensors type
> set to 2 (thermistor), both temps always say 25 degrees Celsius,
> regardless of CPU load.

As far as I remember, thermistors have their nominal resistance known at
25 degrees Celcius, and the temperature is computed using a voltage
divisor involving a (non-thermistor) resistor of the same value. So this
value of 25 degrees may not be exactly random, it could mean that no
thermistor are used and the inputs have been "neutralized" using regular
resistors.

> The only source with a little more info on this topic I found at:
> http://www.livewiredev.com/bbs/showthread.php?s=&postid766
> 
> However, they discuss over there only about voltage readouts. There
> are two mentions about temperatures, both stating the same problems as
> I have.

I found this:
http://www.hardwarebg.com/reviews/gigabyte/8pe667ultra/pics/bios_vcore.jpg

This probably confirms my original thoughts. The BIOS only shows one
temperature (temp3, obviously). I don't think that the two other
temperature inputs are wired at all. There's nothing we can do about
this. You can try asking Gigabyte for confirmation.

> I am sure the sensors work on my mainboard because some time ago I had
> Windows on the machine and Gigabyte's EasyTune utility was showing
> proper temperatures.

Interesting. However, without the source or info from Gigabyte, there's
not much we can do. Maybe some extra, board-specific step is required to
enable the readings? I can't tell. That's not something we can guess.
Either Gigabyte tells you, or you will have to live without the values
(the CPU temperature is the most important temperature anyway).

> Any help on this matter would be greatly appreciated. This machine is
> my home server and I want to reduce the noise volume, but I can't
> safely do that without being able to check if the system is indeed
> properly cooled.

I understand your needs, but we just can't do anything without
additional data that only Gigabyte could provide - and this is if there
*is* a way to get the readings. Maybe there isn't at all.

-- 
Jean Delvare
http://khali.linux-fr.org/
