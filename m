From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Vaio eeprom security issue
Message-Id: <20030811204610.GC18382@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806233617.5a83d0b6.khali@linux-fr.org>
In-Reply-To: <20030806233617.5a83d0b6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Aug 09, 2003 at 09:17:17AM +0200, Jean Delvare wrote:
> 
> > > I'm not sure I get what you mean there (what are these CAP_*
> > > values?).
> > 
> > Different capability permission values.  Look in
> > include/linux/capability.h for more information.  It's more fine
> > grained than just "root".
> > 
> > Hope this helps,
> 
> Not really. Looks complicated ;) and it seems these are capabilities you
> give to a user/process, not to a file. I just don't want to dive into
> this for something that "simple".

Why?  Just check for CAP_SYS_ADMIN if the Vaio is detected.  If that
succeeds, then give access, otherwise deny it.

> Remember, the eeprom module, although widely used, is one of our least
> interesting drivers.

But it's fun to play with :)

> And LM Sensors is useless on Sony Vaio's anyway (no sensor chips).

Looks like the eeprom driver works :)

> So let's play it safe, but without extra technologies involved. Do not
> export the eeproms detected as Vaio's ones unless forced too.

What does "forced too" mean here?

thanks,

greg k-h
