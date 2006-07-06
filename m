From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 06 Jul 2006 18:04:45 +0000
Subject: [lm-sensors] Winbond W83627HF - deactivated
Message-Id: <44AD50BD.5080803@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44AD4B8C.1010002@sh.cvut.cz>
In-Reply-To: <44AD4B8C.1010002@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Albert wrote:
> Hi Rudolf
> On 06/07/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
>> Maybe they just forgotten it to activate ....
>>
>> Enter configuration mode
>>
>> isaset -y -f 0x2e 0x87
> Data mismatch, wrote 0x87, read 0xff back.
> 
>> isaset -y -f 0x2e 0x87
> Data mismatch, wrote 0x87, read 0xff back.
> 
>> select logical device 0xb - hw monitor
>> isaset -y 0x2e 0x2f 0x07 0xb
> No issue here
> 
>> select base addr: (assuming 0x290 is safe, check /proc/ioports and see if the
>> 0x290 - 0x29F is empty)
> The address ranges are open
> 
>> isaset -y 0x2e 0x2f 0x61 0x90
>> isaset -y 0x2e 0x2f 0x60 0x2
> no issue here
> 
>> activate it:
>> isaset -y 0x2e 0x2f 0x30 0x1
> no issue here
> 
>> Leave configuration mode
>> isaset -y -f 0x2e 0xaa
> Data mismatch, wrote 0xaa, read 0xff back.
> 
> Seems to me that it is not there at all.

This errors are normal. Ignore them.

> I'm sending an email to Ampro to find out what is going on here. I'll
> let you know as soon as I have more info from them.

Well this sequence just reprograms the chip. After that you should be able to
modprobe the module, and sensors-detect should find it active.

(unless I made some mistake)

Can you re-run the sequence, and run this:
isaset -y -f 0x2e 0x87
isaset -y -f 0x2e 0x87
isaset -y 0x2e 0x2f 0x07 0xb
isadump -y 0x2e 0x2f
isaset -y -f 0x2e 0xaa

Thanks,
Regards
Rudolf

