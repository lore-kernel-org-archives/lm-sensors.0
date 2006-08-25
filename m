From: s.cormier@gmx.net (Stephen Cormier)
Date: Fri, 25 Aug 2006 18:34:21 +0000
Subject: [lm-sensors] Gkrellm support was Re: Asus M2NPV-VM and lm-sensors
Message-Id: <200608251534.38426.s.cormier@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 25 August 2006 07:41, Prakash Punnoor wrote:
> Hi,
>
> Yes, I foundit in the mailing list archives. Works nice, unfortunately
> gkrellm doesn't support it yet.
>

Gkrellm will support the k8temp if you patch libsensors then build and install 
the lm-sensors package. I got the patch in the file amd_digital_temp.tar.gz 
which I believe was posted on this list by the author if you cannot find it a 
quick Google on the file name comes up with http://assembler.cz/download/ as 
the location to get it which contains the same files as the tarball I have 
here. Then you need a patch to Gkrellm itself for the hwmon looks like I got 
that one when I applied the abituguru patch to libsensors as I only find this 
(1) when searching on the patch name with Hans's name in there. I have 
attached this patch if you want to try it as it is contained with a few 
others. BTW both drivers have been working great in the time I have been 
using them many thanks to their respective authors and everyone else doing 
all the hard work so we can have decent support for our hardware.

(1)http://www.redhat.com/archives/fedora-extras-commits/2006-July/msg01559.html

Stephen

-- 
GPG Pubic Key: http://users.eastlink.ca/~stephencormier/publickey.asc
-------------- next part --------------
A non-text attachment was scrubbed...
Name: gkrellm-2.2.9-hwmon.patch
Type: text/x-diff
Size: 1444 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060825/2fe6e47c/attachment.bin 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060825/2fe6e47c/attachment-0001.bin 
