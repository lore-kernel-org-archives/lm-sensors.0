From: vz-sensors@zeitlins.org (Vadim Zeitlin)
Date: Thu, 11 Jan 2007 15:57:47 +0000
Subject: [lm-sensors] FB-DIMM temperature
Message-Id: <E1H52JG-0004Bl-00@smtp.tt-solutions.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A65914.6040302@assembler.cz>
In-Reply-To: <45A65914.6040302@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 11 Jan 2007 16:34:44 +0100 Rudolf Marek <r.marek at assembler.cz> wrote:

RM> > 		    printf("Intel sig at %i: %02x %02x\n",
RM> > 	                   i, addr[idx], addr[idx+1]);
RM> 
RM> We should see the 86 80

 Ah, this is why it's called "Intel sig", I see...

RM> > and here are the results:
RM> > 
RM> > 	# ./fbdt
RM> > 	Intel sig at 0: 1d 11
RM> > 	Current temp is: 71.500000C
RM> > 	Intel sig at 16: 1d 11
RM> > 	Current temp is: 0.000000C
RM> > 	Intel sig at 32: 1d 11
RM> > 	Current temp is: 61.000000C
RM> > 	Intel sig at 48: 1d 11
RM> > 	Current temp is: 0.000000C
RM> > 
RM> 
RM> Hmm there is something wrong.

 FWIW, I've opened the box to try to cool the DIMMs a bit and now the
results are

	# ./fbdt
	Intel sig at 0: 1d 11
	Current temp is: 65.000000C
	Intel sig at 16: 1d 11
	Current temp is: 0.000000C
	Intel sig at 32: 1d 11
	Current temp is: 52.000000C
	Intel sig at 48: 1d 11
	Current temp is: 54.000000C

so not only the values did diminish but there is also 54 instead of 0 for
the last one. So I wonder: could it be that the DIMMs really overheat and
the temp of the 2nd one is just out of the range?

RM> Please provide output of lspci -vvv and lspci -xxx

 The files are relatively big so instead of posting them here I put them on

	http://www.tt-solutions.com/vz/hardware/tyan2696/pci.ls
	http://www.tt-solutions.com/vz/hardware/tyan2696/pci.dump

Please let me know if you need anything else. I'm afraid I don't really see
anything helpful in lspci output on my own.

RM> Do you have the windows software somewhere to download?

 No, not really, I use SpeedFan (http://www.almico.com/speedfan.php) but I
don't know if it's capable of reading FB-DIMMs temperatures and, as I said,
I don't really want to install Windows on this machine just to try it out.

 Thanks!
VZ


