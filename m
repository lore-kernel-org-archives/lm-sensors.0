From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: RPM spec file patches for i2c and lm_sensors 2.8.1
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E3E23F3@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E13FDA5@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E13FDA5@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I agree that you shouldn't distribute RPMs.  That doesn't make sense for kernel modules.  

For people like me, who want to easily deploy lm_sensors across a cluster of uniform machines, it's very handy to have a spec file there so that we can build our own RPMs for specific systems with specific kernels and configurations.  Even though the spec file you had was out of date, it still saved me a lot of trouble.  

My vote would be to keep the spec files.  If nobody wants to maintain them, call them unsupported or unmaintained.

Who's Axel?  I'd be happy to work with him, or just use whatever he has or recommends.

Unified diffs attached.

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Tuesday, October 28, 2003 2:16 PM
> To: Marc Rieffel; Axel Thimm
> Cc: sensors@Stimpy.netroedge.com
> Subject: Re: RPM spec file patches for i2c and lm_sensors 2.8.1
> 
> 
> 
> > I had to make these changes to be able to build i2c and lm_sensors
> > rpms that worked.  Also, lm_sensors.init isn't included in 
> any of the
> > rpms.  Looks like nobody's touched these for several versions.
> 
> You're right, the files were untouched since May 2000. Quite a while
> actually. We don't build RPMs anymore. I personnaly consider that this
> is the distributor's job, not our. They do that much better than we
> would.
> 
> > i2c.spec:
> > 
> > 25c27
> > < %define ver 2.8.1
> > ---
> > > %define ver 2.5.0
> > (...)
> 
> Please provide unified diffs if you want me to apply them to 
> our files.
> 
> You could also consider getting in touch with Axel, who is building
> quality RPM packages from our sources, using his own .spec 
> files. Maybe
> you both will agree on some version of the spec files that we should
> include in our source files. Or maybe we should simply remove the RPM
> directory from our source trees - that would be more honest 
> IMHO, since
> nobody here seems to be wanting to maintain them, while Axel 
> is doing a
> very great job on his side. Let packagers package, that's their job :)
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors.spec.diff
Type: application/octet-stream
Size: 1438 bytes
Desc: lm_sensors.spec.diff
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031028/5f123240/lm_sensors.spec.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-rh.spec.diff
Type: application/octet-stream
Size: 1729 bytes
Desc: i2c-rh.spec.diff
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031028/5f123240/i2c-rh.spec.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors.init.SuSE.patch
Type: application/octet-stream
Size: 2692 bytes
Desc: lm_sensors.init.SuSE.patch
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031028/5f123240/lm_sensors.init.SuSE.obj
