From: Rudolf Marek <r.marek@assembler.cz>
Date: Sat, 29 Dec 2007 22:01:39 +0000
Subject: Re: [lm-sensors] abituguru3 does not work with Abit IX38
Message-Id: <4776C3C3.7060007@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071229T015954-296@post.gmane.org>
In-Reply-To: <loom.20071229T015954-296@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

I have taken the IX38 BIOS, decompressed and got this bunch of file
(using old dos awardeco.arj, awardeco from debian does not work)


http://www.os2site.com/sw/util/veit/index.html

(use dosbox to run it)

marekr2@kiur:~/dilna/uguru$ ls -1 *BIN
ACPITBL.BIN
AHCI_ROM.BIN
BEXTDDR2.BIN
DDR2.BIN
_EN_CODE.BIN
_ITEM.BIN
JMB363_6.BIN
M704B_11.BIN
RAID_OR.BIN
SMI32COD.BIN


BEXTDDR2.BIN is PE program relocated to the top of the ROM, dont know what it 
should do.

DDR2.BIN despite the name is some kind of uGuru ROM utillity. Perhaps the board 
has some kind of hotkey to invoke it?

It is standard rom file, so it can be invoked as option-rom by qemu :)

qemu -option-rom DDR2.BIN  -hda /dev/null

Unfortunately it will hang around
(gdb) stepi
0x000005d0 in ?? ()
(gdb) stepi
0x000005d3 in ?? ()
(gdb) stepi
0x000005a6 in ?? ()
(gdb) stepi
0x000005ab in ?? ()
(gdb) stepi
0x000005ad in ?? ()
(gdb) stepi
0x00000868 in ?? ()
(gdb) stepi
0x0000086b in ?? ()
(gdb) stepi
0x00000870 in ?? ()
(gdb) stepi
0x0000087c in ?? ()
(gdb) stepi
0x000005b0 in ?? ()
(gdb) stepi
0x000005b3 in ?? ()
(gdb) stepi
0x000005b5 in ?? ()
(gdb) stepi

(I checked in qemu monitor the addr is d05b3 etc only gdb has it wrong)


Because for some reason some structs are not initialized properly. Maybe this 
could be workarounded. (I attached to qemu with gdb to check this)

Good news is that this option rom talks directly to uGuru, so there is no SMM 
layer. It uses ports 0xe0 0xe4 and 0xeb

This option ROM uses VGA bios int 0x10 services and 0x16 keyboard services, so 
perhaps it can be fixed and even run in qemu :)

What I have in mind is to use qemu and program virtual dummy uGuru device 
(filled with dump values ;), which acts as that routines want, then if you 
change the voltage in this util, you can take a look what it changes in the 
virtual device - or simply log all IO traffic.

Or of course, the size of binary is only 32K so it should not be much difficult 
to reverse engineer it completely.

If some values are still missing, and we cannot succeed with qemu. I would 
suggest to patch this util to display the IO on screen directly ;) It would need 
to repack the BIOS but it can be done.

One final note on offset +3 is standard entrypoint. Maybe some non-standard 
entrypoint must be executed first right after the ROM header (there are some 
jumps) Second possibility would be to steal this ROM from already running 
computer, maybe if you do

dd if=/dev/mem of=memory.bin bs=1M count=1

you will find it somewhere around 700KB with already filled values ;)

Well thats all for ideas, good luck. I will be back next year ;)

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
