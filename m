From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: i2c versioning
Message-Id: <20011128103058.Q5595@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C043305.233767D@paradyne.com>
In-Reply-To: <3C043305.233767D@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I think it's going to have to be converted in the Makefile and then
passed in as major, minor, etc. via -D's.  Not real pretty, but it's
effectively the same thing.  You can still do your #if's, but not
directly on the string constant.  It's surprising that strings can't
be compared by cpp... 


Phil

On Wed, Nov 28, 2001 at 09:03:55AM -0500, Mark Studebaker wrote:
> So we're back to my original question.
> Write me a #if statement that decides if one string is greater than another.
> Good luck.
> 
> phil@netroedge.com wrote:
> > 
> > How about this, let's use the #ifdefs to make life a little easier for
> > users in the short term.  But, work on recombing the two projects now
> > that we have a chance with 2.5.x.  When 2.6.0 comes out, we can take
> > the #ifdefs out and have a unified project again.  If we get lucky,
> > maybe Alan might let a combined lm-sensors/i2c update into 2.4.x so we
> > can start a little earlier. :')
> > 
> > Phil
> > 
> > On Tue, Nov 27, 2001 at 10:14:04PM -0500, Mark D. Studebaker wrote:
> > > But I'm so happy to not require people to download and install
> > > a new i2c right now. It really will cut down on tickets, etc,
> > > if we can hold that line for a while.
> > > As soon as I put in a i2c_smbus_i2c_read_block_data() call
> > > without an #ifdef, we're right back where we started.
> > >
> > > phil@netroedge.com wrote:
> > > >
> > > > On Tue, Nov 27, 2001 at 08:14:45PM -0500, Mark D. Studebaker wrote:
> > > > > You can do anything in code but I'm trying to call a function
> > > > > that doesn't exist in 2.6.2 or earlier so I need
> > > > > to do the comparison in the preprocessor in a #if statement
> > > > > so I don't get an undefined symbol.
> > > >
> > > > I'd tend to lean towards being stubburn and not compiling than
> > > > littering the code with more #ifdef's if they are using an old I2C.
> > > > We've been updating I2C a lot for a while, but maybe we won't need to
> > > > as much in the future?
> > 
> > --
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
