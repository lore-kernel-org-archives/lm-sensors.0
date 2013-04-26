From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 26 Apr 2013 06:40:45 +0000
Subject: Re: [lm-sensors] Kernel problems
Message-Id: <20130426084045.59b3b969@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJPx3-yTzJCrgHK1BMLz7MvtVKeq4_x5ZFA5_xDGBFeVPTjdrg@mail.gmail.com>
In-Reply-To: <CAJPx3-yTzJCrgHK1BMLz7MvtVKeq4_x5ZFA5_xDGBFeVPTjdrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Joe,

On Thu, 25 Apr 2013 18:16:06 -0700, Joe May wrote:
> Hi,
> 
> I recently purchased a phyCORE-MPC5200B development board with on board I2C
> components.
> After building the kernel (2.6.23.1) I flashed it to the board and it works
> great; well everything but the I2C onboard devices.

Kernel 2.6.23.1 is very old. Why don't you use something more recent
and maintained?

> phytec support told me to include lm_sensors when I compile the kernel.
> 
> when I run the mkpatch script, it does not like my kernel tree path.
> 
> There is also no linux directory under /usr/src.
> 
> I cannot figure out how to generate the patch file with my kernel (which is
> a stock 2.6.23 from kernel.org) and I am using lm_sensors-2.8.8 with the
> host OS being OpenSuse 11.1.

lm-sensors 2.8.8 is very old and completely unsupported. Same for
openSUSE 11.1.

> I have tried from the lm-sensors directory:
> 
> mkpatch/mkpatch.pl . /home/joe/linux-2.6.23/ > /tmp/sensors-patch
> and it says:
> Kernel root '/home/joe/linux-2.6.23/' is not found.

Err, no, mkpatch was to generate kernel patches for the 2.4 kernel
series and earlier. Since kernel 2.6 everything you need is already in
the kernel tree so you don't have to patch anything.

My advice: use a more recent kernel. 3.0.75 would be a minimum for me,
or 2.6.34.14 if you really have to. Use a more recent version of
lm-sensors too. For v2.6/v3 kernels, lm-sensors 3.x is highly
recommended, lm-sensors 2.x will lack support for most devices.

And then if it still doesn't work, tell us in more details what doesn't
work and how it does fail. Just "it doesn't work" isn't something we
can help anyone with.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
