From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 22 May 2006 21:00:10 +0000
Subject: [lm-sensors] IBM NetFinity 4000r Support
Message-Id: <4472265A.7030504@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44665DE5.60703@wans.net>
In-Reply-To: <44665DE5.60703@wans.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>   If you view the bug, it uses 4 MAX161 sensors for primary temperature
> sensors.  I also posted the source code for an old driver.  Please let
> me know what I need to do to get development started.
>              Kevin

The driver really sucks :( and it is incomplete.

Anyway here is some useful info:
enum SMBUS_DEVICES{ 

         PIIX4           = 0x10, 

         MAX_1617_GG     = 0x30, adr 18 

         MAX_1617_GZ     = 0x32, 

         MAX_1617_GV     = 0x34, adr 1A 

         MAX_1617_ZG     = 0x50, 

         MAX_1617_ZZ     = 0x52, 

         MAX_1617_ZV     = 0x54, 

         DIMM_0          = 0xA0, 

         DIMM_1          = 0xA2, 

         DIMM_2          = 0xA4, 

         DIMM_3          = 0xA6, 

         LM79            = 0xBA,   adr 5D? 


later in the .h file it claims it is   5A so  at 2D 

         I82559_1        = 0xCC,   adr 66 

         I82559_2        = 0xCE, 

         MPSLAVEADDR     = 0xE6,  73 

         FPSLAVEADDR = 0xE8 

}; 


You need /2 for that values to get those:


      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX 18 XX 1a XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX 4c XX 4e XX
50: 50 51 52 53 XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX 66 XX XX 69 XX XX XX XX XX XX
70: XX XX XX 73 XX XX XX XX

Ok so we know:

18 and 1A is max1617
2D is LM79

we should avoid rest of clients

On the rest adresses there are some slave controllers which might also access 
the bus and generate the slave -> host transcactions.  Those devices are in fact
a processors with special funcs.

All in all. Lets see if you have troubles to dump the device as suggested in 
previous mail...

Regards
Rudolf

