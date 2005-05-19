From: Sean.Gilmour@analog.com (Gilmour, Sean)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: ADM1025 eval board
Message-Id: <F7CB408531C5264680C9E37DE4FE71A40483EA79@limkexm2.ad.analog.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1072174424.3fe815583d4bc@imp.gcu.info>
In-Reply-To: <1072174424.3fe815583d4bc@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

1* Looks like the ADM1025 evaluation board needs an external power
source. As far as I can see, there are only 3 pins used on the parallel
port, so no power can be drawn from it (as it is the case with the
ADM1032EB). What is strange is that the power LED sometimes *does* light
up as I plug the parallel port. How is it possible? Am I missing
something?

>No. The LEDs probably light because the board is somehow sourcing power from the printer port. A power supply is needed with this board. A power supply will also be needed with the ADT7468 eval board to drive the fans (the USB connector can source enough current for the board but not for the fans). I would recommend a 500mA 12V-15V PSU if you can get one.

Anyway I'll go and buy a power supply tomotrow, then I'll be able to
play with the board :)

2* Is there a fundamental difference between the ADM series and the ADT
series?
>No. A while ago, the 'temperature and system monitoring' devices group also incorporated the 'interface' group. This has split and interface products use the ADM prefix for their devices now while we use the ADT prefix. All of our older 'temperature and systems monitoring' devices will still retain the ADM prefix.

3* What does it take to a chip to be "ACPI-compliant"? For example the
ADM1032 is tagged "ACPI-compliant". I wonder what it has that other
chips don't.
>Basically this refers to the parts ability to ensure that PCs/servers are ACPI compliant with respect to hardware monitoring and the SMBus interface. 

The ADT7468EB is a monster! Impressive. I gave it a try using the USB
access. Quite complex in fact. I'd need to read the data sheet I guess.
One thing at a time though, and the ADM1025 has a higher priority.
>This is the latest and greatest device, in the next year you will start seeing a lot of these devices around.

4* Looks like it can be plugged in a PCI slot? Is it safe to use in a
regular PC?
>Yes. In most new PCs/motherboards an SMBus is available on at least one PCI slot. Plugging in the board into this slot will power up the board and connect it to the ICH SMBus (no more wires or soldering).

5* Is this chip likely to be found in computer systems?
>Yes, lots of them.

Regards,
Se?n.

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 19 January 2004 22:13
To: Gilmour, Sean
Cc: LM Sensors
Subject: Re: ADM1025 eval board

Hi Sean,

I receives the boards today. Everything is in order.

I'd have a few questions though:

1* Looks like the ADM1025 evaluation board needs an external power
source. As far as I can see, there are only 3 pins used on the parallel
port, so no power can be drawn from it (as it is the case with the
ADM1032EB). What is strange is that the power LED sometimes *does* light
up as I plug the parallel port. How is it possible? Am I missing
something?

Anyway I'll go and buy a power supply tomotrow, then I'll be able to
play with the board :)

2* Is there a fundamental difference between the ADM series and the ADT
series?

3* What does it take to a chip to be "ACPI-compliant"? For example the
ADM1032 is tagged "ACPI-compliant". I wonder what it has that other
chips don't.

The ADT7468EB is a monster! Impressive. I gave it a try using the USB
access. Quite complex in fact. I'd need to read the data sheet I guess.
One thing at a time though, and the ADM1025 has a higher priority.

4* Looks like it can be plugged in a PCI slot? Is it safe to use in a
regular PC?

5* Is this chip likely to be found in computer systems?

Thanks a lot for the boards :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/


