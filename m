From: urban@UNIX-Beratung.de (Robert Urban)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: use of iconv() in main.c
Message-Id: <200408160857.i7G8vTrs027501@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm building an embedded linux system using uClibc, which by default
does not have locale support.  In order to build lm_sensors-2.8.7
I had to comment out the code that refers to iconv() in set_degstr() (in
main.c), as well as the "#include <iconv.h>" line.

It might save others a bit of trouble if you made the use of locales
an option...

thanks for lm_sensors, by the way!

cheers,

Rob Urban
Munich, Germany
