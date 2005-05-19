From: urban@UNIX-Beratung.de (Robert Urban)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: use of iconv() in main.c
Message-Id: <200408161049.i7GAnbWi016673@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408160857.i7G8vTrs027501@localhost.localdomain>
In-Reply-To: <200408160857.i7G8vTrs027501@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


You wrote:
> > I'm building an embedded linux system using uClibc, which by default
> > does not have locale support.  In order to build lm_sensors-2.8.7
> > I had to comment out the code that refers to iconv() in set_degstr() 
> > (in main.c), as well as the "#include <iconv.h>" line.
> > 
> > It might save others a bit of trouble if you made the use of locales
> > an option...
> 
> Is there a way we could detect the use of uClibc? If there is a known #define,
> we could use it to automatically disable the use of iconv.

In the case of cross-compiling, there is probably a way of detecting it's use.
However, I'm using a chroot-environment and then just running make
with the defaults.

Rob Urban
