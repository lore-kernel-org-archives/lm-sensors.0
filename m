From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: w83792d_driver-1.0.1.patch: Winbond W83792D driver for linux-2.4
Message-Id: <4236FCD4.7020608@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Philip Pokorny wrote:
> Mark Studebaker wrote:
> 
>>
>> 2) subclient registration
>>    The module should register the  'subclients' (the two emulated lm75 
>> chips) so that other drivers do not claim them.
>>    You can copy this code from w83781d.c
> 
> 
> 
> I was wondering the other day why this is so.
> 
> If the emulated lm75 chips are well emulated, then why not use the lm75 
> driver to talk with them?  It would certainly make the winbond drivers 
> simpler as they would only have to deal with a single i2c address.
> 
> How do you access the lm75's via the ISA bus?  Does the winbond appear 
> to be an i2c bus controller at the ISA address?  If so, would creating a 
> "i2c-winbondisa" bus driver simplify things some more?
> 

Good questions.
They aren't well-enough emulated for lm75  to load without a force.
And it doesn't  yield  the same readings as the 792d driver, haven't figured out why.
For ISA drivers, there are ISA registers that map  the lm75 temp and limit registers,
but not the config register. It's not emulating an i2c controller
so I don't think a new bus driver is doable.
Of course ISA is much faster if available.
The new 792d driver is i2c-only.
The subclient approach has worked well and is probably the simplest way to do it IMHO.

mds
