From: juergh@gmail.com (Juerg Haefliger)
Date: Wed, 30 Aug 2006 18:30:08 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 3] hwmon: new vt1211 driver
Message-Id: <191fb4ca0608301130k6ddd4c17p162a19713c67880c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0608292235s3494ddecp2276c5d9841ac775@mail.gmail.com>
In-Reply-To: <191fb4ca0608292235s3494ddecp2276c5d9841ac775@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,


> OK. We'll need to make some adjustments to user-space and possibly to
> the 2.4 kernel driver, but we would have had to, anyway.
>
> Will you be able to test the 2.4 kernel driver if we modify it?

Yes. I was assuming I will make the changes for 2.4.


> > That's a static value, isn't it? Why read it more than once?
>
> No, it may not be static. Recent CPUs change voltages on the fly, so
> the VID value could change as well.

OK.

...juerg

