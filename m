From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 21 Dec 2006 12:12:10 +0000
Subject: [lm-sensors] generic chip support for sensors
Message-Id: <20061221121210.GA12560@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061210000539.1f2f2bbd@ws01.atreidis.nl.eu.org>
In-Reply-To: <20061210000539.1f2f2bbd@ws01.atreidis.nl.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bob:

> On Tue, 19 Dec 2006 08:11:01 -0500
> "Mark M. Hoffman" <mhoffman at lightlink.com> wrote:
> > 
> > +	/* this will only work when the sensors_chip_feature is obtained
> > through  +		sensors_get_all_features */
> > +	if (((const struct sensors_chip_feature *)feature)->sysname)
> > +		name = ((const struct sensors_chip_feature *)feature)->sysname;
> > +	else
> > +		name = feature->name;
> > 
> > That cast in the if statement is no good.  I completely understand why
> > you tried to do it that way... the existing libsensors code casts from
> > one struct type to the other before returning it to the user.  The
> > last time I noticed that, I made a note to myself to fix it because
> > it's very fragile.  

* Bob Schl?rmann <bob2 at dsv.nl> [2006-12-19 21:29:22 +0100]:
> Can you tell me why this is not a good thing, apart from the case where
> a programmer creates the sensors_feature_data himself. Is it because of
> alignment issues?

It's just fragile, that's all.  When you have two structs with compatible
layouts and you cast from one to the other, you're circumventing C's type-
checking abilities.  If someone adds an element at the front of one struct but
not the other, it's going to break at run-time with no notice from the
compiler.

If you make the smaller struct a proper member of the larger struct, then of
course you can lift a pointer to the former from the latter without risking any
maintenance mistakes.

Using container_of to go in the other direction still circumvents the
type-checking, but it's less fragile.  E.g. if someone adds an element at the
front of the larger struct, container_of will handle that.  The existing code
would break in that case.

> > 
> > Here's what we should be doing:
> > 
> > --- data.h	(revision 4253)
> > +++ data.h	(working copy)
> > @@ -150,11 +150,7 @@
> >       Scaling can be positive or negative but negative values aren't
> >       very useful because the driver can scale that direction itself.
> >       */
> >  typedef struct sensors_chip_feature {
> > -  int number;
> > -  const char *name;
> > -  int logical_mapping;
> > -  int compute_mapping;
> > -  int mode;
> > +  sensors_feature_data data;
> >    int sysctl;
> >    int offset;
> >    int scaling;
> > 
> > Of course, a lot of other code will need to be fixed up to accomodate
> > that change.  Would you mind doing this in a separate patch? 
> > Otherwise I'll do it.
> > 
> 
> I'm ok with doing this, as I still have some time to spend for the
> project. Just to make sure I understand it, this change would require
> to:
> 
>  * include {} around the first 5 elements of each sensors_chip_feature
> entry in chips.c
> * let sensors_get_all_features() return the new member
> * adapt sensors_feature_get_type() to use container_of
> 

Pretty much.  I would grep on sensors_chip_feature to find any other
candidates.

> > 
> > And then the above would become:
> >
> > 		if (!strncmp(name + 1, "hyst", 4))
> >
> > etc.
> >
> > However... maybe you would be better off just using regular
> > expressions to do all this pattern matching.  It certainly would be
> > easier to read and maintain. Plus, there are other places in
> > libsensors that would benefit from regex.  Try 'man 3 regcomp'.
> 
> This seems like a very good suggestion. Our first idea was to use all
> sorts of optimising tricks like reading the first char of the name to
> find the type.
> 
> But using regex seems much more readable and maintainable so we've
> decided to use it.
> 
> The other suggetions about the spaces between enum members and the
> MAX_INT option are easy to fix and will be done in the next version.

Great.  Thanks again for doing this work.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


