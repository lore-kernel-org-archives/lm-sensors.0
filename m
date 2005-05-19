From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Update: SAA1064
Message-Id: <20030719095003.79680298.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307162122.07079.sascha@akv-soft.de>
In-Reply-To: <200307162122.07079.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> 
> > 2* I would unify the two "blank" sysctl files into one single file
> > with 2 values. What's more, I would change the convention. You have
> > 0 = blanked, 1 = not blanked, because it's that way in the
> > datasheet, but it won't make much sense for the user. So I think you
> > should either rename the sysctl file and associated data to, say,
> > "display", or, preferably, I would decide that 1 stands for blanked.
> 
> That's a good idea, I think I'll just do it. Maybe I should even but
> the dynamic flag into this sysctl, as well, since the blank bits are
> IMHO unnecessary when dynamic mode is on. As far as I've understood,
> dynamic mode means all digits are displayed repeatedly (at a very fast
> rate so the viewer doesn't notice), and in static mode only those
> digits not blanked by blank13/24 are shown.
> 
> I'll check that again, if this is the case all could be reduced to
> one tri-state sysctl (0=display all four digits, 1=display 1+3,
> 2=display 2+4). What do you think?

I'm not sure. I read the datasheet again, and I find a total of 7
possibilities, not 3 as you seem to think. I even took a sheet of paper
and a pencil to draw a nice table. Yes, really. I can scan it and send
it to you if you want ;) In the meantime, I'll try to recap my findings
here.

I think we agree on the fact that C0, C1 and C2 values all have an
effect on what is displayed. So lets try to see what is displayed for
all possible values (8) of C2C1C0. I'll represent the four digits in the
order "1 2 3 4". If they are actually in the order "4 3 2 1", just
invert the results. It won't change the meaning anyway. I use an "8" to
say a digit is used, a white space to say a digit is blanked.

Static mode:

C2C1C0    1 2 3 4
 0 0 0           
 0 1 0    8      
 1 0 0      8    
 1 1 0    8 8    

Dynamic mode:

C2C1C0    1 2 3 4
 0 0 1           
 0 1 1    8   8  
 1 0 1      8   8
 1 1 1    8 8 8 8

So as you can see, except for the fact that dynamic mode is useless if
C2C1=00, all other modes are different.

Now the real point is to know what you need as a user. The fact that we
can do all that with that chip does not mean you have to implement it in
your driver. If there is no need for that in userland, just don't
implement it.

One think I don't really understand is the reason they did these flags
after all. In which way is it different to blank one digit and to
display nothing (I guess the value is 0x00) on it? Does it show in a
different way on your display (such as very low light vs. no light at
all)? Or maybe is it faster to "unhide" a digit than to set it's value?
In this case, we could imagine that some users want to write the value
while the digit is blanked, and display it "at once"? However, I doubt
this is the case, because the display change speed must be limited by
the physical speed of the leds more than by any other factor. Third
possibility, this allows one to keep the value "in memory" while not
displaying it. Maybe interesting in some cases, but I don't see the need
in our case.

Since you are the only user, can you tell me your point about all these?
I really think we should not use these bits unless we have a real reason
to do so. I will still be possible to add them later if we want to.

(3*)

> I'll implement your "refresh" suggestion - by the way is it really
> possible to write to a read-only (mode 0444) sysctl??!

Of course not, but you could make it write-only (mode 0222 or 0200, at
your option). Anyway, I think it's better to make it read only, and
trigger the refresh on read. It's more in the spirit of the other
driver, so to say.

> > 5* SAA1064_CTRL_SET_BRIGHT(c,val) is not safe. You don't limit the
> > change to 3 bits. I would add a "& 0x07" for safety (no real danger
> > though, I admit).
> 
> I've thought about that and found it not dangerous, too. I didn't know
> if you folks count on that kind of construct, or maybe even dislike
> it. I'll put it in now I know it's ok :-).

I don't think we have a policy for that. Our drivers have been written
by dozens of different people, so it's kind of hard to be really strict
on all things (and why would we want to?). I guess I should have kept
quiet this time ;) In my own driver, I remember I skipped some limit
checking too, for code simplicity. So do as you want.

> > 7* You can use a single call to i2c_check_functionality instead of
> > two by or'ing the constants. BTW, why are you using READ_BYTE and
> > WRITE_BYTE_DATA, but not READ_BYTE_DATA and WRITE_BYTE? This is a
> > real question, I just don't know what the difference is (and I
> > realize I may have set the wrong ones in the only driver I wrote so
> > far).
> 
> Well since i use i2c_smbus_write_byte_data(i2c_client*, u8, u8) and 
> i2c_smbus_read_byte(i2c_client*), I thought it would be best to check
> the same funcs that I'm using :-) (WRITE_BYTE_DATA for write_byte_data
> and READ_BYTE for read_byte). The difference is, that the _data
> functions expect a register address to write to/read from, and the
> ones without _data merely write a byte to the bus with no register
> address. Since the read register has no address, I use
> i2c_smbus_read_byte instead of .._byte_data.

Oh of course, it's all clear to me know. That's rather logical. Anyway I
guess I'll end up reading the I2C specs (at least this part) to know
more about the different modes, and what happens if one uses a mode the
chip does not particularly like. I really would like to know that,
because that's what I do for the SAA1064 in sensors-detect. I use the
READ_DATA_BYTE mode while the SAA1064 want READ_BYTE mode. I wonder what
will happen... Well, you tell me when you try ;)

> > 9* I'm a bit skeptical about saa1064_update_client. (See 3*.) I
> > don't think you need an update function since your driver is write
> > only by nature. I don't know if you can remove it completely though.
> > (As you can see, there are really many things I don't know yet).
> 
> I just adapted the pcf8574 behaviour of reading the only register in 
> update_client, which is only done if the last read has been some time 
> earlier (the jiffies count is compared there).

The PCF8574 has a readable register, really? Could not find in in the
datasheet. That could help me detect it in sensors-detect... (Some
reading after) Hm, it ain't a register but the I/O value, so I can't
assume anything about it. It can have any value and even change if it is
in input mode (I'm not sure I really understand how input vs. output
works though).

> I think this isn't very
> safe, since two reads with only a very short delay between would both 
> return "1" for powerloss (but the bit has been reset in the meantime).

I hadn't think about that. Well seen.

> I think this function won't be necessary anymore if I implement the
> "refresh" sysctl instead.

Right.

> Anyway I've even found a driver in your package containing the
> update_client skeleton, saying /* Nothing yet */ instead of doing
> anything (except updating the jiffies count).

OK, this means you can do just the same if you don't have anything do to
there anymore.

> > 10* I suggest you be more flexible about the user writing too many
> > values to your sysctl files. You basically don't need to care about
> > that. Just ignore the extra values. I think that's what most of our
> > drivers do.
> 
> You mean, remove that "this device has only 4 digits" message? Well,
> I'll embrace it with #ifdef DEBUG..#endif, just to be sure :-)))

That, plus replacing "if (*nrels_mag = 1)" with "if (*nrels_mag >= 1)"
for the other files. I think most of our drivers do that.

> BTW: Concerning your new sensors-detect, I'll check it tomorrow or
> sunday, since my only i2c-machine has a really small installation (10
> MB so far) and I think you understand there's no perl yet, within 10
> MB, so I have to install it first :-)

Of course. You know it could increase your disk usage by up to 180%? :/
My perl package uses 18MB. You don't need all the modules though, and I
guess you'll remove the whole think as soon as the tests are over.

Thanks for your help and good work.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
