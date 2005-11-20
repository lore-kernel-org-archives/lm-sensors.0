From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 20 Nov 2005 17:45:14 +0000
Subject: [lm-sensors] decode-dimms.pl
Message-Id: <20051120174546.2ab062e1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000601c5eddd$372e8c80$3224050a@avilespaxp>
In-Reply-To: <000601c5eddd$372e8c80$3224050a@avilespaxp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

Please start a new thread for new topics.

> Qucik question on decode-dimms,
> 
> I have 3 dimms insalled 512, 256 and 256 for a total of 1 Gb.
> 
> Is the total memory per dimm a combination of :
> 
> Total number of bytes in EEPROM 256
> Number of Module Rows   2

No. The "total number of bytes in EEPROM" really is, well, the number
of bytes in the EEPROM which contains the configuration and information
data for the memory module. It isn't related with the size of the
memory module itself.

The number of rows is one of the components which is used to compute
the total size. Others are:

> Number of Row Address Bits (SDRAM only) 13
> Number of Col Address Bits (SDRAM only) 10
> (...)
> Number of Device Banks  4

The way to compute the exact size is quite complex and depend on the
memory type.

Since we want to remove eeprom support from "sensors" in a near future,
we probably should improve decode-dimms.pl so that it gives the total
memory module size like "sensors" did.

It also seems that "Row Densities" would give the size of one row,
which we would then multiply by the number of rows to get the total
size. I wonder if it always works. I'd guess not, else why would we
have used more complex computations?

Is anyone up to copy sensors' computations into decode-dimms.pl and let
that script print the total memory module size?

Thanks,
-- 
Jean Delvare
