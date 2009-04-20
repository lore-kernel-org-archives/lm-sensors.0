From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 20 Apr 2009 20:30:28 +0000
Subject: Re: [lm-sensors] Skip building of the static libsensors
Message-Id: <20090420203028.GZ10866@hall.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090420112259.6f92f332@hyperion.delvare>
In-Reply-To: <20090420112259.6f92f332@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 20, 2009 at 11:22:59AM +0200, Jean Delvare wrote:
> Hi all,
> 
> OpenSuse is apparently getting rid of all static libraries. I tend to
> agree, static libraries are almost always the wrong thing to do (think
> bug fixes and maintenance updates).
> 
> In order to help, I have just modified the libsensors build system to
> make it possible to skip the static library. It is more efficient than
> letting it build and then just not installing it. If you want to skip
> building of the static library, all you have to do is change:
> 
> BUILD_STATIC_LIB := 1
> 
> to
> 
> BUILD_STATIC_LIB := 0
> 
> in the main Makefile. Or alternatively, build with:
> 
> make BUILD_STATIC_LIB=0
> 
> (Then don't forget to also pass this parameter to "make install".)
> 
> I am curious what the policy of other distributions is. If nobody is
> interested in the static library then maybe it would make sense to
> change the default to 0?
> 

Debian still ships both shared and static libraries, but all packages
must link to the shared library. static libraries are reserved for local
use.

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
