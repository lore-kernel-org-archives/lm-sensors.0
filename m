From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: call for 2.6.5 soon
Message-Id: <20020731114823.Z8689@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D3CBBA1.B4B210B0@paradyne.com>
In-Reply-To: <3D3CBBA1.B4B210B0@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 31, 2002 at 07:33:01PM +0200, Jean Delvare wrote:
> 
> > Thanks.  You are added to CVS.  Let me know if it gives you any
> > troubles.
> It probably will considering I have never used CVS before. I know how to
> checkout (I suppose this is the same than anonymous but with my l/p) but
> I don't know how to commit.

Yup, you login and checkout the same way as anonymous.  Updating your 
tree is also the same (cvs update -d).  Commiting is easy, you can 
commit specific files, or everything you've changed (cvs commit [file1 
file2 ...]).  When you do that, it will pop up an editor (the one 
which your EDITOR environment variable is set to) in which you can say 
what changes you've made.  Also be sure to include your name in the 
description to help keep track of who made what changes.
 
> > BTW- Speaking of the DMI stuff, did you see the report of a similar 
> > trouble on IBM Intellistations?  It effected the bootloader of all 
> > things when the chip (or some other chip?) was scanned.  Odd.
> Yes, saw this. Rather odd indeed, but I wouldn't come to any conclusion
> from a single example. Of course, the fact that it is an IBM probably
> isn't a coincidence, but the user wasn't that clear in explaining what
> happened, was he? Anyway, it confirms what I first suggested:
> blacklisting every IBM using DMI is the safe choice - at least until we
> know more. Of course, if we are able to identify and detect the chip
> that is causing the trouble, this is even better, but the real issue so
> far is to have something apparently-safe-enough[1] for Alan, Linus
> and/or Marcello to accept it.
> 
> [1] I don't mean we would fake anything - I mean we obviously never will
> be 100% sure we won't break something, since new broken chips may still
> arise and we'll never know about it before at least one (unlucky) user
> tries and cries.

Yes, well said.  I wish we could verify the chip (at least the common
thread seems to be the RFID chip so far) and safely avoid or even
drive it.  I'd love to get an Intellistation or Thinkpad so we can do
some tests.  IBM doesn't support Thinkpads under linux any more, but
they probably support the Intellistations?


Phil

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
