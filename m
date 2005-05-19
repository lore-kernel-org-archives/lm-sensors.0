From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Linux 2.6.3, lm_sensors 2.8.5
Message-Id: <20040219082836.GF29686@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218232559.2621d402.khali@linux-fr.org>
In-Reply-To: <20040218232559.2621d402.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Wed, Feb 18, 2004 at 11:25:59PM +0100, Jean Delvare wrote:
> Linux 2.6.3 is out. We want to release lm_sensors 2.8.5, don't we?
> 
> I know this is only two weeks since the last release, but I am not
> responsible for the very short cycle of Linux 2.6.3. And it happens that
> the w83l785ts driver in Linux 2.6.3 isn't compatible with libsensors
> from lm_sensors 2.8.4. There may be other compatibility issues, but this
> is the main one I can think of.
> 
> So, according to Greg's theory, we should release a new version of
> lm_sensors, numbered 2.8.5. OTOH, we probably don't want to release i2c
> 2.8.5 with an empty change list.

Could the versioning scheme be redesigned, so that the first two
digits indicate the same i2c/lm_sensors interface? E.g. lm_sensors
2.9.x requires i2c 2.9.y where x is not necessarily equal to y.

That way one could decouple release cycles of lm_sensors and i2c to
use different pacing. It would also help packagers to decide whether a
new kernel with mandatory i2c patching is necessary for building
lm_sensors kernel modules, and even embed virtually Provides and
Requires in kernels and lm_sensors packages (e.g. a future
kernel-2.6.10-i2c193 provides "kernel-i2c = 2.9.3" and
lm_sensors-2.9.7 requires "kernel-i2c >= 2.9.0, kernel-i2c <= 2.10").

> I propose to set the deadline to Friday, February 20th, 2004.
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040219/c0291221/attachment.bin
