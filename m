From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 07 Sep 2005 10:09:19 +0000
Subject: [lm-sensors] lm78 on ep-61lxa-m not detected (#2042)
Message-Id: <d77th1d7tsa9r3jil6gfe0nlri4olqn9dk@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
In-Reply-To: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 7 Sep 2005 09:01:20 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:
>
>OK, that's great, but I still would like the output of:
>isadump -y -f 0x290 8

Hi Jean,

# isadump -y -f 0x290 8
Error: Invalid range!
Hint: Must be a multiple of 16 no greater than 256.
Syntax for I2C-like access:
  isadump [-y] [-k V1,V2...] ADDRREG DATAREG [BANK [BANKREG]]
Syntax for flat address space:
  isadump [-y] -f ADDRESS [RANGE [BANK [BANKREG]]]


# isadump -y -f 0x290 16
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 ff ff 00 00 00 1a 80 ff ff ff ff 00 00 00 00

I also confirmed 2.9.2 sensors-detect has same behaviour as 2.9.1.

Cheers,
Grant.
