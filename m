From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: bus scan removal
Message-Id: <Pine.LNX.4.53.0312221427491.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031221100543.28eaf2ff.khali@linux-fr.org>
In-Reply-To: <20031221100543.28eaf2ff.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 21 Dec 2003, Jean Delvare wrote:

> > Not all chips acknowledge the read address. With the i2c-ibm_iic, I
> > don't see the reason for using one-byte read,  if hw could not do
> > quick write a one-byte read is next best choice.
>
> I don't quite follow you there. Is the one-byte read method a good
> choice or not?

Depends of the chip, really. Commands in order of preference, what is
least likely to cause ill side effects on the bus.

1. Write Quick Wr "0"
2. Write Quick Rd "1"
3. Read Byte(s)
4. Write Byte(s)


Seems i2c_probe/detect requires Write Quick, while the chip driver
itself could do without it, so the chip never gets properly detected.
By properly, I mean the code in the chip driver that knows the specific
message format to use.


-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
