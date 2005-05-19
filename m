From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: pwmconfig: bug in temporary file creation
Message-Id: <20050124140712.GA17184@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

There is a bug in pwmconfig, it uses a fixed file name for the temporary
files. As it uses /usr/tmp instead of /tmp, it is not really a security
bug, but I think it should be fixed. Moreover /usr/tmp doesn't exists on
all distributions, though I haven't checked if it is specified in the
FHS.

The attached patch, provided by Javier Fern?ndez-Sanguino Pe?a via the
Debian BTS, fixes that.

Bye,
Aur?lien
 

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: prog/pwm/pwmconfig
=================================RCS file: /home/cvs/lm_sensors2/prog/pwm/pwmconfig,v
retrieving revision 1.13
diff -u -1 -b -p -r1.13 pwmconfig
--- prog/pwm/pwmconfig	20 Dec 2004 22:00:10 -0000	1.13
+++ prog/pwm/pwmconfig	24 Jan 2005 12:54:56 -0000
@@ -211,4 +211,5 @@ function pwmdetail()
 	then
-		TMP1=/usr/tmp/pwmtest$$.1
-		TMP2=/usr/tmp/pwmtest$$.2
+		TMP1=`tempfile` || { echo "$0: Cannot create temporary file" >&2; exit 1;  }
+		TMP2=`tempfile` || { echo "$0: Cannot create temporary file" >&2; exit 1;  }
+		trap " /bin/rm -f -- \"$TMP1\" \"$TMP2\" " 0 1 2 3 13 15
 		echo "set xlabel \"PWM: $P\"" > $TMP1
