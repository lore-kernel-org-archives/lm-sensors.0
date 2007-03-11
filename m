From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 11 Mar 2007 17:13:05 +0000
Subject: [lm-sensors] libsensors patches
Message-Id: <45F438A1.30105@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311152104.bd092ff9.khali@linux-fr.org>
In-Reply-To: <20070311152104.bd092ff9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Mark M. Hoffman wrote:
> Hi Hans, Jean:
> 

<quoted stuff snipped>

> 
> First, I should be clear: I was planning to modify the libsensors ABI for
> libsensors 3.0.  That's the reason behind incrementing the major rev number
> from 2 to 3.
> 
> However, I was not planning to do a complete redesign.  I just don't have the
> time for that.  Here is an example of the type of change I'm planning to make:
> 
> -extern int sensors_match_chip(sensors_chip_name chip1, 
> -                              sensors_chip_name chip2);
> +extern int sensors_match_chip(const sensors_chip_name *chip1, 
> +                              const sensors_chip_name *chip2);
> 
> That breaks the ABI, but it's not a redesign.  Nor does it make it very
> difficult for libsensors users to update.  The most significant change would be
> to add 'include' functionality to the config scanner.  
> 

Why? I understand this may be an improvement speed-wise, but libsensors 
is afaik not really speed critical. To me (as a packager of a distro 
maintaining over a 100 packages) this is needless ABI breakage and as a 
packager I strongly dislike that. Breaking ABI is not something that 
should be done lightly and thus is in this case not warrented IMHO.

> However, I do appreciate that a true redesign may be warranted.  If you want to
> tackle this, please don't let me hold you back.  The sensors project has always
> been very liberal about SVN access and contributors, because we haven't had the
> luxury of having many contributors with lots of time.
> 

As said the API is not all it could be, but it works, accept for adding 
something to get the type of a feature I think it will do for now.

> If people with more time and/or energy come along, I don't want to stand in the
> way just because I've been around longer.  I can also tell you that Jean feels
> the same way (we're both on #linux-sensors as I write this.)
> 
> So how about this: you get SVN access, and get these patches committed to a
> feature branch (as I did some time ago for the scanner).  If everything's ready
> before 2.10.4, *you* can merge them back to the main line.  If it turns out you
> decide to go in a different direction (destabilize the API/ABI or whatever)
> then you're already on a branch so it's no big deal.
> 

Sounds like a good plan to me. My preferred user name is jwrdegoede. Do 
you want a public ssh-key? I can pgp sign the mail with the key with a 
long registered pgp-key if you want.

> Meanwhile, I'll work on the remainder of the 3.0 material on the branch I
> already have open, as I have time.  If it turns out that you want to do a
> complete API/ABI redesign, I can always abandon that part of the 3.0 branch.
> 

As said I've no plans to redo the ABI, my point is more that as long as 
we don't redesign it I see no reason for a 3.0 .

Regards,

Hans


