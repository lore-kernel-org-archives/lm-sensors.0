From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: adding support for new 2.6 chips in (lib)sensors
Message-Id: <20040111184623.14b71d37.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031230214411.6eb029e7.khali@linux-fr.org>
In-Reply-To: <20031230214411.6eb029e7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(Sorry for the delay, so busy...)

> > * I think there's a typo at lib/proc.h:438.
> 
> ?? you mean proc.c?
> I assume you fixed it, line numbers moved...

Yes I did.

> > * What's the reason for doing:
> >   if(sscanf(name, "temp%d_ove%c%c", &num, &last, &check) = 2
> >      && last ='r')
> > instead of
> >   if(sscanf(name, "temp%d_over%c", &num, &check) = 1)
> > ? I understand that you want to make sure that there's nothing after
> > "other" with the &check trick, but I don't see why you would also
> > need the &last trick for this. Anything obvious I'm missing?
> 
> In your example you can't tell if the "_over" part matched or not, can
> you? I know the way I did it is retarded, I just couldn't think of a
> better way. Anybody have an elegant way that works, speak up.

After a few tests (and reading the man page first) it appears that you
are right. I must be too used to the power of regular expressions, I
wouldn't figure that sscanf can fail matching the pattern and still
return non-zero.

I can't think of any other way, so let's stick to your method. It's not
that bad after all, just a bit harsh to understand at first (for me at
least).

> > * I'm seeing a strange behavior with the eeprom module for on my
> > Vaio(i.e. non-memory) eeprom. Usually sensors will say "Memory type:
> > Unavailable" (it's obviously not noticing this isn't a regular
> > memory eeprom). But it sometimes will succeed and print the
> > expected, vaio-specific data. I didn't investigate any further, but
> > there must be a bug hiding somewhere.
> 
> We're getting good at finding bugs in the bus drivers with eeprom.
> What bus driver? Any more clues?

This is i2c-i801, kernek 2.6 (.0 and .1 alike). No problem under
2.4.whatever.

(a few minutes later)

Ah ah, this was sooo ridiculously easy. The "eeprom" file has
permissions 0400, so sensors fails as a regular user and succeeds as
root. This was once a wanted behavior for the *first* row of the eeprom,
because it contains the BIOS password (if one was set). Now that the
whole eeprom is exported as a single file, that's quite different.

That said, the solution retained in 2.4 should still apply. We use
capable() to know if the caller is root, and is this case show the real
data. If not, show zeroes instead, for the first row only. I'm on it.

And no, i2c-i801 wasn't guilty ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
