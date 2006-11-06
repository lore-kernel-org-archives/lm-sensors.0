From: hanyongkui99@gmail.com (Yongkui Han)
Date: Mon, 06 Nov 2006 15:41:02 +0000
Subject: [lm-sensors] About fancontrol: I could not control the CPU fan
Message-Id: <2ca62ec0611060741t1dc3b9a1v6f3a4e3be9d79bfe@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ca62ec0610301925i65568f5ar4449bfe2d9d5c406@mail.gmail.com>
In-Reply-To: <2ca62ec0610301925i65568f5ar4449bfe2d9d5c406@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Thank you. The following is the dump from isadump command:

---------------------------------------------
[root]# /usr/local/sbin/isadump -f 0x800
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address range 0x800 to 0x8ff.
Continue? [Y/n]
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0800: 00 00 00 00 38 f7 77 bf a0 00 00 00 00 00 00 00
0810: 02 00 77 df ca 00 00 00 00 00 00 00 00 00 02 00
0820: 00 00 00 81 81 81 81 80 01 01 80 80 80 80 00 80
0830: 80 80 84 05 05 04 04 05 04 84 84 04 04 84 80 05
0840: 05 05 04 05 04 05 04 81 80 00 00 f7 77 1d 08 57
0850: 02 00 00 00 ff ff 10 7f f0 26 ff 00 00 00 00 00
0860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0880: ff ff ff ff 01 01 ff ff ff ff ff ff ff ff ff ff
0890: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
08a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
08b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
08c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
08d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
08e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
08f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
---------------------------------------------------

So, the register 0x58 is f0, which is 11110000. But I am not sure whether
the Bit 0 is from left or right. I assume it is from right. So Bit 0 to Bit
3 = 0, and Bit 4 to Bit 7 = 1.

Accoring to Table 57 on page 118 of the manual, this means the Fout is
15.625 kHz?

I am not sure what to write to the device, could you help me with that.

Thank you very much!
Yongkui


On 11/5/06, Rudolf Marek <r.marek at assembler.cz> wrote:
>
> Hi all,
>
> Sorry for delay I was quite busy last week,
>
> > -is this a 3 or 4 pin fan?
>
> 3 pin
>
> > -is this a 3 or 4 pin connector on MB?
>
> 3pin
>
>
> > when you operate pwm1 manually,
> > - can you see the value with cat pwm1 you did write ther before?
>
> Yes good question
>
> > - are you sure to be in manual mode pwm_enable=1 ?
>
> And another one.
>
> > - what do the other pwm1* register read?
>
> I studied the documentation update and I think the problem can be caused
> by two
> things:
>
> 1) the CPU fan is driven by unknown, now obsolete Intel technology Wfm
> 2) the CPU fan is connected to the superio chip but the base frequency is
> not
> correct
>
> if the 1) is issue maybe you could connect the fan to another socket, fan2
> looks
> promising.
>
> if 2) then you need to check page 118 printed in datasheet
> Datasheet is here
> http://www.datasheets.org.uk/datasheet.php?article 40255
>
> CHeck the register 58 bits D0-D3.
>
> You may dump the chip with the following command:
> isadump -f 0x800
>
> Check the address 0x858, please post the dump here.
> If you need to change the register 0x58 bits 0-3 then use:
> isaset -f 0x858 newval (or you might use the mask)
> do that when the module is unloaded.
>
> If you may try the combinations from the table Table 57 ? Different Modes
> for Fan
> Or better just send the dump here, and I will tell you what to write to
> chip.
>
> Regards
> Rudolf
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061106/d9478185/attachment.html 
