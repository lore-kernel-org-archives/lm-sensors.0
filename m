From: shandih@bigpond.com (Stanley Hutchinson)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: Installation problems.
Message-Id: <200212241526.16960.shandih@bigpond.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi and Merry Xmas tomorrow,

Running SuSE Linux 8.0 with a Pentium 4 1.4GB on an Intel board with scsi 
drives

kernel appears to be /lib/modules/2.4.18-64GB-SMP

home/stan/Documents/i2c-2.7.0/make OK.
home/stan/Documents/i2c-2.7.0/make install fell foul of permissions and could 
not mkdir 'misc'
su to root and make install and depmod -a both completed without complaint

home/stan/Documents/lm-sensors_2.7.0/make  required install of 'bison' and 
'flex' and then pulled up with:-
	lib/libsensors.so: undefined reference to  sensors_yylex
	lib/libsensors.so: undefined reference to  sensors-yyin
	lib/libsensors.so: undefined reference to sensors-lex_error
	lib/libsensors.so: undefined reference to sensors-yylineno
Collect2: ld returned 1 exit status
Make: *** [prog/sensors/sensors ] Error 1

su to root gave the same result.

Following from your FAQ,
	prog/detect/i2cdetect   and   prog/detect/sensors-detect  both return
		'No such file or directory"

What do I need and where is it hidden ?

Stan
 
