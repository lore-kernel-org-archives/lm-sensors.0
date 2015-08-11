From: Nicolas Roy-Renaud <victoiredupeuple@hotmail.com>
Date: Tue, 11 Aug 2015 20:09:38 +0000
Subject: [lm-sensors] [PATCH] pwmconfig checks for stable readings instead of waiting 5 secs
Message-Id: <BLU437-SMTP2120BBE4F8A7B8F16CF0B9DE7F0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU436-SMTP244DA91C09F18BCD3DE8232DE7F0@phx.gbl>
In-Reply-To: <BLU436-SMTP244DA91C09F18BCD3DE8232DE7F0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I was having issues with pwmconfig on one of my machines where the 
delays between each step weren't long enough to get my fan to reach its 
target speed. This made for some rather strange readings, and so rather 
than just change the delay between each step, I isolated that logic in 
TestPWMSpeed() and made it so the the script starts reading immediately 
after the pwm change and every .5 second after that. It then compares 
the last 10 values and if the variation is below a certain threshold 
(currently 15 RPM, though it might be a bit low), it marks the value as 
stable and moves on. If after 20 readings (i.e : 10 seconds) the value 
still can't be considered stable, the step times out and the last value 
read is used as if it was stable (which is conform to the current 
behavior).
FanSpeedIsStable() needs at least 10 readings (5 seconds) to verify 
whether the speed is now stable or not, although that could probably 
lowered to 5.

That doesn't seem to affect much of the script logic at the moment, 
seeing how these values are only used for plotting speed-PWM graphs and 
detecting when the fan stops, but it's probably closer to the intended 
behaviors than using delays.

Nicolas

Signed-off-by: Nicolas Roy-Renaud <victoiredupeuple@hotmail.com>
---
  prog/pwm/pwmconfig | 87 
+++++++++++++++++++++++++++++++++++++++++-------------
  1 file changed, 66 insertions(+), 21 deletions(-)

diff --git a/prog/pwm/pwmconfig b/prog/pwm/pwmconfig
index 1dcebba..5ce2313 100755
--- a/prog/pwm/pwmconfig
+++ b/prog/pwm/pwmconfig
@@ -29,8 +29,8 @@
  #
  #

-REVISION=$(echo '$Revision$' | cut -d' ' -f2)
-REVDATE=$(echo '$Date$' | cut -d' ' -f2)
+REVISION=$(echo '$Revision: 6243 $' | cut -d' ' -f2)
+REVDATE=$(echo '$Date: 2014-03-20 11:23:35 +0100 (jeu. 20 mars 2014) $' 
| cut -d' ' -f2)
  PIDFILE="/var/run/fancontrol.pid"

  if [ -f "$PIDFILE" ]
@@ -319,6 +319,69 @@ echo -n 'Hit return to continue: '
  read X
  echo

+VALS_CHECKED_FOR_STABLE
+VARIATION_LIMIT
+#TIMEOUT
+CHECK_DELAY=0.5
+#CHECK_STEPS=$(($TIMEOUT/CHECK_DELAY))
+CHECK_STEPS 
+
+function FanSpeedIsStable() {
+    # Might not work with a thinkpad_acpi style interface
+    local last_vals=($@)
+    local length=${#last_vals[@]}
+
+    if [[ $length -lt $VALS_CHECKED_FOR_STABLE ]]; then
+        return 1 # Not enough values
+    else
+        last_vals=($(for val in "${last_vals[@]}"; do echo $val; done | 
sort -n))
+        delta=$(( ${last_vals[0]} - ${last_vals[$length-1]} ))
+        abs_delta=${delta#-}
+
+        #echo "${last_vals[@]} -- Delta : $abs_delta"
+
+        if [[ $abs_delta -lt $VARIATION_LIMIT ]]; then
+            return 0 # Stable
+        else
+            return 1 # Not stable
+        fi
+    fi
+}
+
+function TestPWMSpeed() {
+    local P=$1
+    local F=$2
+    local pwm=$3
+
+    pwmset $P $pwm
+    declare -a last_vals
+
+    trap "{ pwmdisable $P; echo '^C received, aborting...'; rm -f $TMP1 
$TMP2; exit 1; }" INT
+
+    for i in $(eval echo {0..$CHECK_STEPS}); do
+        S=`cat $F`
+
+        echo -ne "\033[2K"\\r
+        echo -ne "PWM $pwm : $S RPM"
+
+        if [[ ${#last_vals[@]} -ge $VALS_CHECKED_FOR_STABLE ]]; then
+            unset last_vals[0]
+        fi
+
+        last_vals=(${last_vals[@]} $S)
+
+        if FanSpeedIsStable ${last_vals[@]}; then
+            echo " (STABLE)"
+            return 0
+        fi
+
+        sleep $CHECK_DELAY
+    done
+
+    echo " (TIMEOUT)"
+    return 1
+}
+
  PLOTTER=gnuplot
  STEP
  PDELAY=2
@@ -331,7 +394,6 @@ function pwmdetail()
  {
      local P=$1 F=$2
      local X PLOT= TMP1 TMP2
-    local threshold0000 pwm S

      type $PLOTTER > /dev/null 2>&1
      if [ $? -eq 0 ]
@@ -366,24 +428,7 @@ function pwmdetail()
      pwmenable $P
      while [ $pwm -ge 0 ]
      do
-        pwmset $P $pwm
-        sleep $PDELAY
-        if [ $? -ne 0 ]
-        then
-            pwmdisable $P
-            echo '^C received, aborting...'
-            rm -f $TMP1 $TMP2
-            exit 1
-        fi
-        S=`cat $F`
-        # Fan speed should never increase significantly
-        if [ $S -gt $threshold ]
-        then
-            echo "    PWM $pwm FAN $S (probably incorrect)"
-        else
-            echo "    PWM $pwm FAN $S"
-            let threshold=S*6/5
-        fi
+        TestPWMSpeed $P $F $pwm

          if [ "$PLOT" = "y" ]
          then
-- 
2.5.0

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
