From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 31 Mar 2007 12:42:09 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <20070331144209.cd36dcab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Wed, 28 Mar 2007 14:07:18 +0200, Ivo Manca wrote:
> >> We were thinking about using the following:
> >> system-manufacturer
> >> system-product-name
> >> system-version
> >> system-serial-number
> >> baseboard-manufacturer
> >> baseboard-product-name
> >> baseboard-version
> >>
> >> It seems like these 6 fields covers all motherboards. Sending/storing the 
> >> serial number might also be a privacy issue.
> 
> > Good point.
> >
> > Do you require an exact match on all 7 parameters or do you cherry-pick 
> > the minimum that identify a motherboard?
> 
> Oops, system-serial-number didn't need to be in that list, making it 6 
> fields instead of 7. I was just copy/pasting ;)
> Anyway, we do need all the 6 to match. It might be true that some fields 

I believe that non-matching version numbers should not be fatal. It
sometimes happen that different versions of a board need different
configuration files, true, but it's rather rare, so we don't want to
store one configuration file per version in general, that would be
overkill; we'll only do so when really needed.

So I think we should try to match all 6 fields first, if it fails, try
without the versions (so only 4 fields), and only if that fails too,
declare that no matching configuration file was found.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
