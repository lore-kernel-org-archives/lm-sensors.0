From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: bmcsensors on kernel 2.6.11
Message-Id: <253818670503090737be7a38d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(I've forwarded this to the lm_sensors mailing list as I think this
should be discussed on there)

I hope it will get into the mainstream kernel relatively soon, I
haven't asked for it to be included in the mainstream kernel yet,
mainly because I wanted enough testing to ensure that it was of some
reasonable stability. The patch has been out for a year now however,
and the only reports of instability I had would seem to be problems
that were fixed in the 2.4 version.

Now that I've updated the patch to include the fixes applied to the
2.4 version since the initial port the only thing that perhaps might
restrict it from being included in the kernel is the method that one
has to declare the sysfs callback - there is no way (I should say
there was no way at the time of the initial port - I haven't looked
into it since then) to dynamically create a number of sysfs callbacks
decided at run-time. Hence if you look at the 2.6 bmcsensors I have
the kludge of having to declare a set number of callbacks at
compile-time which, apart from looking very ugly, limits the number of
sensors.

The reasons for this limitation are simply that none of the other
sensors in the lm_sensors project have the ability to address a
virtually unlimited number of sensors, rather most can only address a
few (after all most of the 'chip' drivers are for relatively simple
hardware chips :-) ).

Unless anybody knows of a nice way to avoid this, what is a reasonable
maximum number of sensors for an IPMI BMC? And how would I go about
getting the driver included in the kernel?

Yani

On Wed, 09 Mar 2005 08:25:06 -0600, Corey Minyard <minyard@acm.org> wrote:
> Bene Martin wrote:
> 
> >Hi Yani,
> >
> >
> >
> >>Just to let you know, I've updated the patch for kernel 2.6.11.1,
> >>incorporating all the changes made to the 2.4 version and your
> >>suggested change for ipmi_request->ipmi_request_settime (which was
> >>surprisingly easy - most of the 2.4 cvs diffs applied fine).
> >>
> >>
> >
> >Thanks!
> >
> >
> >
> >>Interestingly enough the ipmi_request_settime still has a comment in
> >>the header "Don't use this unless you *really* have to.", making me
> >>wonder if there is a reason not to be using it instead of ipmi_request
> >>if its re-incorporated into the kernel.
> >>
> >>
> >
> >I guess the only one qualified to answer that one would be corey.
> >
> >Bye, Martin
> >
> >
> You wouldn't generally use it because it sets the timeouts and for most
> purposes the timeouts are defined by the spec (sort of).
> 
> Do you have any feeling when the BMC sensors package will go into the
> mainstream kernel?  That would be the time to coordinate adding the
> normal function back in so I'm not constantly fighting the unused
> function police.
> 
> -Corey
>
