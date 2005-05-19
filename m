From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: /usr vs /usr/local
Message-Id: <20030818230826.GA3788@pua.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815221829.0f870e63.khali@linux-fr.org>
In-Reply-To: <20030815221829.0f870e63.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Fri, Aug 15, 2003 at 10:18:29PM +0200, Jean Delvare wrote:
> A suggestion for the next time you package the sensors userspace tools.
> In sensors-detect, we suggest the user should run
> "/usr/local/bin/sensors -s". You should change that to "/usr/bin/sensors
> -s" since that's where you install that program. Could confuse the
> users...

Thanks, I just fixed that, repackaged and the new packages will appear
at atrpms later.

I run a
find %{buildroot} -type f | xargs file | grep -E '(ASCII|Bourne shell)' | awk -F: '{print $1}' \
  | xargs perl -pi -e's,/usr/local,/usr,'
over the installed files, to catch also documentation bits.
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030819/59fdee5d/attachment.bin
