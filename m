From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: pwmconfig: bug in temporary file creation
Message-Id: <20050125102648.GA18023@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050124140712.GA17184@bode.aurel32.net>
In-Reply-To: <20050124140712.GA17184@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 24, 2005 at 08:43:38PM -0500, Mark Studebaker wrote:
> pwmtest$$.1 is not a fixed file name ($$ expands to the PID)
Actually I meant predictable, not fixed. As you now the PID will be
between 2 and 33000, a user could do a force attack:

for i in `seq 2 33000 ; do
    ln -s /etc/shadow /usr/tmp/pwmtest$i.1 ; 
done

Then if somebody run pwmconfig, /etc/shadow is wiped out.

You could find more information on:
http://www.linuxsecurity.com/content/view/115462/151/

Moreover, I checked the FHS, and /usr/tmp is not a standard directory.
It is however allowed for compatibility reasons, and in that case should
be link to /var/tmp. So /usr/tmp should not used in pwmconfig, /tmp 
should be used instead.

> and my linux system doesn't have the tempfile command...
You're right, it's seems is not a standard command. I have attached a
new patch using mktemp.
 

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: pwmconfig
=================================RCS file: /home/cvs/lm_sensors2/prog/pwm/pwmconfig,v
retrieving revision 1.13
diff -u -1 -b -p -r1.13 pwmconfig
--- pwmconfig	20 Dec 2004 22:00:10 -0000	1.13
+++ pwmconfig	25 Jan 2005 10:26:47 -0000
@@ -211,4 +211,4 @@ function pwmdetail()
 	then
-		TMP1=/usr/tmp/pwmtest$$.1
-		TMP2=/usr/tmp/pwmtest$$.2
+		TMP1=`mktemp -t pwmtest1.XXXXXXXXXX` || { echo "$0: Cannot create temporary file" >&2; exit 1; }
+		TMP2=`mktemp -t pwmtest2.XXXXXXXXXX` || { rm -f $TMP1 ; echo "$0: Cannot create temporary file" >&2; exit 1; }
 		echo "set xlabel \"PWM: $P\"" > $TMP1
