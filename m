From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: Query on apparently 'disconnected' sysfs interfaces
Message-Id: <20050319095155.068a423b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
In-Reply-To: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip,

> Don't forget that there are dual CPU motherboards and some have only
> one VID while others have two VID's.

True. In the former case, do you know if it means that both CPUs must
have the same VID value for the system to work, or that only one of the
CPUs VID will be known by us? I guess it might depend on the system.

> I suppose that's why you're adding cpu0_ to the name, but the
> existing practice is clear that the vast majority of monitoring chips
> use the name 'vid'.

Do you mean "the vast majority of chip datasheets" or "the vast majority
of chip drivers"? Most Linux 2.6 drivers do now use cpu0_vid, and that's
what libsensors defaults to. Only adm1026 still uses vid.

> (Which driver uses in1_ref?)

adm1025.

> Changing to cpu0_vid or
> cpu1_vid would seem to be a major change which should not be
> undertaken lightly since this is likely to be one of the values
> *most* referenced  by user scripts and applications.

That would be changing only two drivers, one of which (adm1026) is new
and not widely used as far as I know. Also, libsensors is updated
accordingly so the end users should not notice the change, providing
they upgrade both the kernel and lm_sensors at the same time. BTW, I do
not think that adm1026's VID works right now, since the file is named
"vid" and libsensors will look for either "cpu0_vid" or "in0_ref".

The reason why I first changed from vid to inN_ref was that I thought it
would make things easier for the user. Most people didn't know what
"vid" was, but would understand what a channel reference voltage is. It
would also have made it possible to extend the concept to other channels
for which a reference value is known (for chips with internal voltage
scaling, we know the reference value for all channels). However, my plan
was defeated by the fact that motherboard manufacturers tend not to
follow the guidelines and can use any channel for Vcore, not necessarily
the one documented by the chip manufacturer.

This is the reason why I renamed in0_ref to cpu0_vid [1]. This left room
for cpu1_vid for dual-CPU systems, and so on.

This choice still causes a problem in the case there are TWO hardware
monitoring chips with one VID each, and two CPUs. We will create two
"cpu0_vid" files while obviously one of these is really "cpu1_vid". And
if we attempt to dynamically renumber the file, libsensors will fail to
find the value, unless we add specific code for this (let alone the fact
that it would make the drivers somewhat more complex).

So I tend to think that the "ideal" naming scheme would be vidN, which
is more or less a return to the initial state. It seems that it isn't
possible to add abstraction levels here, so we have to stick with the
raw name.

Note that I have been working on the sysfs interface cleanups almost
alone since the beginning. I definitely made mistakes in the process,
but maybe they wouldn't have happened if I had not been on my own. I
welcome comments but I would have prefered to hear them back when I was
changing things. Now, the user-base is such that changing things again
is almost impossible, and I fear that we'll have to stick to cpuN_vid
for quite some time.

[1] http://archives.andrew.net.au/lm-sensors/msg27799.html

Thanks,
-- 
Jean Delvare
