From: p.henning@fh-karlsruhe.de (Prof. Dr. Peter A. Henning)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: Broken DS1621 detection / ds1621 module / A7V8X
Message-Id: <200501132157.36228.p.henning@fh-karlsruhe.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501040208.12906.p.henning@fh-karlsruhe.de>
In-Reply-To: <200501040208.12906.p.henning@fh-karlsruhe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

Am Freitag, 7. Januar 2005 21:14 schrieb Aurelien Jarno:
> > 111111111111111111111111111111111111111111111111111111111
> > Detection of the DS1621 in sensors-detect is broken. According to the
> > data sheet of the DS1621, one bit of the configuration register is always
> > 1 and another always 0. This is simply not true, if the chip is not
> > properly initialized. I suggest the following replacement for sub
> > ds1621_detect in sensors-detect
>
> That sounds me strange. I am using a ds1621 plugged onto my parallel
> port I2C interface and the module is always loaded at boot. I am using
> this for more than 4 years (the chip is dated 0022, ie year 2000 week
> 22).

Well, may be strange - but that's fact. The data sheet does not have a single 
line indicating that the two "fixed" bits may be overwritten - and yet, 
something does this.

>> # subroutine modified by Peter A. Henning
>> # Old version checks, if Bit 3 is set and Bit 2 is clear. 
>> # => THIS IS NOT ALWAYS TRUE
> ># The DS1621 will however aways have a config like 0x????1???
> If the chip is not correctly initialised, there is also some chances 
> that this is not always true. 

Could be, but with three different DS162 chips I found not a single case where 
the 0x????1??? was not true.

> Moreover it will be weakening the 
> detection which is already not very strong. That could make some chips
> to be falsely detected as ds1621.

Agreed. But worse is the case where a positively identified DS1621 i snot 
recognized as such - and the detection gets stronger than in the old code 
when the temperature is properly identified.
>
> The better solution would be to understand why your chip does not
> conform to the datasheet.

Agreed. But I have three chips on the same bus now, and they all behave the 
same
>
> Are you using a ds1621 chip or a compatible one (ds1625, ds1629, ds1721
> or something like that)?, 
DS1621, stamped 0445B4 265AE
Three chips, bought December 2004

> Are you sure they is no interference between your asb100 chip and your
> ds162b1?

Of course not. But I deem it unlikely to have the asb interfering with the 
three different chips (sitting at different addresses of course) in the same 
way
> AFAIK, the VT8235 only has support for smbus and not i2c. The minor
> differences in the protocol (mainly timing protocol), may cause bus
> lockup. Do you think it may correspond to what you are observing?
>
Asus advertizes the board to have an SMBus interface. And yet, Dallas does not 
say anything of SMBus and s quoted as being I2C compatible.


> Or maybe the new Dalls chips are buggy...
Do you want to test one of mine ?

Best regards
-- 
Peter Henning

----------------------------------------------PGP 0x5CDC14A1 -------
| Prof.Dr.Peter A.Henning
| 
| European E-Learning Award EureleA
| http://www.eurelea.org
|
| Director MediaLab
| Computer Science, Karlsruhe University of Applied Sciences
| http://medialab.fh-karlsruhe.de/
|-------------------------------------------------------------------
