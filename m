From: david.goodenough@btconnect.com (David Goodenough)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: LM87 support in LK2.6
Message-Id: <200404012318.38381.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <406C6981.6060306@mascorp.com>
In-Reply-To: <406C6981.6060306@mascorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 01 April 2004 20:30, Jean Delvare wrote:
> > I searched through the mail archives and found that the LM87 chip had
> > no plans to convert to the 2.6 kernel at the moment.  First I wanted
> > to get an update on that status,  and second, I'm going to be using it
> > on a project im working on, so if there is nothing ported at the
> > moment, I'll probably end up porting it myself.  Actually, the port is
> > in progress, unfortunately, I don't have my hardware to test it out on
> > yet.  The driver porting directions have been very helpful on getting
> > started on the conversion.
>
> Two other persons have deplored the lack of support of the LM87 in
> Linux 2.6, I just invited them into this thread ;)
>
> I invite you to work together so as not to waste your time and instead
> share your forces on porting the driver. I think David was wanting to
> port the driver as well, while Chris was "only" wanting to test it once
> done.
>
> If you have questions while porting the driver, just ask on this list.
>
> Once the port is considered ready, post it here in the form of a patch
> against the latest -mm kernel, and we (most likely I) will review it.
>
> Thanks.

I am going to do some work on this next week (I am going skiing, and I will 
do this in the evening).  I hope to come back with something that at least
compiles cleanly.  I will not have the kit to test with me on the trip, but I 
will start testing when I get back.  I have no idea now well connected I
will be next week, so if I hit a problem it may have to wait until I return.

I am working against a Debianised 2.6.4 kernel in the first instance,
I will move to a later one when I have done the basic conversion.

David

BTW, I am still only getting mail that is explictly addressed to me, not mail
that is for the list in general.
