From: mario@mariovaldez.org (=?ISO-8859-1?Q?=22Mario_A=2E_Valdez-Ram=EDrez=22?=)
Date: Wed, 12 Apr 2006 05:44:29 +0000
Subject: [lm-sensors] Compilation endless loop...
Message-Id: <443C93BD.6080704@mariovaldez.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----


lm_sensors list:

      Hi. After reading a few support tickets about similar problems I
discovered why I was getting a compilation endless loop. I'm sending
this email just in case some other user gets into the same problem.


       I upgraded the motherboard and CPU of a Slackware 10.1 server.
As there were too many differences in the hardware I had to recompile
the kernel. The problem was that the motherboard BIOS date was set a
few days in the future (I really thought it was Tuesday, not Monday,
go figure).

      When I tried to compile the i2c package it started generating
some kernel/*.d files over and over again, in and endless loop.

      I later found out the date was wrong (when the computer tried to
sync its date/time with a NTP server, it was too late: several files
in the Linux kernel had their date in the future.

      After browsing the support ticket system I learned that if the
date of the filesystem was not right, the make process may behave
like that. So, I unpacked a brand new kernel tree and after compiling
a new kernel, i2c and lm_sensors compiled correctly.


      End of story.  :)



      Regards,

      Mario A. Valdez-Ramirez.




-----BEGIN PGP SIGNATURE-----
Version: PGP 8.0

iQCVAwUBRDyTuTpHuYe8JiHtAQEdJQP/aPO9kUH0lUKpFuDjFD6s3i1eZSf+IC7n
uUErPfxHZnbTQ07A0U5INWl9AbHoHa5jF3ccZ85q6iRCWukBaFOXRnMtu+o5iQ2g
0k/xbD6zUAKxBxU9qOYk9q8I1iRqQwTa6bU3IxarRv7DcenO/OzXbMdFOZxhjsy3
V6JgKFhQr0Q=Ixs/
-----END PGP SIGNATURE-----


