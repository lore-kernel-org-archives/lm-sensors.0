From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <Dhw8V8vi.1099905468.1780530.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

>OK, I reviewed all of the sensor chip drivers to see what is returned from
>each of their respective i2c_detect() callbacks.
>
>1. Almost all of the drivers return -ENOMEM in response to a kmalloc
>failure.  I think this is acceptable.  Exception: isp1301_omap.c

True. For consistency's sake, isp1301_omap.c could be "fixed".

>2. All of the drivers return any error from i2c_attach_client(). This is
>harder to understand... why should failure to attach *this* instance also
>prevent me from *detecting* others?

Agreed, this doesn't make much sense to me either. The only reason why
i2c_attach_client can fail in 2.6 is if the address is already in use.
Nothing critical and at any rate address-specific, so it shouldn't stop
from probing other addresses.

>Not counting the two cases above, the drivers that return non-zero in
>response to (what looks like) a failed detection include: asb100.c,
>it87.c, lm78.c, smsc47m1.c, via686a.c, w83627hf.c, and w83781d.c.  I'll
>work up a patch for these.

Thanks. Similar fixes would be welcome for 2.4/CVS as well (where there
may be a couple more drivers needing fixing).

>Whatever we agree are legitimate reasons to cancel detection, I would like
>to add specific documentation for them.  I think a case can be made that
>there's *no* legitimate reason for a driver to halt detection that way...
>but I'm sure I'll hear otherwise.

Nice foreseeing ;) I actually believe that stopping the probings on
memory shortage makes sense, as there is no reason why other memory
allocation requests would succeed, and we better don't insist. This is
the only case where I would agree with a "global failure" kind of
action. That said, I don't really want us to do that, just that the
current model lets us do it. If the model were to change (hint hint) and
we wouldn't be able to easily preserve this behavior, I wouldn't care.


>As an interface, this interpretation
>of a return value (I failed so badly that you're not allowed to call me
>again) isn't my favorite.

Agreed outside of the kernel. But in the kernel I think we can try to
optimize things a little more (not at any price though).

>Also note: all of the drivers register their sysfs files during their
><driver>_detect() function.  That suddenly seems weird to me... logically
>those calls belong to <driver>_attach_client(), no?

Probably true. If you go in that direction though, even more things can
be moved outside of *_detect functions. Chip configuration doesn't
really belong there, and even the call to i2c_attach_client doesn't.
Not sure it's worth the change now though, since it doesn't win
anything beyond the local driver structure cleanness.

Thanks,
Jean
