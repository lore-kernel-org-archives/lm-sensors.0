From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Bugzilla setup for Lm_sensors
Message-Id: <20050119010457.GN20232@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <41E718CA.3070305@edgedesign.us>
In-Reply-To: <41E718CA.3070305@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Tue, Jan 18, 2005 at 05:10:50PM +0100, Jean Delvare wrote:
> > I've set up a draft bugzilla on http://bugzilla.lm-sensors.org/ for
> > playing with. Don't enter any serious bugs as the bugs will be wiped
> > before going in production :)

> 1* We would need a list of versions of lm_sensors that existed to be
> picked from.

Yes, I had forgotten to place some versions to play with. I added some
to "bus drivers" as a demo.

> 2* I would replace Platform with Architecture, and list there all
> architectures supposedly supported by lm_sensors (+ "other" just in
> case).

Which are these? i386 and x86_64?

> 3* I don't feel a need for a Priority setting. Severity should be
> sufficient.

I think this cannot be dumbed. It is also a bit different. A blocker
severity in a development version could be of lower priority than a
major serverity of security issues in a released version. Or you could
move an enhancement at higher priority than a trivial fix etc.

> 4* OS can go, as we only support Linux anyway. What would be more
> interesting would be a version of Linux, which would be a free input
> (because there are that many, and also because people will often report
> non-vanilla versions).
> 
> Maybe we can keep the OS to make a difference between the Linux trees
> (2.4, 2.6, and older ones for recovered tickets). This could help people
> having a problem which they think only affect a given tree (think procfs
> or sysfs issues).

That's a good idea. bugzilla only supports one-dimensional versioning,
e.g. it would not be able to really deal with lm_sensors x Linux
version tuples. By abusing the OS field, we can effectivly achive
that. :)

> 5* Not sure why the reporter would be left a choice for the Initial
> State. What is this "Unconfirmed" state for? A new report is, err,
> New, period.

Unconfirmed means it may be not a bug at all. New means it is a bug
but has not yet been assigned to anyone. You can drop the unconfirmed,
I currently set it up for having to vote (with one vote) to make a bug
new. Personally I don't think voting in general makes sense, but I
left it for playing.

> > I haven't yet renamed products to categories as one of the things to
> > test is whether this hierarchical setup is OK or not.
> 
> Looks OK to me except for the lack of user-space category.

OK, added. But not components, yet, so it does not show up. Try adding
some to see the mechanics of it (You are and admin now).

> > I also allowed for flags, votes, milestone, QA contact and status
> > whiteboard fields. Some of them are probably too much (or not) for
> > lm_sensors, but I activated them for demonstration purposes. Anything
> > that does not serve lm_sensors' needs will be dropped before going up.
> 
> I think I see what milestones and votes are for. But what are flags?

flags can be used for example to ask for a review before commiting
something. check out the example on
http://www.bugzilla.org/docs/2.18/html/flags-overview.html

> Is QA Contact something different than the default assignee for this
> category? If yes, I don't think we need this.

It's the supervisor of the poor assignee, I also don't like him ;)

> > Which brings up the question: Who is the "initial owner" of each of
> > the catgories above? I tend to think, that we need a dummy bugzilla
> > account that is a catch-all, at least for the beginning. Perhaps
> > abusing lm-sensors-devel@lm-sensors.org, so that all lm_sensors
> > developers get to see bugzilla mail on orphaned bugs.
> 
> Each non-core driver would have a specific owner (current maintainer)
> providing this person actually has a bugzilla account. For the rest of
> the items, we can attribute them on a voluntarism basis, and using the
> mailing-list for the remaining items and core items seems fine. And if
> it doesn't please us in the long run we can change then.
> 
> > For testing the administrative part send me your created login account
> > in PM and I will activate administrative access for it (like adding
> > new components, new keywords, new flags, editing users etc).
> 
> Please do for me: (my e-mail address - don't think this is a really
> private information so I don't think a PM was needed at all ;))

Done so.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050119/59b20250/attachment.bin
