From: david.goodenough@btconnect.com (David Goodenough)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: LM87 support in LK2.6
Message-Id: <200407021041.32267.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <406C6981.6060306@mascorp.com>
In-Reply-To: <406C6981.6060306@mascorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jeff,

I finally got around to testing your LM87 code, and I am having a few 
problems.

Let me describe my hardware environment first as it may help.  This 
LM87 is on a Microtik Routerboard 230, which uses a SC1100 system
on a chip unit.  I am therefore using the scx200_acb driver (as 
patched in the LM77 discussion thread to enable hardware
monitoring device detection).

sensors-detect finds the ACB buss, and finds the LM87.  So I then
load the lm87 module but then nothing.  sensors finds the other
device (eeprom) and correctly reports the installed memory size,
but nothing from the LM87.

Any ideas as to where to start looking?

David

On Friday 02 April 2004 19:06, you wrote:
> Sure, here's the patch.
>
> Let me know how it works...
>
> Jeff
>
> David Goodenough wrote:
> >Jeff,
> >
> >Could you send me the driver and I will give it a go if I get time before
> > I go skiing, otherwise I will do it as soon as I get back.  That was I
> > can spend time on the i2c_nscacb driver instead of duplicating your
> > effort.
> >
> >David
> >
> >On Thursday 01 April 2004 23:33, Jeff Oliver wrote:
> >>I already have the driver compiling clean...after spending a day with
> >>the conversion document and the old 2.4 driver.  I have not yet tested
> >>it since I dont have my hardware yet.  I can send you guys the driver if
> >>you'd like to check it out and play with it.  I'm going on vacation as
> >>well, and hope to have hardware when I get back late next week.
> >>
> >>I've been working against the stock 2.6.4 kernel.  Moving to a newer
> >>kernel can be done when the first port is verified.
> >>
> >>Jeff Oliver
> >>
> >>P.S. Can I be added to the mailing list as well?
> >>
> >>David Goodenough wrote:
> >>>On Thursday 01 April 2004 20:30, Jean Delvare wrote:
> >>>>>I searched through the mail archives and found that the LM87 chip had
> >>>>>no plans to convert to the 2.6 kernel at the moment.  First I wanted
> >>>>>to get an update on that status,  and second, I'm going to be using it
> >>>>>on a project im working on, so if there is nothing ported at the
> >>>>>moment, I'll probably end up porting it myself.  Actually, the port is
> >>>>>in progress, unfortunately, I don't have my hardware to test it out on
> >>>>>yet.  The driver porting directions have been very helpful on getting
> >>>>>started on the conversion.
> >>>>
> >>>>Two other persons have deplored the lack of support of the LM87 in
> >>>>Linux 2.6, I just invited them into this thread ;)
> >>>>
> >>>>I invite you to work together so as not to waste your time and instead
> >>>>share your forces on porting the driver. I think David was wanting to
> >>>>port the driver as well, while Chris was "only" wanting to test it once
> >>>>done.
> >>>>
> >>>>If you have questions while porting the driver, just ask on this list.
> >>>>
> >>>>Once the port is considered ready, post it here in the form of a patch
> >>>>against the latest -mm kernel, and we (most likely I) will review it.
> >>>>
> >>>>Thanks.
> >>>
> >>>I am going to do some work on this next week (I am going skiing, and I
> >>>will do this in the evening).  I hope to come back with something that
> >>> at least compiles cleanly.  I will not have the kit to test with me on
> >>> the trip, but I will start testing when I get back.  I have no idea now
> >>> well connected I will be next week, so if I hit a problem it may have
> >>> to wait until I return.
> >>>
> >>>I am working against a Debianised 2.6.4 kernel in the first instance,
> >>>I will move to a later one when I have done the basic conversion.
> >>>
> >>>David
> >>>
> >>>BTW, I am still only getting mail that is explictly addressed to me, not
> >>>mail that is for the list in general
> >>
> >>Disclaimer: The information contained in this transmission, including any
> >>attachments, may contain confidential information of Matsushita Avionics
> >>Systems Corporation.  This transmission is intended only for the use of
> >> the addressee(s) listed above.  Unauthorized review, dissemination or
> >> other use of the information contained in this transmission is strictly
> >> prohibited. If you have received this transmission in error or have
> >> reason to believe you are not authorized to receive it, please notify
> >> the sender by return email and promptly delete the transmission
>
> Disclaimer: The information contained in this transmission, including any
> attachments, may contain confidential information of Matsushita Avionics
> Systems Corporation.  This transmission is intended only for the use of the
> addressee(s) listed above.  Unauthorized review, dissemination or other use
> of the information contained in this transmission is strictly prohibited.
> If you have received this transmission in error or have reason to believe
> you are not authorized to receive it, please notify the sender by return
> email and promptly delete the transmission
