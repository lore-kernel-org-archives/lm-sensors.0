From: kakadu@gmail.com (Bradley Chapman)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: Need assistance with enabling the SMBus on an Intel 855PM 82801DB
Message-Id: <e294b46e05041510241a0d6216@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <e294b46e05041407152efe4f8b@mail.gmail.com>
In-Reply-To: <e294b46e05041407152efe4f8b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mr. Delvare,

On 4/15/05, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Bradley,
> 
> > Unfortunately, the only thing sensors-detect found was an SPD EEPROM,
> > telling me that I have 512MB of memory installed :-((((
> >
> > Either there is nothing attached to my SMBus or it wasn't detected by
> > sensors-detect.
> 
> You may try using i2cdetect (after loading the i2c-dev kernel module) on
> that bus. If there are responsive addresses other than 0x08, 0x44,
> 0x50-0x57 and 0x69, this might be a hardware monitoring chip, in which
> case you can send the output of i2cdump for it and we'll investigate.

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: XX 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

:-(((((

I guess I'll have to wait and hope that someone fixes the M375E DSDT
to uncover any hidden thermal zone functionality...

> 
> --
> Jean Delvare
> 

Brad
-- 
SCREW THE ADS! http://adblock.mozdev.org/
Extensions Mod at http://www.extensionsmirror.nl/
