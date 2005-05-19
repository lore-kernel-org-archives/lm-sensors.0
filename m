From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <3FC50D92.8070600@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'd like the two folks with the problem (or anybody else with a nforce2)
try the new i2cdump in cvs to confirm.
if 'i2cdump 0 50' works but 'i2cdump 0 50 c' fails then the problem
is in the amd756 driver.

Actually, if anybody has an amd756/66/68 then they could try this too.
Maybe the nforce2 acts a little differently...

Write quick doesn't have any data at all, other than the
single read/write bit at the end of the address byte.

Jean Delvare wrote:

>>don't rule out a bus driver problem. They're both using nforce2.
> 
> 
> Actually I think I've narrowed it to i2c-nforce2's
> i2c_smbus_write_byte() being broken. After performing the checksum, the
> address register has value 0x40. The i2c_smbus_write_byte() call should
> change that value to the right one for each read slice, but for some
> reason fails to do so. This is why it always returns rows 5 and 6
> (because this slice really begins at 0x40).
> 
> As to why the call fails, I have no clue. I've never messed with (real)
> bus drivers. I'll contact the author of the module, I hope he'll be able
> to help. Only a few chip drivers use that call, among which there is no
> widely used monitoring chip, so we can reasonnably suppose that a bug
> here could have been left uncaught so far (especially since the
> i2c-nforce2 driver itself is fairly new).
> 
> BTW, Mark, what's the difference between (2c_smbus_write_byte and
> i2c_smbus_write_quick? I can't really tell, since they have the same
> prototype. For a moment, I wondered if I shouldn't have been using
> _quick instead of _byte, but since _byte works OK for me...
> 

