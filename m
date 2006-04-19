From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Wed, 19 Apr 2006 23:02:25 +0000
Subject: [lm-sensors] Black box flight recorder for Linux
Message-Id: <m3r73t6uf2.fsf@defiant.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <44379AB8.6050808@superbug.co.uk>
	<m3psjqeeor.fsf@defiant.localdomain> <443A4927.5040801@warmcat.com>
	<m3odz9kze6.fsf@defiant.localdomain>
	<m364l5dep9.fsf@defiant.localdomain> <44469BA3.2090309@sh.cvut.cz>
In-Reply-To: <44469BA3.2090309@sh.cvut.cz> (Rudolf Marek's message of "Wed, 19 Apr 2006 22:20:51 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@sh.cvut.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, Andy Green <andy@warmcat.com>, lm-sensors@lm-sensors.org

Rudolf Marek <r.marek at sh.cvut.cz> writes:

>> No wonder my first attempt with 24C16 which occupies all 0x50 - 0x57
>> addresses had to fail.
>
> Hm that should work, because Asus most likely multiplexes physical lines
> instead of devices (using 74HC4052 IIRC)

No, the motherboard thought that my 24C16 was a set of 3 DIMMs
(answering at 0x50 - 0x57, and DIMMs seem to be at 0x50, 0x51 and 0x52).
Of course the data read back was some product of both DIMM EEPROM and
my 24C16 but the machine didn't pass POST.

I think anyone trying to connect an EEPROM to SMBus has to make sure
there is nothing there, and nothing is expected by things like BIOS.
Not a very plug and play.

> What about to connect the device to parallel port, there are some adapter
> schematics in kernel docs.

Sure, that's one of the options.
-- 
Krzysztof Halasa

