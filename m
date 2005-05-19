From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Update: SAA1064
Message-Id: <200307182206.20409.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307162122.07079.sascha@akv-soft.de>
In-Reply-To: <200307162122.07079.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At Freitag, 18. Juli 2003 12:38 Jean Delvare wrote:
> 1* Your second comment about the saa1064 is inaccurate (if my
> understanding is correct). You say you have to write to the 5 registers
> at once. It isn't true. You *can* do so, but the saa1064 is much more
> flexible than that. You can start writting at any address and stop
> [...]

Yes, that's an outdated piece of comment. I merely forgot to correct it :-)

> 2* I would unify the two "blank" sysctl files into one single file with
> 2 values. What's more, I would change the convention. You have 0 > blanked, 1 = not blanked, because it's that way in the datasheet, but it
> won't make much sense for the user. So I think you should either rename
> the sysctl file and associated data to, say, "display", or, preferably,
> I would decide that 1 stands for blanked.

That's a good idea, I think I'll just do it. Maybe I should even but the 
dynamic flag into this sysctl, as well, since the blank bits are IMHO 
unnecessary when dynamic mode is on. As far as I've understood, dynamic 
mode means all digits are displayed repeatedly (at a very fast rate so the 
viewer doesn't notice), and in static mode only those digits not blanked by 
blank13/24 are shown.

I'll check that again, if this is the case all could be reduced to one 
tri-state sysctl (0=display all four digits, 1=display 1+3, 2=display 2+4). 
What do you think?

> 3* I'm not sure about the pwrloss sysctl file. How do you intend to use
> [...]
> write) but would poll the power loss flag. If it find it is set, it
> would write the internal data to the chip. I think it makes more sense
> that way than letting the user know (in userspace) a power loss has
> occured and leave him/her handle it. I think you should try powering it
> off while in use and see what happens. That way, we will know what the
> user will want to be done.

I've already checked that yesterday (when re-checking detection), and if the 
power is unplugged while the device is running, the old sysctl pwrloss 
gives a 1 once. That's exactly the expected behaviour, after powering *on* 
the device, a read returns 0x80 *once*.

I'll implement your "refresh" suggestion - by the way is it really possible 
to write to a read-only (mode 0444) sysctl??!

> 4* BTW, the power loss flag is the MSB in the status register, not the
> LSB, so SAA1064_STAT_PWRLOSS should be set to 0x80.

How in the world did i get *that* wrong??! :-) Clearly a bug, will be fixed. 

> 5* SAA1064_CTRL_SET_BRIGHT(c,val) is not safe. You don't limit the
> change to 3 bits. I would add a "& 0x07" for safety (no real danger
> though, I admit).

I've thought about that and found it not dangerous, too. I didn't know if 
you folks count on that kind of construct, or maybe even dislike it. I'll 
put it in now I know it's ok :-).

> 6* You don't have to define a saa1064_write_value function. This is done
> in some drivers (lm75 for example) because the function actually does
> something, but for simple drivers there is no need for such a function.

I've used it when transferring the data via i2c_master_send (since the 
values had to be packed into a byte-array then), and merely left it intact 
while switching to i2c_smbus_write_byte_data. I'll remove it.

> 7* You can use a single call to i2c_check_functionality instead of two
> by or'ing the constants. BTW, why are you using READ_BYTE and
> WRITE_BYTE_DATA, but not READ_BYTE_DATA and WRITE_BYTE? This is a real
> question, I just don't know what the difference is (and I realize I may
> have set the wrong ones in the only driver I wrote so far).

Well since i use i2c_smbus_write_byte_data(i2c_client*, u8, u8) and 
i2c_smbus_read_byte(i2c_client*), I thought it would be best to check the 
same funcs that I'm using :-) (WRITE_BYTE_DATA for write_byte_data and 
READ_BYTE for read_byte). The difference is, that the _data functions 
expect a register address to write to/read from, and the ones without _data 
merely write a byte to the bus with no register address. Since the read 
register has no address, I use i2c_smbus_read_byte instead of 
.._byte_data.

> 8* The init function could be shortened using memset() (for setting
> digits to 0x00). Also, you are not using the auto-increment feature as
> described in the datasheet. I don't know if it is possible with our i2c
> subsystem. Maybe that's what WRITE_I2C_BLOCK is for? (Just wondering, I
> don't know much about this.)

I'll put memset in. Well I was successful in writing a block of data using 
i2c_master_send, but since i2c_check_functionality claims that plain 
I2C-commands are not possible with a primitive parallelport adapter, I 
decided to use the smbus functions again. I'll check if I can make use of 
any of the block write functions for the digits (and for the combined 
"blank" sysctl).

> 9* I'm a bit skeptical about saa1064_update_client. (See 3*.) I don't
> think you need an update function since your driver is write only by
> nature. I don't know if you can remove it completely though. (As you can
> see, there are really many things I don't know yet).

I just adapted the pcf8574 behaviour of reading the only register in 
update_client, which is only done if the last read has been some time 
earlier (the jiffies count is compared there). I think this isn't very 
safe, since two reads with only a very short delay between would both 
return "1" for powerloss (but the bit has been reset in the meantime). I 
think this function won't be necessary anymore if I implement the "refresh" 
sysctl instead.

Anyway I've even found a driver in your package containing the update_client 
skeleton, saying /* Nothing yet */ instead of doing anything (except 
updating the jiffies count).

> 10* I suggest you be more flexible about the user writing too many
> values to your sysctl files. You basically don't need to care about
> that. Just ignore the extra values. I think that's what most of our
> drivers do.

You mean, remove that "this device has only 4 digits" message? Well, I'll 
embrace it with #ifdef DEBUG..#endif, just to be sure :-)))

> That's it. Don't be afraid because I seem to criticize much. It's
> actually very good work. I just want to make it even better (perfect if
> we only could). Each of the points above is subject to discussion, so I
> want to hear you!

That's what you get, and don't you be afraid, since I'm working in the field 
of Quality Assurance currently, I know how it's like to be criticized as a 
programmer, as well as how it's like to actually criticize a programmer 
myself :-)

> Thanks for the good work so far :)

And that's the sentence where the flames lighten up again :-))

BTW: Concerning your new sensors-detect, I'll check it tomorrow or sunday, 
since my only i2c-machine has a really small installation (10 MB so far) 
and I think you understand there's no perl yet, within 10 MB, so I have to 
install it first :-)

Greetings,
Sascha
