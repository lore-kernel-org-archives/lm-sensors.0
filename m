From: r.marek@assembler.cz (Rudolf Marek)
Date: Thu, 11 Jan 2007 16:57:38 +0000
Subject: [lm-sensors] FB-DIMM temperature
Message-Id: <45A66C82.8070100@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A65914.6040302@assembler.cz>
In-Reply-To: <45A65914.6040302@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Vadim Zeitlin wrote:
> On Thu, 11 Jan 2007 16:34:44 +0100 Rudolf Marek <r.marek at assembler.cz> wrote:
> 
> RM> > 		    printf("Intel sig at %i: %02x %02x\n",
> RM> > 	                   i, addr[idx], addr[idx+1]);
> RM> 
> RM> We should see the 86 80
> 
>  Ah, this is why it's called "Intel sig", I see...

The 0x111d signature is company called IDT. They manufacture IDTAMB0480 which
may be used there. Question is if the register layout is same as in intel AMB

 http://www.intel.com/design/chipsets/datashts/313072.htm


> RM> > and here are the results:
> RM> > 
> RM> > 	# ./fbdt
> RM> > 	Intel sig at 0: 1d 11
> RM> > 	Current temp is: 71.500000C
> RM> > 	Intel sig at 16: 1d 11
> RM> > 	Current temp is: 0.000000C
> RM> > 	Intel sig at 32: 1d 11
> RM> > 	Current temp is: 61.000000C
> RM> > 	Intel sig at 48: 1d 11
> RM> > 	Current temp is: 0.000000C
> RM> > 
> RM> 
> RM> Hmm there is something wrong.
> 
>  FWIW, I've opened the box to try to cool the DIMMs a bit and now the
> results are
> 
> 	# ./fbdt
> 	Intel sig at 0: 1d 11
> 	Current temp is: 65.000000C
> 	Intel sig at 16: 1d 11
> 	Current temp is: 0.000000C
> 	Intel sig at 32: 1d 11
> 	Current temp is: 52.000000C
> 	Intel sig at 48: 1d 11
> 	Current temp is: 54.000000C
> 
> so not only the values did diminish but there is also 54 instead of 0 for
> the last one. So I wonder: could it be that the DIMMs really overheat and
> the temp of the 2nd one is just out of the range?

Yes it might. Please check the intel datasheet for overheat flags etc etc. It
might work for you. I asked our friend in Tyan for a help with that.




> 
> RM> Please provide output of lspci -vvv and lspci -xxx
> 
>  The files are relatively big so instead of posting them here I put them on
> 
> 	http://www.tt-solutions.com/vz/hardware/tyan2696/pci.ls
> 	http://www.tt-solutions.com/vz/hardware/tyan2696/pci.dump
> 
> Please let me know if you need anything else. I'm afraid I don't really see
> anything helpful in lspci output on my own.

I was interrested in base address and it is correct.

00:10.0 Host bridge: Intel Corporation 5000 Series Chipset Error Reporting
Registers (rev 31)
00: 86 80 f0 25 00 00 00 00 31 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f1 10 96 26
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 ff 00 00 08 00 00 00 00 00 fe 00 00 00 00

                               ^^^^^^^^^^^^^^^

Same as we use in our prog ;)

50: 00 00 02 00 00 00 04 04 00 10 11 01 00 00 13 11
60: 00 12 09 0d 00 e0 00 00 ff ff ff ff 00 00 00 00
70: 8c c0 e2 0f 00 00 00 00 8c c0 e2 0f 00 00 00 00
80: 01 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 04 01 80 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 02 06 80 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 08 07 80 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 11 01 00 00
e0: 00 00 00 00 00 00 00 80 00 00 00 00 00 00 00 00
f0: 5c 7f 48 00 06 a1 58 01 f4 08 d8 03 80 00 00 00

> RM> Do you have the windows software somewhere to download?
> 
>  No, not really, I use SpeedFan (http://www.almico.com/speedfan.php) but I
> don't know if it's capable of reading FB-DIMMs temperatures and, as I said,
> I don't really want to install Windows on this machine just to try it out.

I think they do not have support for this - it fairly new technology.

If you have time, maybe you may investigate the overtemperature bits. I think I
may have some time for this next week...

Rudolf

