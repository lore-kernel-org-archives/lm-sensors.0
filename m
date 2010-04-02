From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 02 Apr 2010 09:15:28 +0000
Subject: Re: [lm-sensors] lm-sensors with ASUS P6TD Deluxe and Ubuntu 9.04
Message-Id: <m2r68676e01004020215ta1bfe349r4eb3bb9f0c00fb15@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001cad1d0$d5ea3820$81bea860$@org.uk>
In-Reply-To: <000001cad1d0$d5ea3820$81bea860$@org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Again, please keep the list in CC.

On Thu, Apr 1, 2010 at 11:28 PM, Jon & Lisa Williams
<jon-lisa@doctors.org.uk> wrote:
>> If your kernel is recent enough (which version are you currently
>> using?) you can load the driver with "modprobe asus_atk0110"; the
>> module should be inserted automagically though, can you check whether
>> it's already there or not (lsmod)?
>
> The kernel is 2.6.28-18.
> How/where do I obtain the asus_atk0110 driver (lsmod does not show it present).

Ah, the kernel is too old. The driver was first included in 2.6.30.
I think that the easiest way to get a newer kernel is to upgrade to
Ubuntu 9.10; in alternative you can try a packaged mainline kernel:
http://kernel.ubuntu.com/~kernel-ppa/mainline/

but this might break other things (so be sure to keep the old working
kernel installed when trying a package from the PPA).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
