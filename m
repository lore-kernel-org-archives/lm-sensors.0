From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: dmi_scan patching (was: 2.8.6 rpms at ATrpms)
Message-Id: <20040407104320.GB13977@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 07, 2004 at 11:35:08AM +0200, Jean Delvare wrote:
> > AFAICT these patches need to be simultaneously applied to kernel
> > and lm_sensors (which will make their inclusion in 2.8.7 more
> > difficult...)
> 
> I don't see why it would be more difficult. Remember that the fact that
> I sent you three different patches is not relevant. The lm_sensors
> dmi_scan patch will be integrated to our source tree, so you won't have
> to care about it. Ditto for the mkpatch change. And the kernel patch
> will be integrated into mkpatch, so you won't have to apply it
> manually. This means that you won't have to take any different action.
> You will just use mkpatch to generate the patch, and apply it to the
> kernel tree.
> 
> Remember that the issue doesn't affect the compilation outside of the
> kernel tree.

Ah, OK, that was the part I was missing. I thought the patch to the
kernel's dmi_scan would be neccessary in the case of external
compilation also.

> So it looks quite easy and straightforward, providing I update the
> lm_sensors files as planned. Or did I miss a thing?

No, I did ;)
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040407/790a336a/attachment.bin
