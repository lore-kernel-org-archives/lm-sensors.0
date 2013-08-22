From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 22 Aug 2013 06:32:04 +0000
Subject: Re: [lm-sensors] About the Asus F2A temperature sensor (it8603e)
Message-Id: <20130822083204.0c4de80c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0EqgNNTEvavmVpnTn_RLf0uhgMrkn9VdTrezxp2kmpqrQLg@mail.gmail.com>
In-Reply-To: <CAC-0EqgNNTEvavmVpnTn_RLf0uhgMrkn9VdTrezxp2kmpqrQLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David, Jukka,

On Tue, 13 Aug 2013 17:05:46 -0600, David Hubbard wrote:
> On Tue, Aug 13, 2013 at 1:10 AM, Jukka Nikulainen <
> jukka.nikulainen@helsinki.fi> wrote:
> > After reading the thread I was under the impression that changes in the
> > hwmon-vid.c file were only needed to get sane readings about voltages. Is
> > this correct? I have built the case for my computer and I am only
> > interested in monitoring the temperatures.
> 
> The changes to hwmon-vid.c were to correctly interpret the VID bits -- bits
> that store a coded value representing the CPU voltage. You can get more
> information about that from Jean Delvare via lm-sensors@lm-sensors.org. He,
> not I, wrote the changes for hwmon-vid.c as a matter of fact.

Can't really comment as I don't know which change is being discussed
here. But VID is really not that interesting these days due to 1*
hardware vendors no longer connecting these pins and 2* our support
being somewhat limited, so you can just ignore that part.

> Secondly: I assume that the correct work-flow is to make your changes in
> > the it87 source code, compile the file, replace the driver and modprobe it.
> > I have compiled programs before but not very frequently and nothing
> > kernel-related. I'm sure that the procedure is dead-simple, but I still
> > have a few questions that even extensive googling didn't answer. For
> > example, are the relevant kernel header files the only dependency?
> 
> Building a module out-of-tree is possible (using just the kernel header
> files). I am aware that this may result in the cleanest results for a
> debian system, since you can use a stock debian kernel and load your
> out-of-tree module.
> 
> However, I suggest taking a different approach. This module in particular
> is highly experimental, as in: I think I'm the only other person who has
> actually tried it. I believe that is a good reason not to use a stock
> kernel. If you use a stock kernel, your results are not representative of
> the simplest "base case" for debugging, and this particular chip would
> benefit from more testing of the base case. It would also be possible to
> use a stock debian kernel + out-of-tree module, and then carefully attempt
> to replicate your problem on a kernel compiled from source any time you
> want to discuss it on the lm-sensors list... but that's a whole lot of
> extra work for you :)

Actually, hwmon drivers are mostly independent from the kernel version
as long as you don't dig up too far in history. As a general rule, we
prefer having more testers on various kernel versions than only a few
with the latest kernel. So potential testers should use whatever kernel
makes their life easier.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
