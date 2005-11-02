From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 02 Nov 2005 12:54:18 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch, review
Message-Id: <4368AA39.4080603@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
>>That is most likely the case with the uGuru (I know I would have read
>>protected it). We could try to get the code out of a firmware update,
>>but there don't seem to be any firmware updates, the bios updates use a
>>standard awardflash program which (AFAIK) is not aware of the uGuru chip
>>and the size of the bios updates also is a power of 2, which makes it
>>unlikely that they also contain firmware for the uGuru.
> 
> 
> I think this can be part of BIOS image. I can try to expand the image and examine the files inside
> do you know any "classical" byte sequence of microchip 051 opcodes?
> 
> I looked to the winbond datasheet and it seems they provide a way to read the flash.
> I did not check if this can be disabled on the other hand...
> 

I didn't check either but I really don't know any microcontrollers for 
which the external reading of flash cannot be disabled, since most 
people like to keep there software propietary it is kinda hard to sell 
microcontrollers which can always be read externally. Also even if it is 
not read protectected you still need access to certain pins, which 
usually have more then 1 use, AFAIK these pins have not been connected 
to a header on the motherboard, so getting to them will be hard.

I find it unlikely that the bios holds the firmware it could be that the 
bios checks the firmware version of the uGuru and updates it if 
nescesarry, although that is rather tricky flashing a microcontroller 
take atleast 10-15 seconds, and a user could loose its patience and hit 
the reset switch. Even more problematic: during the reprogramming the 
microcontroller including pwm outputs etc stops running, since the uGuru 
controls cpu and ram voltages stopping it would be a BAD idea.

I really think that the uguru gets programmed once and is not meant to 
be updated through software, which also means that the ISP (in system 
programming) pins could have been reused for another purpose.

Although it is a nobel cause to try and get your hands on the firmware I 
don't think it is worth the trouble. My current driver supports the 
sensors part of the uGuru quite well. Although it would be nice to know 
how the uGuru really works instead of just using the magical multipliers 
for the register values the windows software use, using these 
multipliers actually works quite well.

Also by using Abit's algorithm's and not creating our own based on 
hardware specs, we get the exact same readings as the BIOS and window 
apps, giving the end user a nice fuzzy warm feeling that everything 
makes sense.

I know that there is a dislike among the lm_sensors developers against 
not having the exact hardware specs but in practice, we never have. Even 
if we have the sensorschip datasheets we still don't know how the 
motherboard manufacturer has hooked the sensorchip up.

Actually I have used lm_sensors for a long time and my current uGuru 
driver gives the most believable readings of all my setups all my 
previous (asus) motherboards always had a couple of readings which were 
significantly different from the BIOS, and those from the BIOS where 
more realistic imho.

I guess that we just have to accept that there will always be some guess 
work in lm_sensors, untill motherboard manufacturers start giving away 
full specs including schematics. Actually with things like using the 
asus acpi interface to sensors the blackbox factor is only going to get 
worse not better. But things will get better for the end user.

I'm a big believer of opensource and openness in general for both soft- 
and hardware (where are the good old days your radio/tv would come with 
full schematics?) but in the end I'm also pragmatic and when I have to 
choose between a blackbox approach to support XXX or bad/no support at 
all I choose for a blackbox approach*

Regards,

Hans

* going offtopic: One of the reasons for me to choose for a blackbox 
approach if nescesarry is because I want Linux or more general 
open-engineering to succeed, I really wish everything would be fully 
open. But untill that day we need todo what we can to support as much 
hardware as possible, so that people will be able to switch to an 
opensource OS, whatever their hardware. Once opensource has a 
significant place in the marketplace hopefully hardware will become more 
open too.
