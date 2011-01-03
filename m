From: DB <Freddog_de@yahoo.co.uk>
Date: Mon, 03 Jan 2011 22:03:05 +0000
Subject: [lm-sensors] Problem making lmsensors
Message-Id: <4D224799.4050300@yahoo.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Good evening all - & a happy new year!

I'm just trying to set up lmsensors & keep getting the following error 
messages:


  make install
gcc -Wl,-rpath,/usr/local/lib -o prog/sensors/sensors 
prog/sensors/main.ro prog/sensors/chips.ro  -Llib -lsensors
lib/libsensors.so: undefined reference to `sensors_yylex'
lib/libsensors.so: undefined reference to `sensors_lex_error'
lib/libsensors.so: undefined reference to `sensors_yylineno'
lib/libsensors.so: undefined reference to `sensors_scanner_exit'
lib/libsensors.so: undefined reference to `sensors_scanner_init'
lib/libsensors.so: undefined reference to `sensors_yyfilename'
collect2: ld returned 1 exit status
make: *** [prog/sensors/sensors] Error 1

Can anyone please give me an idea what I am missing?

My system is uname -ar
Linux Fedora-Blue 2.6.34.7-66.fc13.i686.PAE #1 SMP Wed Dec 15 07:21:49 
UTC 2010 i686 i686 i386 GNU/Linux
I downloaded & installed bison & flex.

Thanks

Dave

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
