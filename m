From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: 2.7.0 Error in make
Message-Id: <20030120173822.A23130@earth.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E2C49C0.705@moment.net>
In-Reply-To: <3E2C49C0.705@moment.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* DB Troll <hdbtroll@moment.net> [2003-01-20 16:30:19 -0600]:
> >
> Jean,
> Ignore last msg I found flex and installed but still come up with an error
> 
> > lib/libsensors.so: undefined reference to `sensors_yylex'
> > lib/libsensors.so: undefined reference to `sensors_yyin'
> > lib/libsensors.so: undefined reference to `sensors_lex_error'
> > lib/libsensors.so: undefined reference to `sensors_yylineno'
> > collect2: ld returned 1 exit status
> > make: *** [prog/sensors/sensors] Error 1
> > linux:/home/dbtrol/lm_sensors-2.7.0 #David
> 
> David
> 

After you've installed flex and bison (or equivalent), you
probably need to "make clean" before you "make" again.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
