From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <3FCD4C27.F243E25F@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> > Agreed that we are being exceptionally conservative.
> > I recommend that we proceed in baby steps, a little bit more in each
> > release, so that we get some testing and confidence.
> 
> Agreed. I'd even propose not to change anything before the next release.
> The detection method change is enough.
> 
> > Some way of separating Thinkpads from servers would be a good first
> > step. We could blacklist all Thinkpads but go a little farther with
> > the servers.
> 
> That's not necessarily easy. This means adding the list of known
> Thinkpad IDs to sensors-detect. As I explained, this is a list we would
> then have to maitain, with or without the help of IBM. You can imagine
> that someone with a brand new Thinkpad, not listed yet, would give a try
> to lm_sensors and have his/her laptop seen as a desktop IBM system.
> 
> And, since we don't have a list of desktop IDs, we can't build a
> white-list either.
> 

I was hoping the DMI would have a string that said 'laptop' or
'thinkpad',
or something would have a model number that was consistent with
laptop model numbers.

> This is how I came to my simple "IBM detected, block 24RF08 addresses"
> strategy. It is both safe and almost-non-intrusive, as far as I can see.
> 
> > > I first feared that the ddcmon would cause trouble because it
> > > declares 0x51-0x57 as subaddresses, but reading the driver code, it
> > > seems that it doesn't use them (and doesn't even "register" them).
> >
> > This is because some monitors use the exceptionally stupid 24C00 or
> > 24C01 (NOT 24C01A) eeproms that respond to ALL addresses 0x50-57 with
> > the same data. The subaddress declaration keeps sensors-detect from
> > recommending the driver getting loaded 8 times, or ddcmon once and
> > eeprom 7 times.
> 
> I think all my monitors do that. But since I read in the DDC specs that
> there could be more than one 256-byte block of data, I thought it was
> just normal. I clearly remember my monitors answering on all 8
> addresses, but I don't remember if all addresses were returning the same
> data. I'll take a look next time.
> 

It's not uncommon for 8 shadows, but the usual case is the more common
24C01A chip that responds to only one address.
