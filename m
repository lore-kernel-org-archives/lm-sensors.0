From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Lm_sensors
Message-Id: <20040114102852.GC16807@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Den,

On Wed, Jan 14, 2004 at 11:56:21AM +0300, Den wrote:
> Hello Axell!
> I'm make patch to add support lm90 and asb100 sensors into fedora 
> kernel. It's work fine for me on Gigabyte  Ga-7vaxp (lm90 cpu sensor) 
> and Asus P4pe (asb100). Patch based on standart lm_sensors patch. I'm 
> testing this patch on 2135, 2138, 2140 and 2149 kernel, all ok. Patch 
> replace your lm_sensors path. I'm think, support for this modern sensors 
> is needed for community.
> Sorry for bad english.
> DenV <den@nekto.com>
> (some rpms for Fedora core http://den.tourinfo.ru/pack)

On Wed, Jan 14, 2004 at 12:06:10PM +0300, Den wrote:
> Hello Axell!
> PS. This patch is need 2 lines in configs:
> CONFIG_SENSORS_ASB100=m
> CONFIG_SENSORS_LM90=m
> 
> DenV <den@nekto.com>

thanks for the feedback and the testing, they are probably best to be
shared with the lm_sensors list (Cced).

These two drivers are built by the lm_sensors project only when doing
the kernel modules build option, as they are considered
experimental. lm_sensors's patching method is more conservative.

In order to satisfy both conservatives and experimentalists, I provide
both a kernel with the lm_sensors patch, as well as lm_sensors modules
build out of the tree (but against the lm_sensors patched tree).

E.g. install a matching lm_sensors-kmdl additional to the
lm_sensors/i2c enebaled kernel, e.g.

   lm_sensors-kmdl-2.4.22-1.2140.nptl_30.rhfc1.at-2.8.2-0_19.rhfc1.at.i686.rpm

for the 2.4.22-1.2140.nptl_30.rhfc1.at kernel on an i686.

Could you test whether these rpms work for you? Thanks!
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040114/d9922dc7/attachment.bin
