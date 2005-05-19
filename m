From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: i2c-dev.h
Message-Id: <3EDAE02A.4070801@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED81794.9060303@paradyne.com>
In-Reply-To: <3ED81794.9060303@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So '- km' in the sensors.h comments must be Kyosti...

There has got to be some common header files between kernel and user space so 
that data structures and "magic" constants are shared.

If user space can't include kernel headers, then the kernel will have to 
include a "user space" header.

It would seem to me that the alternative of having two copies of the same data 
structures and constants would be worse.

When did this become such a big issue?

Absolutely, either put the old code back or create another file with the 
common code that can be included one place or the other...

:v)

Mark D. Studebaker wrote:

> Kyosti took 173 lines out of i2c-dev.h in the main i2c branch
> because userspace shouldn't include kernel headers,
> and then merged that change into the lk2-4 branch too.
> 
> But I don't recall seeing any replacement.
> 
> Is there one?
> Should we undo the changes so we have working userspace utilities
> again or should we create a userspace version of i2c-dev.h?
> 
> I'm not claiming the old i2c-dev.h was pretty but we need something.
> 

