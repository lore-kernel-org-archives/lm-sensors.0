From: joerg@dorchain.net (Joerg Dorchain)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Installation report/Feedback
Message-Id: <20031221110032.GG495@GreenHouse.dorchain.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207183312.GA855@GreenHouse.dorchain.net>
In-Reply-To: <20031207183312.GA855@GreenHouse.dorchain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 20, 2003 at 02:08:51PM +0100, Jean Delvare wrote:
> > The motherboard is Ausus OEM by 4MBO. (...)
> 
> I suppose you really mean "Asus"?

Yes. Sorry.
> 
> Sure. Provide i2cdumps for these and I'll take a look. That said, you
> already have two monitoring chips on smbus 1, so I doubt we'll find any
> more on smbus 0.

i2cdetect 0   WARNING! This program can confuse your I2C bus, cause data
loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

0x08 gives only XX, 0x31 only 29. 0x50 and 0x51 are recognizes as SPD
eeproms and work as such. Does not look too interesting to me.

Bye,

Joerg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031221/ee226211/attachment.bin
