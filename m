From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: [PATCH 0/63] convert usb_control_msg() and usb_bulk_msg() to
Message-Id: <20050209224144.66f0ed41@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050209000212.GB5661@us.ibm.com>
In-Reply-To: <20050209000212.GB5661@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: gregkh@us.ibm.com, marcel@holtmann.org, maxk@qualcomm.com, jt@hpl.hp.com, perex@suse.cz, linux-dvb-maintainer@linuxtv.org, linux-usb-devel@lists.sourceforge.net, bluez-devel@lists.sourceforge.net, irda-users@lists.sourceforge.net, alsa-devel@alsa-project.org, linux-dvb@linuxtv.org, sensors@stimpy.netroedge.com

On Tue, 8 Feb 2005 16:02:12 -0800
Nishanth Aravamudan <nacc@us.ibm.com> wrote:

> Hi,
> 
> The following patchset (affecting USB, Bluetooth, IrDA, Sound, DVB and W1 --
> hence the long To: an Cc: lists...) converts the usb_control_msg() and
> usb_bulk_msg() functions to use milliseconds in the timeout parameter instead
> of jiffies. This is not a problem for almost all cases, as the requested delays are usually quite long wrt. these two functions.

As for w1 - this changes do not break anything, but
I'm not sure that it will not break usb core code which can
depend on jiffies and thus arch specific timings.

So I have a question: is this change intentional and thus by design requires
milliseconds, or it just happens that HZ=1000 on the most of the platforms?
 
> I see several reasons for committing these changes:
> 
> 1) Expressing time in milliseconds makes the code cleaner and easier to
> understand. It also makes the delay independent (from a code perspective) of
> HZ's value, which would be important for dynamic-HZ or tickless systems.
> 
> 2) Also for dynamic-HZ/tickless systems, it becomes unclear what exactly HZ
> represents. Milliseconds have meaning in the human world beyond the kernel. This
> ties in pretty strongly with 1)'s point about understanding.
> 
> 3) As the time/timer subsystem evolves and changes, the overall message I am
> seeing is that jiffies are not a proper expression of time. Thus, I am hoping
> these patches minimize this particular interface's usage of jiffies in this
> way; while, in the end, the call to usb_start_wait_for_urb ends up with the
> same jiffies-based time, if the timer subsystem were to, for instance, convert
> to nanoseconds, we could instead pass on the parameter multiplied by a million.
> It simply makes adjusting to any new time system that much easier.
> 
> Exceptions do exist, of course, and the following files do not use a
> HZ-relative timeout variable; thus I was unsure how exactly to proceed.
> Given that HZ=1000 in i386, the constants used technically correspond
> directly to milliseconds. I am unsure if that is the intent of the author
> in all cases, though. I left the hard-coded non-HZ related values alone in all
> cases.
> 
> drivers/isdn/hisax/hfc_usb.c
> drivers/usb/media/dabusb.c
> drivers/usb/media/dsbr100.c
> drivers/usb/media/stv680.c
> drivers/usb/media/w9968cf.c
> drivers/usb/misc/emi26.c
> drivers/usb/misc/emi62.c
> drivers/usb/serial/cypress_m8.c
> drivers/usb/serial/ftdi_sio.c
> drivers/usb/serial/io_edgeport.c
> drivers/usb/serial/kobil_sct.c
> drivers/usb/serial/pl2303.c
> drivers/media/dvb/dibusb/dvb-dibusb-usb.c
> drivers/usb/media/dabusb.c
> drivers/w1/dscore.c
> 
> As always, any comments or suggestions are greatly appreciated.
> 
> -Nish


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
