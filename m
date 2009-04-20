From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Apr 2009 09:22:59 +0000
Subject: [lm-sensors] Skip building of the static libsensors
Message-Id: <20090420112259.6f92f332@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

OpenSuse is apparently getting rid of all static libraries. I tend to
agree, static libraries are almost always the wrong thing to do (think
bug fixes and maintenance updates).

In order to help, I have just modified the libsensors build system to
make it possible to skip the static library. It is more efficient than
letting it build and then just not installing it. If you want to skip
building of the static library, all you have to do is change:

BUILD_STATIC_LIB := 1

to

BUILD_STATIC_LIB := 0

in the main Makefile. Or alternatively, build with:

make BUILD_STATIC_LIB=0

(Then don't forget to also pass this parameter to "make install".)

I am curious what the policy of other distributions is. If nobody is
interested in the static library then maybe it would make sense to
change the default to 0?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
