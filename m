From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Linux 2.6.3, lm_sensors 2.8.5
Message-Id: <20040224223130.GC16826@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218232559.2621d402.khali@linux-fr.org>
In-Reply-To: <20040218232559.2621d402.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 24, 2004 at 09:09:26PM +0100, Jean Delvare wrote:
> > Thanks a lot! Rebuilding kernels, lm_sensors and kernel modules for
> > all other projects took me quite some time, but now there is the
> > latest FC1 kernel with patched in lm_sensors/i2c 2.8.4 as well as
> > lm_sensors 2.8.4 userland bits (and external kernel modules, but they
> > are probably redundant) available at
> > 
> > 	 http://atrpms.physik.fu-berlin.de/name/kernel/
> > 	 http://atrpms.physik.fu-berlin.de/name/lm_sensors/
> 
> BTW, I have fixed the unnecessary dependencies that lm_sensors-2.8.2, .3
> and .4 had to i2c-2.8.2, .3 and .4, respectively. Thus, lm_sensors
> 2.8.5, when we release it, will need i2c 2.8.1 only.

That is great, I could build it then for RH9/8.0/7.3, too, where I
have i2c 2.8.2 patched in :)
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040224/b2907cb5/attachment.bin
