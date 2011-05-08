From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 May 2011 12:29:05 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110508142905.2c39d797@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 08 May 2011 06:19:11 -0500, Jeff Rickman wrote:
> On 5/8/2011 1:27 AM, Jean Delvare wrote:
> > Did you try loading this original i8k driver? Did it work? What are the
> > contents of /proc/i8k then?
> 
> [testing with original "i8k" module]
> (1) Removed new "i8k" module from /lib/modules tree
> (2) Checked "/proc/i8k". No such file or directory
> (3) Copied original "i8k" module back to it's location in:
> /lib/modules/`uname -r`/drivers/char
> (4) Ran "depmod -a"
> (5) Rebooted PC to obtain known stable state
> 
> After reboot...
> (6) Checked "/proc/i8k". No such file or directory
> (7) Checked "lsmod". "i8k" is not loaded
> (8) Attempted to load original "i8k" but it crashed.
>      Crash output is attached.
> (9) Rechecked "/proc/i8k". No such file or directory
> (10) Rebooted PC to return to known stable state

This means that my changes aren't responsible for the crash, nor is the
fact of building the driver standalone. So I will leave it to the
Fedora kernel maintainers to resolve, if you care and if they are
interested.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
