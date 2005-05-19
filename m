From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: Regarding standardized auto-fan control
Message-Id: <Pine.LNX.4.58.0406301118110.5603@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040630024326.GH3064@jupiter.solarsys.private>
In-Reply-To: <20040630024326.GH3064@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 29 Jun 2004, Mark M. Hoffman wrote:

> Hi all:
> 
> This latest round of discussion convinces me: I think that a standard
> interface (at the chip driver level) for automatic fan control just
> isn't feasible, for these reasons:
> 
> 1a) No two of these chips are alike, and
> 
> 1b) some of them are vastly different.
> 
> (And from the department of broken records...)
> 
> 2) A hardware driver should do and perform exactly as it is told.  I.e.
> we should not be afraid to expose an interface for each auto-fan capable
> chip which is suited to just that chip.
> 
> * Jean Delvare <khali@linux-fr.org> [2004-06-24 13:41:02 +0200]:
> > * Interface reflects the physical reality. It doesn't mean we lose
> > chip-independancy, but scripts will be twice as big.
> 
> What scripts?  Automatic fan control is, um, *automatic* ;-)
> 
> OK seriously... if a standard interface is desirable for these controls
> then let's present one in userspace via libsensors.  I personally think
> that will be difficult, if not impossible... but then again not any
> harder than forcing it in the drivers themselves.
>
Hi Mark,

A common design I have seen for something like this is to provide 
standard api for requesting some action, and then redispatching the
request to a "driver" (not something in kernel space) that knows how to 
make the translation of the request into the specific implementation 
interface.  Generally this "driver" is a DSO that is loaded on demand
by the code using dlopen or one of its friends.  Usually, there is a 
mechanism in the api to pass driver dependent request also.  One example 
of this in perl would be the DBI libraries.  DBI creates a high level api 
that users can use, and then ultimately redispatches the api calls to 
specific database drive (the DBD module).  In the case of fans it would be 
a higher level fan control api, that redispatches to the appropriate
user space fan control driver DSO.  Conceivably which DSO's you would need 
to load could be completely controlled by what chip drivers are actually
loaded.

This actually would be a model that could be more generally used so that
you don't have this one monolithic chips.h and chips.c in libsensors.  
Each chip would have its on "userland/libsensors driver" that gets loaded
on demand, allowing you to easily extend the supported chips in users 
space much like you can in kernel space.  In spare cycles I am working on
a perl prototype of this, more to kill boredom.  When I am done I will 
gladly share it; the point being that it would in a high level language 
mark out the architecture I am talking about.
 
> One side-benefit of doing it in libsensors, is that we may be able to
> implement a "virtual" auto control in userspace for chips that have only
> manual PWM control.
> 
> In the meantime, we can upgrade the drivers to make use of these features
> instead of searching for an interface that might never exist.
> 
That sounds very reasonable IMHO.

Cheers...james
