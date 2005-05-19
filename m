From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Bugzilla setup for Lm_sensors
Message-Id: <20050118135710.GG20232@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <41E718CA.3070305@edgedesign.us>
In-Reply-To: <41E718CA.3070305@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Fri, Jan 14, 2005 at 10:27:13AM -0800, Philip Edelbrock wrote:
> Jean Delvare wrote:
> > > I'm thinking 'i2c' and 'lm_sensors' for the products. And then breaking
> > > out each driver (chip and bus) for the components, each app in 'prog'
> > > (e.g. 'i2c-detect','sensors-detect',etc.) and adding either a catchall
> > > for the rest of the code or breaking them out further (e.g. 'dev',
> > > 'proc', 'core', etc.).
> > > What do you think?
> >
> > What are these "Products"? When looking at the kernel's bugzilla I see
> > categories and components within the categories, but no products.

> I think it's the same, it's just a labelling difference.

Yes, they are the same, just a different "locale" :)


> > I would use the Categories for that. I would propose the following
> > categories, with non-exhaustive components lists:
> >
> > i2c core drivers
> >    |--> i2c-core
> >    |--> i2c-proc
> >    |--> i2c-dev
> >    |--> i2c-isa
> > bus drivers
> >    |--> i2c-ali15x3
> >    |--> i2c-ali1535
> >    |--> i2c-i801
> >    |--> i2c-viapro
> >    |--> ...
> > chip drivers
> >    |--> adm1021
> >    |--> adm1025

> > I guess it somehow covers the hierarchical structure you were thinking of.
> I like this.  Seems more intuitive than what I originally was thinking.

I've set up a draft bugzilla on http://bugzilla.lm-sensors.org/ for
playing with. Don't enter any serious bugs as the bugs will be wiped
before going in production :)

I haven't yet renamed products to categories as one of the things to
test is whether this hierarchical setup is OK or not.

I also allowed for flags, votes, milestone, QA contact and status
whiteboard fields. Some of them are probably too much (or not) for
lm_sensors, but I activated them for demonstration purposes. Anything
that does not serve lm_sensors' needs will be dropped before going up.

> > > The main purpose of components is for developers to be auto-assigned
> > > them and to be able to sort easier through the bugs.
> >
> > Completely agree. It would help much if we could all get an alert
> > when one of "our" drivers gets a report, instead of having to
> > watch the tickets as they are created and ignore those we don't
> > feel competent for.

Which brings up the question: Who is the "initial owner" of each of
the catgories above? I tend to think, that we need a dummy bugzilla
account that is a catch-all, at least for the beginning. Perhaps
abusing lm-sensors-devel@lm-sensors.org, so that all lm_sensors
developers get to see bugzilla mail on orphaned bugs.

For testing the bugzilla entity: Just create your account. You will
have user access, e.g. you will be able to create new bugs, comment on
others, menipulate your own bugs as submitters etc.

For testing the administrative part send me your created login account
in PM and I will activate administrative access for it (like adding
new components, new keywords, new flags, editing users etc).
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050118/27d616ff/attachment.bin
