From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: i2c & lm_sensors for RH
Message-Id: <20030805152145.GA17020@puariko.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802172008.GA10034@puariko.nirvana>
In-Reply-To: <20030802172008.GA10034@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sat, Aug 02, 2003 at 08:22:20PM +0200, Axel Thimm wrote:
> On Sat, Aug 02, 2003 at 08:11:07PM +0200, Jean Delvare wrote:
> > > Is anyone working on this? If not, I'd be interested (I have
> > > been maintaining rpms for kernel and userland parts for
> > > i2c/lm_sensors 2.7.0 at atrpms).

I managed to merge and build i2c&lm_sensors into the kernel sources
for RH 9/8.0/7. The only change to i2c&lm_sensors I had to make were
prepatches to get the code base patchable for some parts that changed
up to the 2.4.21 release. So no real patches for i2c/lm_sensors in the
kernel space. :)

I have now turned to the userspace. In order to build the lm_sensors
userland I need to compile against the kernel headers including the
patched in i2c headers (so I2C_HEADERS and LINUX_HEADERS point to the
same dir).

Since I am building against kernel headers, does that mean that the
resulting tools are only applicable to that kernel? Or are they to any
kernel that has i2c/lm_sensors 2.8.0 patched in?

I wonder if I need LINUX_HEADERS at all, since I am not building
external modules, and whether I should simply "carry" the i2c tarball
with the lm_sensors source package and build against the i2c headers
in that tarball (in order to build independently of the running kernel
or installed kernel sources). Does that make sense?
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030805/8bb0bc44/attachment.bin
