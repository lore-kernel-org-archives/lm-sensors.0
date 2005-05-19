From: ovis@thecourtofeden.org (ivo)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: i801 bus problems
Message-Id: <Pine.LNX.4.58.0409031337090.3306@shi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Fri, 3 Sep 2004, Jean Delvare wrote:

> > > I may have jumped the gun a bit.  It looks like i801 is working but some
> > > client chips are not responding or are missing?
> >
> > Yes you got it :) The bus is simply not working even all modules for
> > bus and lm85 are loaded. I thought the bus is confused with autodetection
> > process but it does not work even after powercycle and only lm85
> > loaded as client. The question is what to do with it? Is possible
> > somehow to change configuration of SMBUs controller, maybe it has
> > some slow devices???
>
> Does the eeprom driver works?

it seems to load

>
> What does i2cdump on 0,0x2e or 0,0x50 returns?


i2cdump 0,0x2e
Error: First argument not a number!
Syntax: i2cdump I2CBUS ADDRESS [MODE] [BANK [BANKREG]]
  MODE is 'b[yte]', 'w[ord]', 's[mbusblock], 'i[2cblock]',
       or 'c[onsecutive byte address mode]' (default b)
  Append MODE with 'p' for PEC checking
  I2CBUS is an integer
  ADDRESS is an integer 0x00 - 0x7f
  BANK and BANKREG are for byte and word accesses (default bank 0, reg
0x4e)
  BANK is the command for smbusblock accesses (default 0)
Error: No I2C busses found!
Be sure you have done 'modprobe i2c-dev'
and also modprobed your i2c bus drivers

Also on 0 or on 0,0x50
maby i do something stupid

 i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-0.
  I will probe address range 0x03-0x77.
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 2e XX
30: 30 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX 61 XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX


>
> i2cdetect and i2cdump are really the basic tools to start with when
> investigating this kind of issue IMO.

It beats me

>
> --
> Jean Delvare
> http://khali.linux-fr.org/
>
>
