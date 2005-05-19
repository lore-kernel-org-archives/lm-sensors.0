From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: Ticket 1083 Error-msgs
Message-Id: <20021216121626.5cd1e5cb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <01C2A4F8.BC69F320.rloos@baer-gmbh.com>
In-Reply-To: <01C2A4F8.BC69F320.rloos@baer-gmbh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> P.S. I have the Linux kernel sources installed in /usr/src/linux
Yes, but these sources were never used. You did not compile your kernel
there, and this causes some files to be missing. You need to build a
kernel at least once, and it must match the kernel you are using
(version, config).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
