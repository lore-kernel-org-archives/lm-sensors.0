From: David Anderson <davea42@gmail.com>
Date: Fri, 01 Nov 2013 15:49:29 +0000
Subject: [lm-sensors] w83795.c no longer compiles
Message-Id: <5273CD89.6030803@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just installed the new Ubuntu 13.10.   Kernel 3.11.0-12 #19.
I get an error building w83795.c (building a module to read
my  w83795adg temp sensor) for this kernel.

The source is from 
http://khali.linux-fr.org/devel/lm-sensors/drivers/w83795/
and has been working for quite a while ... but not with this new kernel
series (it was  a 3.8.0 kernel in Ubuntu 13.04 and worked fine there).

The error:
       'implicit declaration of function 'SENSORS LIMIT' '
at, for example,

      return SENSORS_LIMIT((val + 50) / 100, 0, 0xff);


Thanks in advance for any suggestions.

David Anderson


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
