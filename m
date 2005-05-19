From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc4 1/15] (dynamic sysfs callbacks)
Message-Id: <2538186705051800412ec07d5c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051703394944e949@mail.gmail.com>
	 <20050518072239.GA11889@kroah.com>
	 <253818670505180028696cc991@mail.gmail.com>
	 <20050518073756.GA12382@kroah.com>
In-Reply-To: <20050518073756.GA12382@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Russell King <rmk+lkml@arm.linux.org.uk>

On 5/18/05, Greg KH <greg@kroah.com> wrote:
> On Wed, May 18, 2005 at 03:28:23AM -0400, Yani Ioannou wrote:
> > Hi Greg,
> I don't have a git tree for stuff that is not ready to be sent to Linus
> at that moment.  I'm using quilt to stage stuff and have them be sucked
> into the -mm releases.  It's easier that way for me right now.

Yes I just realized my mistake, OK I'll try the patches against -mm2
along with a patch to update all the added device
callbacks/differences and make sure nothing goes horribly wrong with
it tomorrow. BTW I sent a patch against it87.c to lm_sensors so Jean
could test things (apparently adm1026 hasn't got many users).

Thanks again,
Yani

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
