From: grant_lkml@dodo.com.au (Grant Coady)
Date: Tue, 31 May 2005 22:57:39 +0000
Subject: [lm-sensors] lm_sensors 2.9.1 sensord compile failure on 2.6.11.11
Message-Id: <3ajp919q0mrsh54gp476t2dft454dtr41l@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1lhn91hj2hvhq65un08m8nae3f7fvt3ubv@4ax.com>
In-Reply-To: <1lhn91hj2hvhq65un08m8nae3f7fvt3ubv@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 31 May 2005 16:27:38 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:
>
>Hi Grant and all, greetings live from the Guadec :)
Enjoy the 'break' :o)

>> It is probably something stupid, but I cannot see it, make user; make
>> user_install work fine, why not other stuff?
>
>Try:
>make PROG_EXTRA:=sensord user
>
>Without a target explicitely handled to not build kernel dependency
>files, these dependency files are built, but this doesn't work with 2.6
>kernels, only 2.4 ones. Specifying "user" as the target solves the
>problem. If you can fix the Makefile system to behave better, patches
>are welcome :)

Now I get, after make clean; make PROG_EXTRA:=sensord user :

/usr/lib/gcc-lib/i486-slackware-linux/3.3.5/../../../../i486-slackware-linux/bin/ld: 
 cannot find -lrrd
collect2: ld returned 1 exit status
make: *** [prog/sensord/sensord] Error 1

which is back outside of lm_sensors space, thank you.  I'll pass 
your fix on to user, he's the one has built sensord before :)

--Grant.

