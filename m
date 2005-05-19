From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <20041108024751.GB16161@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

> * Jean Delvare <khali@linux-fr.org> [2004-11-04 14:34:57 +0100]:
> > There are several other drivers that would need a similar fix, such as
> > w83781d and possibly it87. Other drivers I looked at seem to be OK
> > (lm75, lm83, lm90, w83627hf). I guess that a full review of all client
> > drivers would be welcome.

* Mark M. Hoffman <mhoffman@lightlink.com> [2004-11-04 13:01:31 -0500]:
> Looks like I've misunderstood this for quite some time.  Other drivers
> are broken like this thanks to me "fixing" them during 2.6.0-pre.  It
> just seemed obvious that a misdetection should return -ENODEV.  It's no
> excuse though, as you pointed out - the docs are clear enough.

OK, I reviewed all of the sensor chip drivers to see what is returned from
each of their respective i2c_detect() callbacks.

1. Almost all of the drivers return -ENOMEM in response to a kmalloc failure.
I think this is acceptable.  Exception: isp1301_omap.c

2. All of the drivers return any error from i2c_attach_client(). This is
harder to understand... why should failure to attach *this* instance also
prevent me from *detecting* others?

Not counting the two cases above, the drivers that return non-zero in
response to (what looks like) a failed detection include: asb100.c,
it87.c, lm78.c, smsc47m1.c, via686a.c, w83627hf.c, and w83781d.c.  I'll
work up a patch for these.

Whatever we agree are legitimate reasons to cancel detection, I would like
to add specific documentation for them.  I think a case can be made that
there's *no* legitimate reason for a driver to halt detection that way...
but I'm sure I'll hear otherwise.  As an interface, this interpretation
of a return value (I failed so badly that you're not allowed to call me
again) isn't my favorite.

Also note: all of the drivers register their sysfs files during their
<driver>_detect() function.  That suddenly seems weird to me... logically
those calls belong to <driver>_attach_client(), no?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
