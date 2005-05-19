From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: lm83 driver ported to linux 2.6
Message-Id: <20030930195314.GA20213@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030929213648.5ebc26bd.khali@linux-fr.org>
In-Reply-To: <20030929213648.5ebc26bd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 30, 2003 at 09:30:41PM +0200, Jean Delvare wrote:
> 
> > > BTW, I'm a bit disappointed by the new sysfs interface. Where I had
> > > 3 callback functions with procfs, I now have 15. They are shorter
> > > for sure, still 15 is much for such a simple driver. The fact that
> > > you need macros to define them shows IMHO that there's something
> > > wrong there(although I don't know what and have no real suggestion
> > > for improvement).
> > 
> > If you don't like registering all of the different files, look into
> > using sysfs_create_group() and sysfs_remove_group().  It makes large
> > numbers of attributes a bit easier to deal with.
> 
> Took a look, not sure how I am supposed to use it. Does it replace
> device_create_file() calls, DEVICE_ATTR() "calls", or both? 

The device_create_file() calls.

> > > +#define LM83_REG_R_MAN_ID        0xFE
> > 
> > No tabs used here or in any of the other #defines.
> 
> On purpose. This keeps values aligned whatever the tabstop value is set
> to.

Tabs are ALWAYS set to 8 in Linux kernel code.  Please use tabs.

> > > +static struct i2c_driver lm83_driver = {
> > > +	.owner          = THIS_MODULE,
> > > +	.name           = "lm83",
> > > +	.id             = I2C_DRIVERID_LM83,
> > > +	.flags          = I2C_DF_NOTIFY,
> > > +	.attach_adapter = lm83_attach_adapter,
> > > +	.detach_client  = lm83_detach_client
> > > +};
> > 
> > Use tabs here before the '='
> 
> Spaces used here on purpose, same reason given right above.

Again, fix this for the same reason above :)

> > > +	if (kind < 0) /* detection */
> > > +	{
> > 
> > Ick, please put the '{' back up on the if line.  Read
> > Documetation/CodingStyle for more info on this.
> 
> I think I read this some times ago, but forgot to apply this rule to my
> code, sorry (mainly because I believe that coding styles are mostly
> pointless; you know when code is unreadable, you don't need to check
> wether they follow the Ultimate Coding Style to decide; so as long as
> code looks clean, I don't care where the curly brackets and other signs
> are.)

It really does matter.  As long as you are writing kernel code, follow
the rules.  It matters to be consistant.  There is a lot of research
that has been done on this in the past.  See my 2002 OLS paper about the
topic for more details about why it matters, and in depth explainations
for all of the written Documentation/CodingStyle rules, and for some
details about some of the unwritten ones.

> > As there is only 1 "kind" supported by this driver, this whole logic
> > can be simplified a bunch.  Just check the man_id and chip_id and then
> > exit out if it doesn't match.
> 
> This is a placeholder for future support of the LM82. Support isn't
> added until we know for sure that motherboards exist, which use the LM82
> (at which time we'll think of moving support for some chips, such as the
> LM84, from adm1021 to lm83) but the driver was written with this in
> mind. This is why the identification step may look too complex.

Ah, ok, leave this alone then.

> > > +	device_create_file(&new_client->dev, &dev_attr_temp_input1);
> > > (...)
> > > +	device_create_file(&new_client->dev, &dev_attr_alarms);
> > > +
> > > +	/*
> > > +	 * Initialize the LM83 chip
> > > +	 */
> > > +
> > > +	lm83_init_client(new_client);
> > 
> > You should probably initialize the chip before registering it with the
> > i2c core as it can be queried right then before this call could be
> > finished.
> 
> All drivers do things in that order, this is why I did so. Still what
> you say sounds reasonable, so all drivers should probably behave the way
> you suggest (although I don't think there is any real danger here).

Hm, patches to fix up the other driver will be gladly accepted :)

> > >  #define I2C_DRIVERID_W83627HF 1038
> > >  #define I2C_DRIVERID_LM85 1039
> > > +#define I2C_DRIVERID_LM83 1040
> > 
> > What do we do with these ids?
> 
> We bow before them and talk about them with respect. What else? ;)
> 
> Seriously, I don't know. You seem to believe they are useless. If they
> are, we could get rid of them, which would unburden us of the
> keep-IDs-in-sync job.

That would be nice.  I'll look into it in the future, it's ok to have
this for now.

thanks,

greg k-h
