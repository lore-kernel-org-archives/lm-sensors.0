From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <20031125190654.20fd6e05.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fernando, William,

Since you are experiencing the same problem with eeprom decoding, I
merge both threads here.

>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 80 08 07 0d 0a 01 40 00 04 50 65 00 82 08 00 01   
            ^^
> 10: 0c 04 10 01 02 20 00 00 00 00 00 50 28 50 28 40  
> 20: 60 60 40 40 00 00 00 00 00 00 00 00 00 00 00 00   
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 de  
> 40: 43 43 41 54 33 00 00 00 01 00 00 00 00 00 00 00   
            ^^
> 50: 00 00 00 00 00 00 00 00 00 00 00 02 00 00 22 00  
> (...)
> My memory is Samsung DDR 400, i have one DDR with 256 Mb
> I hope this is what you asked for...

Yes it is. Your memory type is correct (0x07 at 0x02 means "DDR SDRAM
DIMM"). But for an unknown reason, sensors reads the value at 0x42
instead (0x41 is 65).

The problem can come from three components:
1* The eeprom driver.
2* The libsensors library.
3* The sensors program.
Since I don't have a clue yet, I'd like you to provide the folling
additional information:

1* The output of "cat /proc/sys/dev/sensors/eeprom-i2c-0-50/*".

2* The output of "which sensors".

3* The output of "sensors -v".

4* The output of "ldd $(which sensors)".

5* The output of "ls -l /usr/local/lib/libsensors.*
/usr/lib/libsensors.*".

Hopefully it'll give me some ideas. Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
