From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: Small fixes to sensord.8 and sensors.conf.5
Message-Id: <20040314221810.GA30353@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040314182002.GA7183@pc.aurel32.private>
In-Reply-To: <20040314182002.GA7183@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 14, 2004 at 08:06:36PM +0100, Jean Delvare wrote:
> > - sensors.conf.5
> >   This man page refers to itself in the SEE ALSO section
> 
> I would tend to thing that it was trying to reference libsensors(3),
> since libsensors(3) is referencing sensors.conf(5). I would take a patch
> doing this.

Please find attached a new patch for that.

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: lib/sensors.conf.5
=================================RCS file: /home/cvs/lm_sensors2/lib/sensors.conf.5,v
retrieving revision 1.2
diff -u -1 -b -p -r1.2 sensors.conf.5
--- lib/sensors.conf.5	24 Dec 1999 22:44:41 -0000	1.2
+++ lib/sensors.conf.5	14 Mar 2004 22:22:46 -0000
@@ -410,2 +410,2 @@ lm_sensors-2.x
 .SH SEE ALSO
-sensors.conf(5)
+libsensors(3)
