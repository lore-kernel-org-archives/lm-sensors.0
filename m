From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: New sensors web site (was Re: 2nd mail archive?)
Message-Id: <41C08207.5040801@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <41BDF25A.9030509@edgedesign.us>
In-Reply-To: <41BDF25A.9030509@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Jean Delvare wrote:
> [...]
> 
> Viewcvs?
> 
> (e.g. http://cvs.apache.org/viewcvs.cgi/)
> 
> Seems to support Subversion as well.
> 

That's another option, although I couldn't see how to download tarballs. 
(not critical)

>[...]Searching in it is especially cumbersome, I think.
> 
> 
> That's true but OTOH people are used to bugzilla because several major
> projects use it (linux kernel, mozilla, xmms and more). I think it can
> be configured and maybe the overkill features can be disabled in our
> case. It's certainly worth giving it a try. If someone can think of
> something as efficient but lighter, I'm listening.
> 

I'm not opposed to bugzilla if it is the best option.  Especially if we 
can start with a simplified version and grow into it's more advanced 
features.

Lots of interesting options on Freshmeat, but of course most solutions 
are somebody's half-baked weekend project written over a weekend in Ada 
for their Amiga. ;')

http://freshmeat.net/browse/846/

But, take a look at this:

http://www.edgewall.com/trac/screenshots.html

It happens to cover most of the things we were discussing, and a few 
more we hadn't thought of (like project time line, changeset summary, 
etc.)  A few shortfalls, but might be adaptable... just kicking around 
some thoughts.

> Oh, I would consider it a GREAT benefit if it were possible to import our
> existing 2500 tickets in the new support system and keep the numbering
> intact.
> 

Yes!  If the new system uses a SQL backend (like my favorite 
PostgreSQL), then it shouldn't be too bad to figure out how to import 
all the existing tickets in.


Phil
