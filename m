From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 05 May 2006 19:54:41 +0000
Subject: [lm-sensors] latest findings - my older posting from ~ 11 days
Message-Id: <445BAD81.4080708@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200605022128.10627.dieter.jurzitza@t-online.de>
In-Reply-To: <200605022128.10627.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Dieter,

Please dont forget to CC the list.

> No! The reset button does *not* cure the problem. This is different from 
> "normal" behaviour"

Ok

> 
>>Have you ACPI in kernel? 
> 
> Yes. Any info required on that?

Please mail dsdt.bin

cat /proc/acpi/dsdt > /tmp/dsdt.bin

>>Have you compiled/loaded/in kernel the thermal module?

And no support for "thermal" module (thermal is the module name or ACPI subsytem
option in kernel)

> It will :-(
> This is my homework, I'll be back with you as soon as I have results to tell.
> 
>>1) obtain the smb base addr
>>	AMD756_smba = xxx
>>Should be in your debug log, you may use value from older log because it
>>does not change. Alternatively you may also look into cat /proc/ioports
>>
>>then you may use the isadump tool
>>2)
>>isadump -f xxx

Please dont forget the 0x prefix before the address

>>while true; do i2cdump -y 0 0x2d b > /dev/null; done

You may insert here some sleep 1 maybe. But lets try without first.

> Thanks for helping that far. I will unload the debug kernel now as it spits 
> about 400 MByte of i2c-debug logs into /var/log/messages.

Good.

regards
Rudolf

