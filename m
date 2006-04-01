From: harald.dunkel@t-online.de (Harald Dunkel)
Date: Sat, 01 Apr 2006 13:59:22 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <442E873A.1000504@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <44144A01.2050207@t-online.de>
In-Reply-To: <44144A01.2050207@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
>>
>> Using "fintek F75387SG" I found this on Google:
>>
>> http://www.fintek.com.tw/files/productfiles/F75387_025P%20datasheet.pdf
>>
>> BTW, my PC is an Aopen MZ915-M .
> 
> Good catch. This is, indeed, the chip that sensors-detect spotted at
> address 0x2d. I just modified this script so that it now knows about
> more Fintek chips. Please give it a try:
> http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/prog/detect/sensors-detect
> 
> It should properly identify your F75387SG/RG chip at 0x2d now.
> 

Yup:

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 5000'
    Busdriver `i2c-i801', I2C address 0x2d
    Chip `Fintek F75387SG/RG' (confidence: 7)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)

> I still don't know what is the other Fintek chip at 0x2f. Its it
> doesn't match any ID I could find in the datasheets, but it's similar
> enough to the F75121R and F75122R/RG ID that I'd bet for some VID
> and/or GPIO chip. My contact at Fintek told me it was a "power
> control", I hope to have additional information soon. Maybe you can
> take a look at your motherboard again in the meantime.
> 

This is some kind of "high-density" PC, i.e. it is hard to disassemble.
I was lucky that the first chip was easy to spot, but the second one
could be anywhere. I would suggest to postpone this to tomorrow.

"Power control" reminds me of something: Sometimes ACPI power off
doesn't work. Do you think this is a related problem?

> So, the good news is that we now know what hardware monitoring chip you
> have. This explains why the W83627THF chip was not reporting the values
> you were expecting.
> 
> The bad news is that we have no driver for this chip at the moment.
> I've added it to our "New drivers" page, together with a few other
> Fintek chips. You'll have to wait for a driver to be written, or write
> it yourself. Any amount of support (work, money, hardware...) you can
> offer is likely to speed up the process.
> 

Creating a driver on my own sounds pretty cool. Probably it is
allowed to use an existing driver as a template?


Regards

Harri


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 254 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060401/825477b4/signature-0001.bin
