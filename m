From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sun, 04 Mar 2007 17:00:28 +0000
Subject: [lm-sensors] Call for 2.10.3
Message-Id: <20070304170028.GE5536@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070303171327.186cd0f4.khali@linux-fr.org>
In-Reply-To: <20070303171327.186cd0f4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans, Jean:

* Hans de Goede <j.w.r.degoede at hhs.nl> [2007-03-04 12:15:51 +0100]:
> >> What about the:
> >> -dynamic sysfs chip support
> >> -get_sensor_type addition
> >> -generic print suppoty in sensors the program
> >>
> >> A previous group of my students has been worming on, any chance some of 
> >> those could make it, or maybe that we can start looking at them after 
> >> the 19th?

> Jean Delvare wrote:
> > I discussed this with Mark M. Hoffman and we agreed that this was
> > lm-sensors 3.0 material. Mark is more or less in charge of the
> > lm-sensors 3.0 tree, while I'm taking care of the current "stable"
> > branch (2.10.x)

That said, I don't "own" the 3.0 branch.  Jean and I have offered commit access
to you and your students for exactly the reason that our time is limited.  I
have Bob's patches queued up, it's just that I lack the time right now.

> Hmm, that doesn't make me happy, I told my students to not do any API 
> changes, as the idea was to get this into 2.x somewhere, as I don't see 
> 3.0 happening anytime soon. Note that the all the patches only come into 

3.0 was meant to happen following 2.10.3, or .4 at the latest.  July 2007.  I
have not had spare cycles to spend on it yet this whole year, but I expect the
pressures of my job to ease up by the end of this month.  

> play when libsensors / sensors doesn't know howto handle a chip, so for 
> existing cases nothing changes. (although I plan to remove abituguru 
> support from 2.10 when my students code has proven to handle that well, 
> and the same could be done for other 2.6 only chips).
> 
> Any chance you and Mark could reconcider, and this time do the 
> discussion on the list so I get a chance to influence it?

Yes, we should probably send summaries of our occasional IRC discussions to
the list.  On the other hand, if you look at the trak site, you will see the
3.0 milestone and everything I would like to do for it.

Do you think that July is too long to wait?  If so, what do you propose?

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


