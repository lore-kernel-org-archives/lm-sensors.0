From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 05 Nov 2006 12:13:40 +0000
Subject: [lm-sensors] About fancontrol: I could not control the CPU fan
Message-Id: <454DD574.7090207@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ca62ec0610301925i65568f5ar4449bfe2d9d5c406@mail.gmail.com>
In-Reply-To: <2ca62ec0610301925i65568f5ar4449bfe2d9d5c406@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Sorry for delay I was quite busy last week,

> -is this a 3 or 4 pin fan?

3 pin

> -is this a 3 or 4 pin connector on MB?

3pin


> when you operate pwm1 manually, 
> - can you see the value with cat pwm1 you did write ther before?

Yes good question

> - are you sure to be in manual mode pwm_enable=1 ?

And another one.

> - what do the other pwm1* register read?

I studied the documentation update and I think the problem can be caused by two 
things:

1) the CPU fan is driven by unknown, now obsolete Intel technology Wfm
2) the CPU fan is connected to the superio chip but the base frequency is not 
correct

if the 1) is issue maybe you could connect the fan to another socket, fan2 looks 
promising.

if 2) then you need to check page 118 printed in datasheet
Datasheet is here http://www.datasheets.org.uk/datasheet.php?article 40255

CHeck the register 58 bits D0-D3.

You may dump the chip with the following command:
isadump -f 0x800

Check the address 0x858, please post the dump here.
If you need to change the register 0x58 bits 0-3 then use:
isaset -f 0x858 newval (or you might use the mask)
do that when the module is unloaded.

If you may try the combinations from the table Table 57 ? Different Modes for Fan
Or better just send the dump here, and I will tell you what to write to chip.

Regards
Rudolf

