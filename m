From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: /usr vs /usr/local
Message-Id: <20030824145231.GD3014@pua.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815221829.0f870e63.khali@linux-fr.org>
In-Reply-To: <20030815221829.0f870e63.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sat, Aug 23, 2003 at 07:24:02PM +0200, Jean Delvare wrote:
> Another thing I'm thinking of, back to the initial problem, is that we
> could make the script detect where sensors is (we already do for device
> files, modules.conf and dmidecode) so that the script works whatever the
> configuration. In this case, you wouldn't have to do anything special on
> your side (and, even, doing something could harmlessly break the
> script).
> 
> Any opinion?

This sounds a bit like an autoconf task. It would mean converting the
lm_sensors checks into m4 chuncks, which probably isn't worth while
for only defining the installation prefix.
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030824/4bdc76eb/attachment.bin
