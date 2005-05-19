From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: [ltp] lm sensors
Message-Id: <20020827105120.D4831@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <02082509203400.18804@blackbox.localdomain>
In-Reply-To: <02082509203400.18804@blackbox.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Pam, thanks for the note and any help you can provide.

Right now, we don't have any contacts from IBM.  We've been working
with 'Joe from Australia' (a reverse engineering hardware hacker) who
has provided us with some valuable information as to how the Thinkpads
use the 24RF08 chip.  A while ago we seemed to be close to talking
with some engineers at IBM about this, but it fizzled out at the last
moment.

It's good to hear that this issue is solved for newer Thinkpads.  We 
got a report that the symptom may have resurfaced in Intellistations 
which seem to have the same or similar RFID functionality?  We haven't 
been able to confirm this, though.

Right now, we are working to get Lm_sensors included as a standard
installment in the Linux kernel (2.5.x series).  The hold up is this
Thinkpad issue.  Alan Cox has suggested we fix or workaround the
issue before he allow our code to be included.

In our previous discussions with IBM (a while ago now), an engineer
suggested we simply detect and disable our code for their hardware.  
This is also what Alan Cox viewed as a potential stop-gap solution
prior to kernel inclusion.  So, we are moving forward to use DMI to
detect for the presence of IBM hardware (by brand), and then disable
our code.  Unfortunately, this disables support for a majority of IBM
hardware which our code runs happily on (like servers for which admins
rely upon our code to monitor the health of).

Ideally, we would love to get help confirming what device is the 
culprit (we suspect the 24RF08 and clones).  Then, we would like to 
find a way to safely detect the device(s), and avoid or properly drive 
it.  This would be a more preferred solution than dropping support for 
the entire IBM brand!


Phil

On Tue, Aug 27, 2002 at 12:56:41PM -0400, Pam Huntley wrote:
> 
> Hi Phil,
> 
> I work in Personal Computing at IBM, doing software development.  Part of
> my job is now doing Linux-related work, and a small part of that is trying
> to help out the Linux community wherever possible.  I don't actually do
> hardware development, but I know the people that do, and in some cases I've
> been able to get information released for Linux purposes.
> 
> I meant to respond to you on this issue earlier, but I just got busy on
> other projects...  :-/ At any rate, has anyone at IBM been working with you
> on this at all?  I just recently started doing Linux work, so I'm not
> completely sure of the history, but my understanding was that for newer
> machines (T23+), this had been fixed, or had a workaround in place in the
> BIOS.  I'm trying to get more information from my manager now.
> 
> As for the older machines, it looked like on the mailing list you had
> gotten information about how to test for IBM machines.  If you tell me what
> kind of information you need (you'll have to be specific, I don't know all
> that much about hardware), then I can put in a request to have the
> information released to the Linux community (ie you).  I'm not sure how
> successful it'll be, the hardware guys are kind of leery about releasing
> information, but at least I can ask.  On some occaisions it's worked. :-)
> 
> Pam
> 
> 
> ======================
> Pamela Huntley, IBM PCD Software Development
> Phone: (919) 543-3598   Email: phuntley@us.ibm.com
> 
> 
> 
> |---------+-------------------------------->
> |         |           phil@netroedge.com   |
> |         |           Sent by:             |
> |         |           owner-linux-thinkpad@|
> |         |           bm-soft.com          |
> |         |                                |
> |         |                                |
> |         |           08/24/2002 08:53 PM  |
> |         |           Please respond to    |
> |         |           linux-thinkpad       |
> |         |                                |
> |---------+-------------------------------->
>   >-----------------------------------------------------------------------------------------------------------|
>   |                                                                                                           |
>   |       To:       linux-thinkpad@www.bm-soft.com                                                            |
>   |       cc:                                                                                                 |
>   |       Subject:  Re: [ltp] lm sensors                                                                      |
>   |                                                                                                           |
>   |                                                                                                           |
>   >-----------------------------------------------------------------------------------------------------------|
> 
> 
> 
> On Sat, Aug 24, 2002 at 05:38:03PM +0200, Bill Mair wrote:
> >
> > > On Fri, 23 Aug 2002, SMichelle wrote:
> > >[...]
> > > You should be able to ovverride the dependency: Check rpm's man page.
> > > If kde _needed_ lm_sensors, it would have run it, and your machine
> > > would already be hosed.
> >
> > How very true, sad but true. Does anyone know why KDE lists lm_sensors as
> > a pre-req ?
> 
> Probably because there are a number of GUI hardware health monitors
> for KDE (e.g. things that go in the dock to show CPU temp and such).
> 
> > Do any of you IBMers know if there has been any progress made on this ?
> > As I said before (a long time ago), no mortal LTPer is going to beta test
> > possible fixes (way toooo dangerous), this is something that REALLY
> requires
> > IBMs support and attention.
> 
> We've given up on IBM, but we've had some help from other sources.
> We just received samples of what could be the chip which is suspect
> (Atmel AT24RF08).  We will try to play with it to see if we can
> explain why our code causes it to puke.  Even from looking at the
> datasheet it isn't clear why.
> 
> Without proper documenation, access to helpful IBM engineers, or even
> a Thinkpad... we are doomed to progress only very slowly.  Rest
> assured, though, that we are trying hard to fix this.  Even Alan Cox
> has asked us to fix this specific issue (or at least detect IBM
> hardware and disable our code) before it will be allowed into the
> 2.5.x kernel.
> 
> BTW- if anyone out there wants to help out by donating a vulnerable
> Thinkpad for testing, or for testing code themselves, please let me
> know.
> 
> 
> Phil (Lm_sensors cofounder)
> 
> ----- The Linux ThinkPad mailing list -----
> The linux-thinkpad mailing list home page is at:
> http://www.bm-soft.com/~bm/tp_mailing.html
> 
> 
> 
> 

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
