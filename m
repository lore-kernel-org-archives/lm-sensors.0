From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support for DDR2 DRAM??
Message-Id: <Pine.LNX.4.58.0409102118370.31786@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <28703505.1094766606690.JavaMail.root@louie.psp.pas.earthlink.net>
In-Reply-To: <28703505.1094766606690.JavaMail.root@louie.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



hello,

Byte 5 changed in DDR2 spec

DDR: http://www.jedec.org/download/search/4_01_02_04R13.PDF
Byte 5: Number of DIMM Banks
This field describes the number of physical banks on the SDRAM module. The
number of logical banks for the SDRAM device is defined in Byte 17.

DDR2: http://www.jedec.org/download/search/N04-NM2.pdf

Byte 5: Module Attributes - Number of Ranks, Package and Height
This field describes the number of ranks (Rank: any DRAMs connected to
same physical CS) and package on the SDRAM module, and module height. The
number of logical banks for the SDRAM device is defined in Byte 17.

Rank has 2 lowest bits,

Bit[ 7, 6, 5]
 000 = less than 25.4 mm
 001 = 25.4 mm
 010 = greater than 25.4 mm and less than 30 mm
 011 = 30.0 mm
 100 = 30.5 mm
 101 = greater than 30.5 mm
 others :reserved

Bit4:
DRAM Packgage
   1 = stack
  0 = planar

Bit3:
Card on Card
  1 = yes
   0 = no

Bit1:
# of Ranks
it [2, 1, 0] :
  000 = 1 rank
  001 = 2 ranks

> Memory size (MB):       invalid (14 11 96 4)


So 96 is bad bad...

And in byte 3, and 4 are changed also. I'm sorry I cant provide the patch
right now.

> I really am impressed with the fast response.

Thank Jean :)

Regards

Rudolf
