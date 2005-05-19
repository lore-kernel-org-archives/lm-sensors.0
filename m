From: fabrice@yako.via.ecp.fr (Fabrice Ollivier)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: stdarg.h inclusion problem (ticket #1343)
Message-Id: <1058736432.30749.4.camel@kalaha>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have stdarg.h :cif@kalaha ~% locate stdarg.h
/usr/lib/gcc-lib/i386-linux/2.95.4/include/stdarg.h
/usr/lib/gcc-lib/i386-linux/3.0.4/include/stdarg.h
/usr/lib/gcc-lib/i386-linux/3.2.3/include/stdarg.h
/usr/lib/gcc-lib/i386-linux/3.3.1/include/stdarg.h
(an updatedb was made just before)

cif@kalaha ~% gcc -print-search-dirs
install?s: /usr/lib/gcc-lib/i386-linux/3.3.1/
programmes:
=/usr/lib/gcc-lib/i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/:/usr/
lib/gcc-lib/i386-linux/:/usr/lib/gcc/i386-linux/3.3.1/:/usr/lib/gcc/i386-linux/:
/usr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-linux/bin/i386-linux/3.3.1/:
/usr/lib/gcc-lib/i386-linux/3.3.1/../../../../i386-linux/bin/
libraries:
=/usr/lib/gcc-lib/i386-linux/3.3.1/:/usr/lib/gcc/i386-linux/3.3.1/:/usr/lib/
gcc-lib/i386-linux/3.3.1/../../../../i386-linux/lib/i386-linux/3.3.1/:/usr/lib/
gcc-lib/i386-linux/3.3.1/../../../../i386-linux/lib/:/usr/lib/gcc-lib/i386-linux/
3.3.1/../../../i386-linux/3.3.1/:/usr/lib/gcc-lib/i386-linux/3.3.1/../../../:
/lib/i386-linux/3.3.1/:/lib/:/usr/lib/i386-linux/3.3.1/:/usr/lib/

Any Idea ?

-- 
Cif
