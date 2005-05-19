From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <20050428065741.GA12086@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 28, 2005 at 02:44:36AM -0400, Yani Ioannou wrote:
> On 4/26/05, Greg KH <greg@kroah.com> wrote:
> > Care to show how a driver would use this change?
> >
> > And the void * shouldn't be called ptr, use what other structures call
> > their void pointers, "data", "private", etc.
> 
> Attached is an updated patch (yes ptr is rather redundant...) and also
> a quickly coded diff between my bmcsensors driver with and without
> this patch. Note that a real bmcsensors update would also change the
> sdrd[] array into a linked list and allow a potentially unlimited
> number of sensors to be seen, since this patch also allows an
> unlimited number of sysfs entries to be created at runtime, not
> feasible with static callbacks.

Ok, you are showing how this works with raw sysfs attributes, that's
simple.  But you should be using device attributes, how would this patch
work with them?

And how would it work with the 99% of the kernel that doesn't create
attributes dynamically on the fly?

thanks,

greg k-h
