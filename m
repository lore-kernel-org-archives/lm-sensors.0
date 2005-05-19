From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: CVS problem
Message-Id: <20020108165944.A14967@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Ah, got it.  It should be fixed now.  New directories are being
created with the wrong group designation for some reason.


Phil

On Tue, Jan 08, 2002 at 07:33:28PM -0500, Mark D. Studebaker wrote:
> Ticket #783
> 
> I made a new directory prog/init
> and it has caused problems on checkout.
> 
> I tried it myself and had same problem.
> thanks
> mds
> 
> -------------------
> 
> 
> cvs server: Updating lm_sensors2/prog/init
> cvs server: failed to create lock directory for
> `/home/cvs/lm_sensors2/prog/init'
> (/home/cvs/lm_sensors2/prog/init/#cvs.lock): Permission denied
> cvs server: failed to obtain dir lock in repository
> `/home/cvs/lm_sensors2/prog/init'
> cvs [server aborted]: read lock failed - giving up

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
