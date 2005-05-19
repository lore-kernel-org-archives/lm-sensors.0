From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: sensors strace
Message-Id: <20031123183426.51043260.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

As I was investigating the long running "sensors: run as root?" issue, I
found something strange. There is a mysterious sysctl call before and
after reading the /etc/sensors.conf file. See:

open("/etc/sensors.conf", O_RDONLY)     = 3
(...)
ioctl(3, TCGETS, 0xbfffe6f8)            = -1 ENOTTY (Inappropriate ioctl
                                          for device)
(...)
ioctl(3, TCGETS, 0xbfffe6c8)            = -1 ENOTTY (Inappropriate ioctl
                                          for device)

I was unable to find where in the code we do that, but I suspect that
this is in lex/yacc generated code (which is simply unreadable). Does
anyone have an explanation? What's that "TCGETS" supposed to do, and why
is it failing?

Also, the configuration file is never closed. I guess it could be, once
the parsing has been done, can't it?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
