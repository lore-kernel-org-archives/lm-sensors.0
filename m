From: PyroPeter <abi1789@googlemail.com>
Date: Sat, 01 May 2010 15:29:04 +0000
Subject: [lm-sensors] [Fancontrol] better support for init script error
Message-Id: <4BDC48C0.9090303@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some months ago, the /etc/fancontrol syntax changed, and fancontrol 
exited right after startup, but the init script stated success.

Currently there is no reliable way for a init script to check if 
fancontrol started up properly.

As fancontrol is a deamon preventing hardware damage, reliability should 
be of first priority.

I would suggest adding a argument to fancontrol that makes it start up, 
check config syntax and write permissions, and than fork to the 
background, or return a positive exit code.


I wrote a kind of proof of concept that simply uses the existing 
bash-script and "forks" by reexecuting itself in the background:

 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

diff -ru lm_sensors-3.1.2-1/usr/sbin/fancontrol 
lm_sensors-3.1.2-1_pyropeter/usr/sbin/fancontrol
--- lm_sensors-3.1.2-1/usr/sbin/fancontrol    2010-02-03 
03:45:15.000000000 +0100
+++ lm_sensors-3.1.2-1_pyropeter/usr/sbin/fancontrol    2010-03-07 
01:37:09.000000000 +0100
@@ -5,7 +5,9 @@
  #
  # Version 0.70
  #
-# Usage: fancontrol [CONFIGFILE]
+# Usage: fancontrol [-D] [CONFIGFILE]
+#
+# (-D causes fancontrol to 'fork' to the background after some tests)
  #
  # Dependencies:
  #   bash, egrep, sed, cut, sleep, readlink, lm_sensors :)
@@ -43,6 +45,12 @@
  #DEBUG=1
  MAX%5

+DAEMON=0
+if [ "$1" = "-D" ]; then
+    DAEMON=1
+    shift
+fi
+
  declare -i pwmval

  function LoadConfig {
@@ -303,7 +311,6 @@
      echo "File $PIDFILE exists, is fancontrol already running?"
      exit 1
  fi
-echo $$ > "$PIDFILE"

  # $1 = pwm file name
  function pwmdisable()
@@ -475,6 +482,14 @@
      let fcvcount=$fcvcount+1
  done

+if [ "$DAEMON" -gt 0 ]; then
+    echo "Forking..."
+    $0 $* &> /dev/null &
+    exit 0
+fi
+
+echo $$ > "$PIDFILE"
+
  echo 'Starting automatic fan control...'

  # main loop calling the main function at specified intervals

 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

I am not subscribed to this mailing list, so you need to CC me.

-- 
irc: PyroPeter at freenode


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
