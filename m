From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 12 Jun 2014 08:12:20 +0000
Subject: Re: [lm-sensors] [lm85] Sensors yields triplicate output
Message-Id: <20140612101220.3f0b98e1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGTLibq22gJ-GzaVagS7JDL=fNnHs6nhxTeD_OVKoMrHYPwhmw@mail.gmail.com>
In-Reply-To: <CAGTLibq22gJ-GzaVagS7JDL=fNnHs6nhxTeD_OVKoMrHYPwhmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mike,

On Wed, 11 Jun 2014 15:32:33 -0600, Mike Dixon wrote:
> I have NOT installed a separate lm85 driver. I will gladly test your patch.

I have posted the patch yesterday. I have also made a standalone driver
available at:
  http://jdelvare.nerim.net/devel/lm-sensors/drivers/lm85/
For installation instructions, see:
  http://jdelvare.nerim.net/devel/lm-sensors/drivers/INSTALL

> *System Info:*System: Sunware 0073351-01 05/16/2007 [SE7230NH1LX]
> Board: Intel Corporation SE7230NH1LX

The datasheet says that hardware monitoring is implemented by the LPC
Super-I/O on this board. It doesn't say which chip it is though. But
anyway this is in contradiction with the theory that you have one
LM85-compatible chip on the board.

> *Kernel Version*:
> 
> 2.6.32-431.17.1.el6.i686
> 
> 
> *sensors-detect output (not sure if you wanted the whole thing or just the
> summary):*
> 
> Driver `lm85':
>   * Bus `Radeon i2c bit bus DVI_DDC'
>     Busdriver `drm', I2C address 0x2e
>     Chip `lm85' (confidence: 6)
>   * Bus `SMBus I801 adapter at 3000'
>     Busdriver `i2c_i801', I2C address 0x2c
>     Chip `lm85' (confidence: 6)
>   * Bus `SMBus I801 adapter at 3000'
>     Busdriver `i2c_i801', I2C address 0x2e
>     Chip `lm85' (confidence: 6)

You did not rmmod the lm85 driver before running the script, as I
asked. That make the above output useless (sensors-detect had to
blindly trust the detection done by the lm85 driver, which we know is
wrong.) So you can do it all again. And yes I would prefer the whole
output.

> *i2c dumps:*
> Only the '0 0x2e' i2c dump worked (pasted below). The other two yielded
> errors:
> 
> [user@localhost]# i2cdump -y 4 0x2c > /tmp/lm85-i2c-4-2c.dump
> No size specified (using byte-data access)
> Error: Could not open file `/dev/i2c-4' or `/dev/i2c/4': No such file or
> directory
> [user@localhost]# i2cdump -y 4 0x2e > /tmp/lm85-i2c-4-2e.dump
> No size specified (using byte-data access)
> Error: Could not open file `/dev/i2c-4' or `/dev/i2c/4': No such file or
> directory

That's kind of odd. What does "i2cdetect -l" say? What does "ls
-l /dev/i2c*" say?

>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

That's not a successful dump.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
