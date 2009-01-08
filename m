From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Jan 2009 19:45:13 +0000
Subject: Re: [lm-sensors] abituguru3: no Abit uGuru3 found
Message-Id: <20090108204513.5c0c34be@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49657F3B.3060607@NickAndBarb.net>
In-Reply-To: <49657F3B.3060607@NickAndBarb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 08 Jan 2009 20:21:35 +0100, Hans de Goede wrote:
> Alistair John Strachan wrote:
> > I think the consensus we came to at the time was to switch to strncmp'ing a 
> > subset of the DMI string, but in this case we'll need strncasecmp. This isn't 
> > too terrible as false positives are pretty unlikely (we already check the 
> > board manufacturer too, which does seem to be unchanging). Hans?
> 
> That was my idea too, just make the dmi string stored in the driver: "IP35 Pro" 
> and do a strncasecmp for the length of the string in the driver, with the one 
> from the BIOS, if it is a match assume we have found an abituguru3 equipped 
> motherboard.

That's not enough, because some board names match the beginning of
other supported board names (for example AW8 and AW8D.) So the algorithm
must really compare both strings on a
strip-everything-after-parenthesis-and-every-trailing-white-space basis.
That's a little more code, but still not rocket science, and that's the
only safe way.

(Actually, no, there's a second way: put the abituguru3_motherboards[]
entries in a clever order. But that could break easily, so I wouldn't
recommend it.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
