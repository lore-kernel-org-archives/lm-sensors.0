From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: W83627HF SuperIO support in lm_sensors
Message-Id: <20030929180436.GB1779@pua.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alfredo,

copying sensors@Stimpy.netroedge.com on this one.

On Mon, Sep 29, 2003 at 05:49:47PM +0200, Alfredo Milani-Comparetti wrote:
> The main problem is that the W83627HF module is not included amongst the 
> loadable modules that can be MODPROBEd with your latest kernel for RH9.
> This leads to a SENSORS-DETECT routine that suggests to load W83627HF, which, 
> in turn, is actually unavailable.
> At present I've reverted to the original kernel from RH9 and written by hand a 
> PERL script which enables some bits in the SuperIO chip in order to let it be 
> found on the SMBus, but I think it would be nice to be able to find all 
> available modules for all known chips :-)

I used the kernel-patching method described in the lm_sensors 2.8.0
documentation. Could you try to do the same, to reproduce whether the
problem is in the packaging or in the upstream sources?

Thanks!
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030929/508c97d7/attachment.bin
