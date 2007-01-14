From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 14 Jan 2007 18:26:38 +0000
Subject: [lm-sensors] No smbus on asus w1n laptop in spite of quirk > no
Message-Id: <45AA75DE.3070304@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701071107.50461.christophe.dr@free.fr>
In-Reply-To: <200701071107.50461.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> You are simply great ! It simply worked like a charm this morning on a suse 
> 10.2 and i suppose it will work on any other distro. !

Yep it will. This script will be in upcoming 2.10.2.

>>> The sensor monitor and fan speed control is a very interesting featur[...]
>> Please can you attach the DSDT table to your mail?
>>
>> cat /proc/acpi/dsdt > /tmp/dsdt.bin
> 
> Attached to this email.

Careful your DSDT bytecode contains SMBUS access functions! Do not load the 
thermal module from ACPI. (the code does not use the HW semaphore)

There is some ASUS mutex called P4SM in ACPI namespace but it seems that it is 
this board specific.

Rudolf

