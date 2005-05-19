From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [CVS PATCH] Sync cvs tree with latest 2.5 bk tree
Message-Id: <20030428165825.GB24193@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030425183641.GB2257@kroah.com>
In-Reply-To: <20030425183641.GB2257@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Apr 25, 2003 at 08:34:33PM -0400, Mark D. Studebaker  wrote:
> thanks.
> Since we haven't yet branched lmsensors, we have some things to decide 
> before I apply this patch.
> Namely, do we do another 2.4-compatible release.
> I'm in favor of at least one more, because I would like to clear up some 
> problems in 2.7.0.
> The problems are really on the i2c side though.
> 
> I just studied up on CVS merging. It appears that you can only merge from 
> the branch to the trunk?
> In i2c, 2.4 is the branch and 2.5 is the trunk. I want to get some changes 
> from
> the trunk (for example new ID's in i2c-id.h) over to the 2.4 branch before 
> we
> do a release from the 2.4 branch.
> 
> Let's decide what we want to do. I just went through 36 tickets covering 
> almost 4 weeks.
> 
> Phil? Mark H? others? comments please

Why even worry about a 2.5 and onward version of the CVS tree?  Why not
just use CVS for 2.4 and older, and use the in-kernel tree version of
the sensors and i2c code for that stuff?

If not, it's a lot of work to try to keep up with all of the other
changes to the code, and placing it backwards into the cvs tree.

thanks,

greg k-h
