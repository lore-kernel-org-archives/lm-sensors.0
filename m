From: <alex@maymay.de>
Date: Thu, 24 Jul 2008 20:57:00 +0000
Subject: [lm-sensors] lm-sensors installation problem
Message-Id: <000001c8edcf$d1e3f590$4001a8c0@userydq01op4u1>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am having trouble calling make all.
I get the following error message:

gcc -Wl,-rpath,/usr/local/lib -o lib/test/test-scanner lib/test/test-scanner.ro
lib/conf-lex.ao lib/error.ao lib/general.ao -Llib
lib/test/test-scanner.ro: In function `main':
test-scanner.c:(.text+0x1c): undefined reference to `sensors_scanner_init'
test-scanner.c:(.text+0x51): undefined reference to `sensors_yylex'
test-scanner.c:(.text+0x58): undefined reference to `sensors_yylineno'
test-scanner.c:(.text+0x9f): undefined reference to `sensors_scanner_exit'
collect2: ld returned 1 exit status
make: *** [lib/test/test-scanner] Error 1

Can anyone help please?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
