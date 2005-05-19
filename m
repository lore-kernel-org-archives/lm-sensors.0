From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <20050505061007.GA465@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 05, 2005 at 09:00:56AM +1000, Grant Coady wrote:
> Hi All,
> On Wed, 4 May 2005 15:16:11 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> 
> >I was tempted to do this but it set off alarms in my better coding
> >judgement (abusing a pointer to store an int). It is certainly
> >'cleaner' than defining the awkward static ints, but aside from the
> >language abuse would doing something like this cause any portability
> >issues? And yes, what about those poor kittens? ;-)
> Yes, I want to know too :)

I don't care about the kittens, abuse that void *, that's what it is
there for.

> >Well I'm an almost reasonable person ;-). Yes this code was mainly for
> >comment so it definitely needs cleaning up, although any pointers on
> >how/where are welcome.
> 
> I have queries, is there a reason why sysfs doesn't return multiple 
> values?

Yes, that is the way it is designed.  One value per file is the RULE in
sysfs files.  End of story.

> Secondly is there a design document I've missed for this?  What does 
> dynamic sysfs look like to user?  sub-directory per device/block or 
> in the same directory level namespace?  I damaged the patches somewhere, 
> one didn't apply so couldn't 'see' it yet.

These patches don't change anything that the user sees, becides a
smaller kernel memory footprint.  The sysfs tree and files stay the
same.

thanks,

greg k-h
