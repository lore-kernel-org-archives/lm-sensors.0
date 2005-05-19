From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: Call for 2.8.0 soon
Message-Id: <20030629143729.2aa8b433.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE7C67A.4040703@paradyne.com>
In-Reply-To: <3EE7C67A.4040703@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> - GCC 3.3 warnings Khali is working?

GCC 3.2 warnings fixed.

Oh, by the way, I got this message when installing latest CVS:

***********************************************************************
*******
Warning: This is the first installation of the libsensors.so*
         library files in /usr/local/lib !!!
         You must run /sbin/ldconfig to update the library cache or
         the userspace tools may fail or have unpredictable results !!!
***********************************************************************
*******

Though I think the message can be useful in some cases, I already had
the libraries installed there, but a previous version (1.4.0 as opposed
to 2.0.0). I think the message should mention that, or it will seem to
be pointless to users in this case.

Also, why don't we run ldconfig by ourselves in this case? We could even
grep /etc/ld.so.conf for /usr/local/lib and display a warning only if
the line is not found (or add it by ourselves, but I'm not in favor of
this).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
