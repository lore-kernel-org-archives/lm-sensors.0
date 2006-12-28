From: david.c.hubbard@gmail.com (David Hubbard)
Date: Thu, 28 Dec 2006 06:59:26 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <4dfa50520612272259s60543f7fkf76c02c540fa6273@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

I'm working on the w83627ehf module (which supports the w83627dhg
chip). I can tell you that the coretemp module is for your Core 2 Duo.
The Core 2 Duo reports digital temperatures directly to the coretemp
module, and does not involve the w83627dhg. As you know, the coretemp
module is new. It hasn't even been added to the linux/drivers/hwmon
directory (as of 2.6.20-rc2.

> OK, being waiting for answer, I have tried to patch a kernel. Patching
> was OK (except for rejecting in ./Documentation/...). Kernel making gives:

The reason the patch does not apply correctly to 2.6.19-rc2 is because
the patch is meant for 2.6.20-rc1 or later. There were changes to the
file linux/Documentation/hwmon/w83627ehf that are part of 2.6.20-rc1.
You should be OK ignoring the patch error unless you encounter
problems. Then you should update to a 2.6.20 kernel and start from
there. If the patch doesn't apply cleanly to 2.6.20-rc1, then I'd be
interested to find out why.

> WARNING: "msr_read" [drivers/hwmon/coretemp.ko] undefined!

The latest coretemp sources might fix this. I believe Rudolf Marek is
still discussing the details of the RDMSR and WRMSR instructions with
H. Peter Anvin and Alan Cox. That is why you get the error. The code
might compile OK on a 2.6.18 kernel, since Rudolf wrote the code for
that kernel.

More information:
- thread http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018438.html
- message http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018443.html

> gentoo-sources-2.6.19-r2 kernel tree is in use.

Thanks for providing enough info (i.e. the kernel version) so I can
make some guesses.

Again, I'm not the one who wrote coretemp, and it's not in a finished
state. So, there will be no official support until the driver is
submitted in final form. In the mean time, happy hacking!

David

