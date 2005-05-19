From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: questions on i2c-isa
Message-Id: <Pine.LNX.4.53.0401042152540.27769@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040104165323.4a824f59.khali@linux-fr.org>
In-Reply-To: <20040104165323.4a824f59.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 4 Jan 2004, Mark Studebaker wrote:

> > 1* Why is it that i2cdump does not work with i2c-isa? I understand that
> > i2cdetect cannot work (since i2c-isa isn't a real i2c bus) but i2cdump
> > does exactly what a chip driver could do if I'm not mistaking.
>
> For all i2c accesses you need an i2c bus address 0x00 - 0x7f.
> This concept doesn't work for isa busses.

Does not work since i2c-isa is an empty algorithm and has neither
i2c_xfer or smbus_xfer. All low-level access is handled internally in
chip drivers. I think there is isadump?

The real benefit of i2c-isa was to use i2c-proc. With sysfs only
i2c_detect (address parameter parser) in i2c-sensors.c is (sometimes)
used. In addition, user progs may depend on data from /proc/bus/i2c* to
find the chip.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
