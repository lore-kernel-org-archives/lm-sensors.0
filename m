From: adaplas@hotpop.com (Antonino A. Daplas)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <200503180702.42247.adaplas@hotpop.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 18 March 2005 06:03, Jean Delvare wrote:
> Hi Tony,
>
> > Before I go on debugging, a few questions, as my knowledge of the i2c
> > framework is quite limited:
> >
> > This particular bug seems to be triggered in i2c_dev_init when calling
> > i2c_add_driver.
>
> Were you able to reproduce this one as well? I couldn't.

Can't either.

>
> > 1. nvidiafb gets loaded before i2c_dev_init(), and when setting up
> > i2c, calls i2c_bit_add_bus. Is this safe to do?
>
> Looks OK to me. nvidiafb, like other framebuffer drivers, declares i2c
> busses. i2c-dev declares an i2c driver. Both are rather independent, and
> supposedly don't interract before an i2c client is created (that would
> happen in i2cdev_open()).
>
> i2c-dev isn't really part of i2c-core, it's more like a priviledged i2c
> pseudo-chip driver.

Ok, just making sure.

>
> > 2.  In i2c_add_driver, there is a call to list_add_tail.  Is this
> > acceptable without doing a LIST_HEAD_INIT first?  Or is the list_head
> > initialized somewhere?
>
> The list is declared with:
> static LIST_HEAD(drivers);

Ok, I mistakenly interchanged the parameters of list_*. I thought the second
parameter is the entry to be added to the list_head, the first parameter.

> at the top of i2c-core.c.
> Looks OK to me but I am no list expert.

I was talking about driver->list, because of my mistaken belief as mentioned
above, where it is initialized.  Anyway, after checking the i2c code, I
don't see where driver->list used anywhere, so I don't think it will hit a
bug.

Tony

