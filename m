From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 06 Apr 2006 20:58:39 +0000
Subject: [lm-sensors] [Fwd: Sensor readings from Gigabyte I915P Duo	Pro
Message-Id: <443580FF.7040104@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1144101011.28472.17.camel@localhost>
In-Reply-To: <1144101011.28472.17.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Przemek,

Przemys?aw Kulik wrote:
> Dnia 05-04-2006, ?ro o godzinie 09:39 +0200, Rudolf Marek napisa?(a):
> 
>>2) We can do the bios disassembly to see what is on BIOS screen. Unfortunately
>>   this can take some time and I dont have one. You can check my homepage
>>   http://assembler.cz (BIos hacking) if you have some assembly skills.
> 
> Unfortunately I do not

This reminds me one I hacked a DLL that could run in linux and it contained gigabyte
code + computations.

> # acpi -V
> No support for device type: battery
> No support for device type: thermal
> No support for device type: ac_adapter

Ok this is dead end too.

Please can you write to Gigabyte support?  Ask them what are the resistors values for the voltage inputs of
IT8712 of your motherboard and also how the temps are connected to temp1-temp3 and if some compensation
offset is needed to be added.

Regards
Rudolf


