From: singumal <qdmd-pu1o@dea.spamcon.org>
Date: Sun, 24 Oct 2010 04:20:17 +0000
Subject: [lm-sensors] via-cputemp: can't compile it
Message-Id: <osc7c6hpu7hmbgl0afmslfbh49adnlocs5@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

V3.2.0 sensors-detect told me that my VIA M800 Mini-ITX has a VIA
Nano thermal sensor.  Checked the lm-sensors.org wiki on Devices
as instructed.  For the indicated via-cputemp driver, my CentOS
5.5 kernel is just 2.6.18 so I'd need to make a kernel module;
got the Makefile and via-cputemp.c from the indicated site, but
can't compile it, no instructions, doing "make" in a directory
with those two files, I get a number of errors starting with:

via-cputemp.c: In function =E2via_cputemp_probe=E2:
via-cputemp.c:106: error: called object =E2cpu_data=E2 is not a function

I already have the matching kernel-devel and kernel-headers
installed in the system.

Please tell me what I am missing in assumptions or environment
setup.


Also, in the main package, I noticed a "make install" grammar
error:

   ***  * As off lm-sensors 3.1.0, ...



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
