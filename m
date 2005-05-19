From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: Broken DS1621 detection / ds1621 module / A7V8X
Message-Id: <20050107201436.GA26043@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501040208.12906.p.henning@fh-karlsruhe.de>
In-Reply-To: <200501040208.12906.p.henning@fh-karlsruhe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 04, 2005 at 02:08:12AM +0100, Prof. Dr. Peter A. Henning wrote:
> Hi there,
Hi!

> I have some DS1621 temperature sensors attached to an VIA 8235 sitting on my 
> Asus A7V8X.
> 
> 111111111111111111111111111111111111111111111111111111111
> Detection of the DS1621 in sensors-detect is broken. According to the data 
> sheet of the DS1621, one bit of the configuration register is always 1 and 
> another always 0. This is simply not true, if the chip is not properly 
> initialized. I suggest the following replacement for sub ds1621_detect in 
> sensors-detect
That sounds me strange. I am using a ds1621 plugged onto my parallel
port I2C interface and the module is always loaded at boot. I am using
this for more than 4 years (the chip is dated 0022, ie year 2000 week 
22).

> --------------- SNIP ---------------------------------------------------
> # $_[0]: A reference to the file descriptor to access this chip.
> #        We may assume an i2c_set_slave_addr was already done.
> # $_[1]: Address
> # Returns: undef if not detected, (3) if detected,
> #   (5) or (7) if even more bits match. 
> # Registers used:
> #   0xAA: Temperature
> #   0xA1: High limit
> #   0xA2: Low limit
> #   0xAC: Configuration
> #
> # subroutine modified by Peter A. Henning
> # Old version checks, if Bit 3 is set and Bit 2 is clear. 
> # => THIS IS NOT ALWAYS TRUE
> # The DS1621 will however aways have a config like 0x????1??? 
> # Also, the calculation of temperatures needs to swap bytes. The lower byte 
> # (before swapping) contains the temperature as signed 8-bit integer, the
> # higher byte's (before swapping) highest bit is worth another 0.5 degree.
> # Hence, logical AND with 0x7F00 should give zero. 
If the chip is not correctly initialised, there is also some chances 
that this is not always true. Moreover it will be weakening the
detection which is already not very strong. That could make some chips
to be falsely detected as ds1621.

The better solution would be to understand why your chip does not
conform to the datasheet.

Are you using a ds1621 chip or a compatible one (ds1625, ds1629, ds1721
or something like that)?
Are you sure they is no interference between your asb100 chip and your
ds1621?
AFAIK, the VT8235 only has support for smbus and not i2c. The minor
differences in the protocol (mainly timing protocol), may cause bus
lockup. Do you think it may correspond to what you are observing?

Or maybe the new Dalls chips are buggy...


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
