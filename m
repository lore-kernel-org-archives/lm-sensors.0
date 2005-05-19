From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <2538186705042806456488e7de@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Actually I was running a kernel with only bmcsensors changed to use
the void * - it should work transparently for all the other drivers
(except for a compilation warning about invalid show/store pointer
types being passed - and I have a perl script we can run against the
source tree to update drivers and get rid of those warnings).

The void * is completely optional of course, its up to the driver to
use it or not (unless I'm missing your question here?).

Yani

On 4/28/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
> Hi Greg,
> On Wed, 27 Apr 2005 23:57:41 -0700, Greg KH <greg@kroah.com> wrote:
> 
> >
> >And how would it work with the 99% of the kernel that doesn't create
> >attributes dynamically on the fly?
> 
> Create an index attribute: write index value, read/write attribute
> data?  Nothing else need know, just the driver needing unbounded
> indexed attributes.
> 
> --Grant.
> 
>
