From: ed.tman@verizon.net (Ed Harrison)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: ASUS ASB1009(Bach)--Bravo!! Bravo!!
Message-Id: <1040682386.1915.19.camel@linux.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1040523782.10137.30.camel@linux.local>
In-Reply-To: <1040523782.10137.30.camel@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2002-12-22 at 04:32, Bertrik Sikken wrote:

> Ed Harrison wrote:
> 
> >I hate replying to myself, BUT
> >
> >I got the latest snapshot.  ASB100 loaded on insmod w83781d without a
> >force_as99127f.  The readings are really good, including fan2--first
> >time ever.
> >
> >Thank You.  I do not know who changed what, but good job.
> >
> >Being the picky type, I need to tweak the temp calculations, but they
> >are very close, except temp3 which is the memory chip.  It stays static
> >at 45.1 F, so I know it is wrong.  When I make progress, I will post.
> >
> >Thanks again to the authors.
> >
> How do you know that temp3 is the memory chip?
> And what memory chip are you referring to?
> 
> On my board it also stays static (at 14.4 deg celcius, don't know
> what that is in fahrenheit).
> 
> Bertrik


That's what the guy who wrote xmbmon calls temp3 in the docs.  Mine is
static at 14.5 C also.

The only time I have seen it change was when I dual boot to Win98 and
run MBM5.0, and there you still have to choose the sensor and put a
label to it.  Temp3 does not show up in CMOS Hardware Monitor, so I have
no idea what it should be.

-- 
Ed Harrison <ed.tman@verizon.net>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20021223/f4177fea/attachment.html
