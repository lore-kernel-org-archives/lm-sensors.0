From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support for DDR2 DRAM??
Message-Id: <20040913203231.0e4d28f8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <28703505.1094766606690.JavaMail.root@louie.psp.pas.earthlink.net>
In-Reply-To: <28703505.1094766606690.JavaMail.root@louie.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ruik,

> Byte 5 changed in DDR2 spec
> 
> DDR: http://www.jedec.org/download/search/4_01_02_04R13.PDF
> Byte 5: Number of DIMM Banks
> This field describes the number of physical banks on the SDRAM module.
> The number of logical banks for the SDRAM device is defined in Byte
> 17.
> 
> DDR2: http://www.jedec.org/download/search/N04-NM2.pdf
> 
> Byte 5: Module Attributes - Number of Ranks, Package and Height
> This field describes the number of ranks (Rank: any DRAMs connected to
> same physical CS) and package on the SDRAM module, and module height.
> The number of logical banks for the SDRAM device is defined in Byte
> 17.
> 
> Rank has 2 lowest bits,
> (...)
> And in byte 3, and 4 are changed also. I'm sorry I cant provide the
> patch right now.

Looks like you did most of the detective work already. Care to propose a
patch (which would include my preliminary one)?

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
