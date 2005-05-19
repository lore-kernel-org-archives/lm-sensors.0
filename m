From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Bugzilla setup for Lm_sensors
Message-Id: <yRrTkCal.1106064650.7706850.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41E718CA.3070305@edgedesign.us>
In-Reply-To: <41E718CA.3070305@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Axel, hi Philip,

> I've set up a draft bugzilla on http://bugzilla.lm-sensors.org/ for
> playing with. Don't enter any serious bugs as the bugs will be wiped
> before going in production :)

Great.

Here are some random thoughts.

1* We would need a list of versions of lm_sensors that existed to be
picked from. I guess we can start at 2.0.0, and drop the few tickets of
the old base that refer to older versions. We might even set the
reversed deadline after that and drop everything before 2.5.0 for
example. Moving all the old tickets to the new base will be a
significant work so this would limit it, and I don't think anybody care
about these very very old tickets anyway. Default to the latest version.

2* I would replace Platform with Architecture, and list there all
architectures supposedly supported by lm_sensors (+ "other" just in
case).

3* I don't feel a need for a Priority setting. Severity should be
sufficient.

4* OS can go, as we only support Linux anyway. What would be more
interesting would be a version of Linux, which would be a free input
(because there are that many, and also because people will often report
non-vanilla versions).

Maybe we can keep the OS to make a difference between the Linux trees
(2.4, 2.6, and older ones for recovered tickets). This could help people
having a problem which they think only affect a given tree (think procfs
or sysfs issues).

5* Not sure why the reporter would be left a choice for the Initial
State. What is this "Unconfirmed" state for? A new report is, err,
New, period.

> I haven't yet renamed products to categories as one of the things to
> test is whether this hierarchical setup is OK or not.

Looks OK to me except for the lack of user-space category.

> I also allowed for flags, votes, milestone, QA contact and status
> whiteboard fields. Some of them are probably too much (or not) for
> lm_sensors, but I activated them for demonstration purposes. Anything
> that does not serve lm_sensors' needs will be dropped before going up.

I think I see what milestones and votes are for. But what are flags?

Is QA Contact something different than the default assignee for this
category? If yes, I don't think we need this.

> Which brings up the question: Who is the "initial owner" of each of
> the catgories above? I tend to think, that we need a dummy bugzilla
> account that is a catch-all, at least for the beginning. Perhaps
> abusing lm-sensors-devel@lm-sensors.org, so that all lm_sensors
> developers get to see bugzilla mail on orphaned bugs.

Each non-core driver would have a specific owner (current maintainer)
providing this person actually has a bugzilla account. For the rest of
the items, we can attribute them on a voluntarism basis, and using the
mailing-list for the remaining items and core items seems fine. And if
it doesn't please us in the long run we can change then.

> For testing the administrative part send me your created login account
> in PM and I will activate administrative access for it (like adding
> new components, new keywords, new flags, editing users etc).

Please do for me: (my e-mail address - don't think this is a really
private information so I don't think a PM was needed at all ;))

Thanks,
--
Jean Delvare
