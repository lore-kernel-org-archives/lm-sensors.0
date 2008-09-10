From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Sep 2008 15:53:32 +0000
Subject: Re: [lm-sensors] Results of running your sensors-detect
Message-Id: <20080910175332.79e4bbdd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C719D9.90000@gmail.com>
In-Reply-To: <48C719D9.90000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dean,

On Wed, 10 Sep 2008 07:02:45 -0700, Dean Loros wrote:
> OK Jean---
> 
> ran check---results.
> (...)
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `w83627ehf' (should be inserted):
>   Detects correctly:
>   * ISA bus, address 0x290
>     Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)
> 
> Driver `coretemp' (should be inserted):
>   Detects correctly:
>   * Chip `Intel Core family thermal sensor' (confidence: 9)

Good, no longer suggests the lm78. Thanks for testing.
> dean@linux:~/Desktop$ modprobe i2c-dev
> dean@linux:~/Desktop$ i2cdump 1 0x49
> No size specified (using byte-data access)
> Error: Could not open file `/dev/i2c-1': Permission denied
> Run as root?
> dean@linux:~/Desktop$ sudo i2cdump 1 0x49
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-1, address 0x49, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: ff ff ff ff ff ff ff ff 00 8d 00 00 ff ff ff ff    .........?......

Hmm, I don't know what it is, but it doesn't look like a hardware
monitoring chip for sure.

> Left lm78 unloaded--what next?

I am out of ideas, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
