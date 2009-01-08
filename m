From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Thu, 08 Jan 2009 19:58:09 +0000
Subject: Re: [lm-sensors] abituguru3: no Abit uGuru3 found
Message-Id: <200901081958.09463.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <49657F3B.3060607@NickAndBarb.net>
In-Reply-To: <49657F3B.3060607@NickAndBarb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 08 January 2009 19:45:13 Jean Delvare wrote:
> On Thu, 08 Jan 2009 20:21:35 +0100, Hans de Goede wrote:
> > Alistair John Strachan wrote:
> > > I think the consensus we came to at the time was to switch to
> > > strncmp'ing a subset of the DMI string, but in this case we'll need
> > > strncasecmp. This isn't too terrible as false positives are pretty
> > > unlikely (we already check the board manufacturer too, which does seem
> > > to be unchanging). Hans?
> >
> > That was my idea too, just make the dmi string stored in the driver:
> > "IP35 Pro" and do a strncasecmp for the length of the string in the
> > driver, with the one from the BIOS, if it is a match assume we have found
> > an abituguru3 equipped motherboard.
>
> That's not enough, because some board names match the beginning of
> other supported board names (for example AW8 and AW8D.) 

I have just sent out another patch which does this, but I must point out that 
AW8 and AW8D are not yet converted to DMI because I haven't received any user 
dmidecode information. Therefore this problem would only manifest if and when 
they were added.

Though we could add these boards preemptively, there's a risk that variants of 
the DMI string could be present that were not previously accounted for (not 
that I haven't already made this mistake with the IP35 Pro, but it's a case in 
point).

-- 
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
