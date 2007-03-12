From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Mar 2007 09:38:32 +0000
Subject: [lm-sensors] libsensors patches
Message-Id: <20070312103832.6c1109b6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311152104.bd092ff9.khali@linux-fr.org>
In-Reply-To: <20070311152104.bd092ff9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 11 Mar 2007 13:44:19 -0400, Mark M. Hoffman wrote:
> * Hans de Goede <j.w.r.degoede at hhs.nl> [2007-03-11 18:13:05 +0100]:
> > Why? I understand this may be an improvement speed-wise, but libsensors 
> > is afaik not really speed critical. To me (as a packager of a distro 
> > maintaining over a 100 packages) this is needless ABI breakage and as a 
> > packager I strongly dislike that. Breaking ABI is not something that 
> > should be done lightly and thus is in this case not warrented IMHO.
> 
> Speed is the concrete improvement... but it's also an aesthetic improvement.
> 
> And... is this really much different than extending the API from a packaging
> standpoint?  If the program uses the new library function, then the new library
> is obviously required.  Once you move forward, you can't move back.
> 
> The 'include' functionality comes into play also.  Existing libsensors will
> break if they find an include line.  It seems this would warrant a new major
> rev number anyway... so I thought I may as well 'fix' the other stuff.
> 
> Plus there is the issue of killing all 2.4.x kernel support.  I guess, no one
> change here warrants the move to 3.0 all by itself.  But when you add them up,
> I think it will be *easier* for distro people to accomodate this in one chunk
> than to spread it out over the next 3 minor revisions.

I wholeheartedly agree with this statement.

-- 
Jean Delvare

