From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Mon, 22 May 2006 10:36:58 +0000
Subject: [lm-sensors] make user output
Message-Id: <20060522103658.GB12713@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <OFECJLLKEMLEIPDNILGBKEGIEPAA.jtmitche@mindspring.com>
In-Reply-To: <OFECJLLKEMLEIPDNILGBKEGIEPAA.jtmitche@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi John:

* John T. Mitchell <jtmitche at mindspring.com> [2006-05-21 23:29:09 -0400]:
> I have been trying to get lm-sensors working on a Mitac 8355 laptop for the
> last two days without success.  I believe I am just doing something wrong.
> Anyway I am running Ubuntu Dapper Drake with all of the newest updates.
> When I try make user I get the following output:
> 
> grep: /usr/src/linux/include/linux/autoconf.h: No such file or directory
> grep: /usr/src/linux/include/linux/autoconf.h: No such file or directory
> make: *** No rule to make target `sysfs/libsysfs.h', needed by
> `lib/sysfs.ad'. Stop.
> 
> Being fairly new to Linux I don't understand how to fix the missing
> autoconf.h file?  Any help or suggestions would be welcomed.

lm-sensors depends on a library called libsysfs.  To build lm-sensors from
source, you either need to (1) build and install sysfsutils from source,
or (2) install a package that includes libsysfs headers.

Option #2 is easiest.  On Ubuntu, the package you need is libsysfs-dev.
Install that, then back to lm-sensors... 'make clean' and 'make user'
and 'make user_install' should do it.

Also, don't worry about the "grep: ... No such file or directory" warnings.
That is mentioned in the FAQ:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


