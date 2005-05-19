From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: 2.6.5 problems
Message-Id: <3D8B5669.F64CE483@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

dmi_scan.c doesn't compile in-kernel (ticket 1002)
for at least one person, dmi_scan.c doesn't compile as a module, but it works for me (tkt 1002)
i2c-elv.c doesn't compile for 2.2 kernels because of __exit (ticket 1005)

I'd like to look at these more this weekend and put fixes on the home page
before we do the freshmeat thing.
