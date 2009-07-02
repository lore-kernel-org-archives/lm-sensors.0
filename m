From: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Date: Thu, 02 Jul 2009 17:59:35 +0000
Subject: Re: [lm-sensors] [PATCH] adxl345 accelerometer hwmon driver
Message-Id: <4A4CF587.1030202@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local> 	<4A4CF07B.3090600@cam.ac.uk> <8bd0f97a0907021043l30a34e6dh581ea5e96130d7eb@mail.gmail.com>
In-Reply-To: <8bd0f97a0907021043l30a34e6dh581ea5e96130d7eb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Chris Verges <chrisv@cyberswitching.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Michael Hennerich <michael.hennerich@analog.com>, Robin Getz <rgetz@blackfin.uclinux.org>

Mike Frysinger wrote:
> On Thu, Jul 2, 2009 at 13:38, Jonathan Cameron wrote:
>   
>> One interesting thing I just came across whilst searching lkml for
>> your post to reply to, was that Mike Frysinger submited a patch
>> adding some board support for an adx34x driver to bf548-ezkit.
>> I've not seen any sign of this anywhere else as yet (it hasn't
>> hit the input list which would be the obvious place) I've copied in
>> both people who signed off.  Michael or Mike able to give us more info?
>>     
>
> that's because we're still in the process of making sure it is stable.
>  I2C is a pita to work with.
> http://git.kernel.org/?p=linux/kernel/git/vapier/blackfin.git;a=commitdiff;hCd4cabbdeb5c24f84b159c5dc369c1a60844a48
>
> the advantage here is that we have been testing our driver with actual
> hardware ...
>   
Cheat ;)

Looks like a nice driver, see what you mean about the i2c fun and games
you are having
though.
I'm particularly interested in your use of the fifo:

I've only had a quick look, but assuming I read it right, you are using
the fifo
with a watermark of 0 then spitting out 3 separate events for every
element in it.
Basically a data ready response unless you fail to read in time. Seems
like a sensible
approach with this particular chip in input type applications.

Does this work well even at the higher rates?  Seems a fair bit of
overhead but I guess
if everything is quick enough it doesn't really matter. Does this act as
a clean means
of ensuring you get a consistent set of values?

Thanks,

Jonathan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
