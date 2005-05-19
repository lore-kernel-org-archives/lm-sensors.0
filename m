From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Update: SAA1064
Message-Id: <20030718123834.5a36bd13.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307162122.07079.sascha@akv-soft.de>
In-Reply-To: <200307162122.07079.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I've updated my i2c-machine to 2.4.21 with an i2c layer from
> yesterday's CVS, as well as lm_sensors2 from yesterday. All checked
> out like suggested on your download page.
> 
> I have adapted the SAA1064 driver code to that version of lm_sensors
> (again using pcf8574.c as a template to what has changed), and I've
> also fixed some bugs, specifically:
> 
> - enhanced functionality test in saa1064_detect
> - fixed handling of kind in saa1064_detect
> - always force saa1064, since no real autodetection possible (yet)
> - used i2c_smbus_write_data instead of i2c_master_send
> + added reading the status byte (sysctl PWRLOSS indicates LED power
> loss since last readout)

I've read your code source, here are my comments:

(All the following points express *my opinion*. It is not the True
Truth. You do what you want. I may be wrong.)

1* Your second comment about the saa1064 is inaccurate (if my
understanding is correct). You say you have to write to the 5 registers
at once. It isn't true. You *can* do so, but the saa1064 is much more
flexible than that. You can start writting at any address and stop
writing at any address. All the saa1064 does is increasing the address
by itself so you can send multiple bytes at once (I think it is similar
in mind to the "quick write" feature in the I2C world?).

2* I would unify the two "blank" sysctl files into one single file with
2 values. What's more, I would change the convention. You have 0 blanked, 1 = not blanked, because it's that way in the datasheet, but it
won't make much sense for the user. So I think you should either rename
the sysctl file and associated data to, say, "display", or, preferably,
I would decide that 1 stands for blanked.

3* I'm not sure about the pwrloss sysctl file. How do you intend to use
it? The fact that the power loss bit vanishes upon read makes it hard to
use from userland IMHO. I think you should make an internal only use of
the flag. If my understanding is correct, the flag being set means that
the device was freshly powered up. In the event this happens after the
driver is loaded, it means that nothing is displayed on your LCD display
anymore, regardless of the internal values you have in your driver. So
this flag should idealy mean that you must rewrite to the chip registers
from the driver values. Now the problem is that the flag does not come
to you in such a case, you would have to poll its value, and polling is
generally bad for performance, so we don't want to do that. What I
imagine you could do is define a "refresh" sysctl file instead of
"pwrloss". Reading from (or writing to, whatever) this file would not
return anything (and would ignore the written value in the case of a
write) but would poll the power loss flag. If it find it is set, it
would write the internal data to the chip. I think it makes more sense
that way than letting the user know (in userspace) a power loss has
occured and leave him/her handle it. I think you should try powering it
off while in use and see what happens. That way, we will know what the
user will want to be done.

4* BTW, the power loss flag is the MSB in the status register, not the
LSB, so SAA1064_STAT_PWRLOSS should be set to 0x80.

5* SAA1064_CTRL_SET_BRIGHT(c,val) is not safe. You don't limit the
change to 3 bits. I would add a "& 0x07" for safety (no real danger
though, I admit).

6* You don't have to define a saa1064_write_value function. This is done
in some drivers (lm75 for example) because the function actually does
something, but for simple drivers there is no need for such a function.

7* You can use a single call to i2c_check_functionality instead of two
by or'ing the constants. BTW, why are you using READ_BYTE and
WRITE_BYTE_DATA, but not READ_BYTE_DATA and WRITE_BYTE? This is a real
question, I just don't know what the difference is (and I realize I may
have set the wrong ones in the only driver I wrote so far).

8* The init function could be shortened using memset() (for setting
digits to 0x00). Also, you are not using the auto-increment feature as
described in the datasheet. I don't know if it is possible with our i2c
subsystem. Maybe that's what WRITE_I2C_BLOCK is for? (Just wondering, I
don't know much about this.)

9* I'm a bit skeptical about saa1064_update_client. (See 3*.) I don't
think you need an update function since your driver is write only by
nature. I don't know if you can remove it completely though. (As you can
see, there are really many things I don't know yet).

10* I suggest you be more flexible about the user writing too many
values to your sysctl files. You basically don't need to care about
that. Just ignore the extra values. I think that's what most of our
drivers do.

That's it. Don't be afraid because I seem to criticize much. It's
actually very good work. I just want to make it even better (perfect if
we only could). Each of the points above is subject to discussion, so I
want to hear you!

Thanks for the good work so far :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
