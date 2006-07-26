From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 26 Jul 2006 14:36:52 +0000
Subject: [lm-sensors] [PATCH] AMD K8 digital sensor
Message-Id: <44C77E04.6010504@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44C69648.9060808@sh.cvut.cz>
In-Reply-To: <44C69648.9060808@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Rudolf Marek wrote:
> Hello all,
> 
> And info for users:
> The userspace patch is still in here
> http://assembler.cz/download/amd_digital_temp.tar.gz
> the patch itself is for 2.6.18rc-2 but should work on any post 2.6.15
> kernel. If you need standalone version, use that one in the archive.
> 

I was thinking about doing things differently with regards to userspace.
As I already posted to the list I'm working on a driver for the uGuru2.
The driver is done (waiting for feedback from testers) but I still need
todo userspace. Since the uGuru2 driver is going to be 2.6 only and
since 2.6 has a clear API/ABI between userspace and the kernel for hwmon
chips I was thinking about adding code to libsensors for generic 2.6
support. The idea is to write a piece of code which will come into
action only if libsensors doesn't have a chip definition for a found
chip and libsensors is running on a  2.6 kernel. This piece of code
would then fill a dynamicly allocated structure describing the unknown
chip, using the same structure as for known chips.

Does this sound like a plan? With this in place we no longer need to
write support for every new 2.6 hwmon driver, actually if this goes in I
would like to see explicit support for the uGuru (1) be removed, since
this generic code should do just as good of a job.

Does this sound like  a plan (for 2.6 only drivers) ? Or are you
planning on porting this driver to 2.4?

Regards,

Hans

