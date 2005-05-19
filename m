From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Patches to Marcelo and Linus
Message-Id: <3CE1209E.93E5E652@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CDFF579.88423391@paradyne.com>
In-Reply-To: <3CDFF579.88423391@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

- I'm copying the i2c list to keep them informed.

- It's a good plan to start with 2.6.3, not CVS. Both because it's
  stable and because we have it tagged. In general, please don't
  submit patches from CVS before we talk about it.

- sensors in 2.4 was rejected by somebody a couple of years ago.
  We could try again but probably we should start with 2.5.

- I like the plan to start with an i2c patch for 2.5. sensors in 2.5
  does _not_ require the i2c patch, but this way you get to say,
  'hi, i'm the i2c/sensors patch guy, first is a small i2c patch,
   if you're happy with that then i'll send you the big sensors patch'.

- if you can post the proposed patch somewhere we can look at it

- Any thoughts on how we can buy back the changes for 2.5?
  Should we start doing #if KERNEL_VERSION > 2.5.0?
  Or should we do a 2.5-only version of mkpatch? Or both?
  Remember we support kernels 2.2+.



Albert Cranford wrote:
> 
> Juan Quintela wrote:
> >
> > >>>>> "albert" = Albert Cranford <ac9410@bellsouth.net> writes:
> >
> > Hi
> >
> > >> yes, we would love your help.
> > >> Ingo was going to do it but has been busy -
> > >> Ingo, do you have any work-in-progress to contribute?
> > >>
> > >> There are 3 patches:
> > >> 2.4 i2c
> > >> 2.5 i2c
> > >> 2.5 lm_sensors
> > >>
> > >> Are you willing to do all 3?
> > >>
> > >> Are you generating from our 2.6.3 or CVS?
> > >> If CVS, I have some SMBus 2.0 work-in-progress
> > >> in i2c-core that we may want to take out
> > >> before submission.
> > >>
> > >> Albert Cranford wrote:
> > >> >
> > >> > Hello Philip,
> > >> > Is there still a need to sync up to 2.4 and 2.5?
> > >> > I would be willing to help since I've done most of the
> > >> > work already.  Its real easy using bitkeeper which is
> > >> > the revision control of the kernel.
> > >> > Let me know.
> > >> > Albert
> > >> > --
> > >> > Albert Cranford Deerfield Beach FL USA
> > >> > ac9410@bellsouth.net
> >
> > albert> Yes all three.  I would get the 2.6.3 up to date first,
> > albert> then get the CVS.
> > albert> But what about lm_sensors for 2.4 ?  My personal 2.4 tree
> > albert> has lots of lm_sensors in it.
> > albert> I'll start with a an i2c patch for 2.5 and pass it through
> > albert> the group.
> >
> > I am integrating lm_sensors through 2.4 in the Mandrake kernel, if you
> > want, I can integrate it in 2.4, I have the patches and the test users
> > :)  Then you can integrate 2.5 branch.
> >
> > Later, Juan.
> >
> > --
> > In theory, practice and theory are the same, but in practice they
> > are different -- Larry McVoy
> 
> OK I'll work on i2c & lm_sensors2 in 2.5.  Are you also
> integrating i2c in 2.4?
> --
> Albert Cranford Deerfield Beach FL USA
> ac9410@bellsouth.net
