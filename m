From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: lm83 driver ported to linux 2.6
Message-Id: <20030930213041.3119f338.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030929213648.5ebc26bd.khali@linux-fr.org>
In-Reply-To: <20030929213648.5ebc26bd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > BTW, I'm a bit disappointed by the new sysfs interface. Where I had
> > 3 callback functions with procfs, I now have 15. They are shorter
> > for sure, still 15 is much for such a simple driver. The fact that
> > you need macros to define them shows IMHO that there's something
> > wrong there(although I don't know what and have no real suggestion
> > for improvement).
> 
> If you don't like registering all of the different files, look into
> using sysfs_create_group() and sysfs_remove_group().  It makes large
> numbers of attributes a bit easier to deal with.

Took a look, not sure how I am supposed to use it. Does it replace
device_create_file() calls, DEVICE_ATTR() "calls", or both? Anwyway, the
number of files isn't really a problem. There are 10 now, as opposed to
6 before, that's not so different. What I was worrying about is the
number of callback functions, especially since they are all so similar.
Anyway, I don't intend to discuss that, I guess that it has already been
discussed many times by more experimented people, and things wouldn't be
that way in 2.6 if if wasn't Good.

All comments that do not have a reply below have been agreed and fixed.

> > +#define LM83_REG_R_MAN_ID        0xFE
> 
> No tabs used here or in any of the other #defines.

On purpose. This keeps values aligned whatever the tabstop value is set
to.

> > +static struct i2c_driver lm83_driver = {
> > +	.owner          = THIS_MODULE,
> > +	.name           = "lm83",
> > +	.id             = I2C_DRIVERID_LM83,
> > +	.flags          = I2C_DF_NOTIFY,
> > +	.attach_adapter = lm83_attach_adapter,
> > +	.detach_client  = lm83_detach_client
> > +};
> 
> Use tabs here before the '='

Spaces used here on purpose, same reason given right above.

> and put a ',' after lm83_detach_client to
> make any future changes not involve changing that line.

Agreed, I've edited this kind of structures so many times this last
month that I perfectly understand what you do mean.

> > +	if (kind < 0) /* detection */
> > +	{
> 
> Ick, please put the '{' back up on the if line.  Read
> Documetation/CodingStyle for more info on this.

I think I read this some times ago, but forgot to apply this rule to my
code, sorry (mainly because I believe that coding styles are mostly
pointless; you know when code is unreadable, you don't need to check
wether they follow the Ultimate Coding Style to decide; so as long as
code looks clean, I don't care where the curly brackets and other signs
are.)

OK, I hope that I got them all this time.

> As there is only 1 "kind" supported by this driver, this whole logic
> can be simplified a bunch.  Just check the man_id and chip_id and then
> exit out if it doesn't match.

This is a placeholder for future support of the LM82. Support isn't
added until we know for sure that motherboards exist, which use the LM82
(at which time we'll think of moving support for some chips, such as the
LM84, from adm1021 to lm83) but the driver was written with this in
mind. This is why the identification step may look too complex.

> > +	device_create_file(&new_client->dev, &dev_attr_temp_input1);
> > (...)
> > +	device_create_file(&new_client->dev, &dev_attr_alarms);
> > +
> > +	/*
> > +	 * Initialize the LM83 chip
> > +	 */
> > +
> > +	lm83_init_client(new_client);
> 
> You should probably initialize the chip before registering it with the
> i2c core as it can be queried right then before this call could be
> finished.

All drivers do things in that order, this is why I did so. Still what
you say sounds reasonable, so all drivers should probably behave the way
you suggest (although I don't think there is any real danger here).

> >  #define I2C_DRIVERID_W83627HF 1038
> >  #define I2C_DRIVERID_LM85 1039
> > +#define I2C_DRIVERID_LM83 1040
> 
> What do we do with these ids?

We bow before them and talk about them with respect. What else? ;)

Seriously, I don't know. You seem to believe they are useless. If they
are, we could get rid of them, which would unburden us of the
keep-IDs-in-sync job.

> Anyway, very nice job.  With those minor fixes I'd be glad to add it
> to the 2.6 kernel tree.

Thanks. Waiting for you to answer my "questions" above (actually, tell
me which of your inquiries I can bypass, if any ;)) before I submit a
new version of my patch.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
