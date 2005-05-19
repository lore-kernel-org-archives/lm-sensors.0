From: william.mcclintock@schriever.af.mil (McClintock William J Contr MCOM)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <B8BD20F161298A42A3B513D23A28556701101F3A@fsglenex3.schriever.af.mil>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This probably means that lm_sensors2 used older i2c headers. Did you
> also install i2c-2.8.1 or CVS? It's a requirement.

CVS version of i2c and lm_sensors were both installed on the redhat 9
system.  Now whether it installed the headers in the correct place...I never
checked but all seemed to work well so...no harm no fowl...

> Please provide the output of "ls -l
> /proc/sys/dev/sensors/eeprom-i2c-0-50".

[root@workstation1 root]# ls -l /proc/sys/dev/sensors/eeprom-i2c-0-50
total 0
-r--r--r--    1 root     root            0 Nov 25 14:36 00
-r--r--r--    1 root     root            0 Nov 25 14:36 10
-r--r--r--    1 root     root            0 Nov 25 14:36 20
-r--r--r--    1 root     root            0 Nov 25 14:36 30
-r--r--r--    1 root     root            0 Nov 25 14:36 40
-r--r--r--    1 root     root            0 Nov 25 14:36 50
-r--r--r--    1 root     root            0 Nov 25 14:36 60
-r--r--r--    1 root     root            0 Nov 25 14:36 70
-r--r--r--    1 root     root            0 Nov 25 14:36 80
-r--r--r--    1 root     root            0 Nov 25 14:36 90
-r--r--r--    1 root     root            0 Nov 25 14:36 a0
-r--r--r--    1 root     root            0 Nov 25 14:36 b0
-r--r--r--    1 root     root            0 Nov 25 14:36 c0
-r--r--r--    1 root     root            0 Nov 25 14:36 d0
-r--r--r--    1 root     root            0 Nov 25 14:36 e0
-r--r--r--    1 root     root            0 Nov 25 14:36 f0

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: Tuesday, November 25, 2003 1:19 PM
To: McClintock William J Contr MCOM
Cc: sensors@Stimpy.netroedge.com; frdurso@yahoo.com.br
Subject: Re: unknown eeprom type (65) [ticket #1449]


> Requested output below...Sensors installed on this machine are CVS as
> of a few days ago...I had to tweak a file to get the package to build
> but it was for an unresolved definition for the
> <kernel/chips/fscher.c> driver file. Should not have affected anything
> I hope.

This probably means that lm_sensors2 used older i2c headers. Did you
also install i2c-2.8.1 or CVS? It's a requirement.

> Interesting side note...I have two systems both with the same
> Motherboard and RAM setup, basically both system are identical except
> for video card and peripherals.  One, the one with the issues, is
> running redhat 9 somewhat up2date and the other Fedora Core
> 1(evaluating prior to second system install).  The thing that's
> interesting is the Fedora Core 1 lm_sensors works out of the box,
> sensors are functioning.  Also sensors-detect only suggested i2c-isa
> and w83781d with Fedora Core 1.  Redhat 9 suggested those two plus
> eeprom and i2c-nforce2.  Not sure if that's anything but I thought it
> was odd...Just wanted to mention.

This just means that Fedora has no support for the nForce2 yet (it's
faitly recent), and the nForce2 gives access to eeproms. So there's
nothing to be afraid of, and no one to blame either.

> [root@workstation1 root]# cat /proc/sys/dev/sensors/eeprom-i2c-0-50/*
> 127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
> 45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
> 127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
> 45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
> 127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
> 45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
> 127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
> 45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
> 127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
> 45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
> 127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
> 45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
> 127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
> 45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
> 127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
> 45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0

This is odd, and answers my questions. The driver is broken. This should
be the same (in decimal) as what i2cdump shows (in hexadecimal). And as
you can see, it isn't the case. Rows 04 and 05 are repeated instead.

Now, there are two possibilities. Either the driver doesn't return the
correct values, or the procfs interface to the driver is broken.

Please provide the output of "ls -l
/proc/sys/dev/sensors/eeprom-i2c-0-50".

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
