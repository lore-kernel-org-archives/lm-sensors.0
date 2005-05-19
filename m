From: sean@dague.net (Sean Dague)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: libsensors LGPL?
Message-Id: <20040903132401.GB1223@underhill.home.pvt>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040901195453.GB20275@underhill.home.pvt>
In-Reply-To: <20040901195453.GB20275@underhill.home.pvt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 03, 2004 at 12:18:15PM +0100, Jean Delvare wrote:
<snip> 
> The problem was already discussed:
> http://archives.andrew.net.au/lm-sensors/msg04415.html
> http://archives.andrew.net.au/lm-sensors/msg06413.html
> http://archives.andrew.net.au/lm-sensors/msg07873.html
> 
> And as a result the part you quoted from the README file has been updated, and
> now reads:
> 
> -----------------------
> Note that libsensors falls under the GPL, not the LGPL.  In more human
> language, that means it is FORBIDDEN to link any application to the
> library, even to the shared version, if the application itself does not
> fall under the GPL.
> -----------------------
> 
> This is not going to change because it would require all former contributers
> to agree on the change, and it's a bit late for that.
> 
> At any rate, libsensors needs complete rewriting to be freed from
> chip-specific code for the Linux 2.6 driver. I don't have much time at the
> moment to do it (and lack some knowledge about config file parsing as well)
> but anyone doing it may release it under the LGPL, which would let anyone link
> against it.

That's about what I expected, but I figured I would ask. :)  
Thanks for the quick response and clarification.

	-Sean

-- 
__________________________________________________________________

Sean Dague                                       Mid-Hudson Valley
sean at dague dot net                            Linux Users Group
http://dague.net                                 http://mhvlug.org

There is no silver bullet.  Plus, werewolves make better neighbors
than zombies, and they tend to keep the vampire population down.
__________________________________________________________________
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040903/f409e12d/attachment.bin
