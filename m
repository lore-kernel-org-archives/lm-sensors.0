From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: Some thoughts about the sysfs interface (repost)
Message-Id: <20031115203301.GC23877@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031109125157.51f9d552.khali@linux-fr.org>
In-Reply-To: <20031109125157.51f9d552.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 09, 2003 at 12:51:57PM +0100, Jean Delvare wrote:
> 
> Hi all,
> 
> (Same player, try again, *with* the patch, that time.)
> 
> I had to update the doc/developers/proc document for the lm83 driver (it
> has four temperature channels). The same change will be needed when the
> driver makes it into Linux 2.6. Greg, attached is a patch I suggest you
> apply at the same time you'll apply my lm83 patch to Linux-2.6.0.
> 
> Some points I'd like to discuss about:
> 
> 1* Most entries are described using sentences like "Fixed point value in
> form XXXXX and should be divided by 1000 to get degrees Celsius". I
> don't understand the "fixed point" thing, nor do I understand the
> informational value of "in form XXXXX". Wouldn't it be much clearer to
> write "Integer value, thousandth of degrees Celsius"?

They are pretty much the same thing, right?  Either way is fine with me.

> 2* temp_min[1-3] reads: "Temperature min or hysteresis value.". This is
> a Bad Idea (TM) IMHO. One very interesting point in the sysfs interface
> over the procfs one is that it could be easily be made chip-independant
> (libsensors and sensors could then be drastically simplified). If the
> file is named temp_minN, it has to be a min temp. Be it a hysteresis
> one, let's call the file temp_hystN instead. It's in no way harder to do
> it that way, and it will be way easier for the interface users
> (includind ourselves) if we stick to the one name, one use philosophy.

Ah, I like this proposal, it makes a lot more sense.  Care to also fix
up the drivers that are in the current 2.6 tree to follow this rule?

> 3* One additional note about hysteresis temperatures (and critical
> temperatures also). Some chips have several temperature channels, but a
> single hysteresis and/or critical temperature register, common to all
> channels. For example, the LM83 has four temperature channels, four max
> values, but one single critical value. The ADM1032 has two temperature
> channels, two min values, two max values, two critical temperatures, but
> a single, relative hysteresis value that applies to both critical
> values.
> 
> I propose that chips that values that are common to all channels simply
> have no digit appended. That's how I made it in the lm83 driver.

Makes sense.

> Now, for the hysteresis, that's more complicated, since not only it may
> apply to one or more channels, but it can also happen to one or more
> limit, and be relative or absolute. I think that hysteresis files should
> be named after the limit they are an hysteresis for. In the case of the
> lm90 driver, we would have the following files:
>   temp1_input
>   temp2_input
>   temp1_min
>   temp2_min
>   temp1_max
>   temp2_max
>   temp1_crit
>   temp2_crit
>   temp_crit_hyst
> Note that the digit is also omitted, since the value is common to both
> channels. An hysteresis that would apply to all temperatures of one
> channel would be named "temp1_hyst". An hysteresis that would apply to
> more than one channel and more than one limit for each channel would be
> called temp_hyst. I think you get the idea.

As you stated, this has some problems.  I think we should probably not
do this for now, and if we have some real compilcated chips in the
future, that we need these changes for, we can revisit it.

Sound ok?

> --- linux-2.6.0-test9/Documentation/i2c/sysfs-interface	Sun Nov  9 11:13:32 2003
> +++ linux-2.6.0-test9/Documentation/i2c/sysfs-interface.lm83	Sun Nov  9 12:40:48 2003

Should I still apply this patch?

thanks,

greg k-h
