From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: New sensors web site (was Re: 2nd mail archive?)
Message-Id: <41BF705D.5080309@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <41BDF25A.9030509@edgedesign.us>
In-Reply-To: <41BDF25A.9030509@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Jean Delvare wrote:
>>I like the idea of a wiki-style edit for web pages (at least only
>>accessible for us).
> 
> 
> If only a limited number of person can access it, I'm not sure it has an
> interest to make it a wiki. Also, I wonder how you would create the
> drivers tables as we have them now... Sounds a bit too complex to be
> made with a wiki.
> 
> I am not opposed to the wiki concept, but I am not sure that all the web
> site can be done that way. That said I can be convinced (let's just try
> and see if we hit the limits or not). If there are more contributors to
> the site that way (as opposed to hand-written HTML code under CVS) that
> might be worth it, granted.

I'm 100% with you.  Wiki with a hidden edit feature that requires logins 
for a handful of us.  If tables are not easy, then html is fine.  If 
management via ftp or cvs is the way to do it, then that's fine too.

PS- A plus for CVS-style management is that it makes mirroring very easy.

>>- CVS web browse
> 
> 
> Sure, and if possible something a little bit more user-friendly than what
> we had. Being able to download any revision of any file and getting
> diffs between revisions are missing at the moment.
> 

I like things that allow for quick selection of revs, forks, and 
releases.  And, then lets you download everything in a tarball.  The 
current CVSweb does this:

http://www.freebsd.org/cgi/cvsweb.cgi/projects/cvsweb/

But, I think there was something a little slicker out there that I used 
at one point, but I forgot what it was and can't find an example of it 
right now...

> We might consider moving from CVS to Subversion. As far as I know it is
> possible to convert CVS repositories without loss, and SVN allows things
> CVS doesn't (such as renaming/moving files). This would suggest that
> all contributors (not that many as far as I can tell) would need to
> start using Subversion. Does it sound like a potential problem?
> 

Subversion is just something I threw out there as an option.  I've only 
just used subversion lately and not extensively.  It claims to have 
solved many of the problems that CVS is plauged with, but isn't as well 
supported by 3rd party apps (IDEs, web interfaces, etc.).  It seems to 
work very similarly to cvs on the command line, afaik.

> 
>>- Support/ticket system
> 
> 
> Again, something more user-friendly than what we have ATM would be
> welcome. Original posters need to be able to add info to their ticket,
> or the system is next to useless. Bugzilla? Or something else?
> 

Yeah, I'd suggest something simple to use.  I've always found Bugzilla 
to be a bit overly confusing and complex for anything but huge projects 
(like Mozilla).  Searching in it is especially cumbersome, I think.

> 
> 
> Whatever we do, it has to rely on CSS. No more old-style
> netscape-generated crappy html please. I've tried to clean things up
> bit by bit in the last year, but redesigning the site from scratch
> can't be bad.
> 

Lol, yeah.  I agree.  Simple, simple, HTML, with a CSS client-side 
include which sets the style of the site.  I enjoy the look of sites 
like Wikipedia (http://en.wikipedia.org). (This might be influencing my 
bias for a wiki site, now that I think about it. :')


Phil
