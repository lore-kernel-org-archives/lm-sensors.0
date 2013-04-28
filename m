From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Apr 2013 09:47:19 +0000
Subject: [lm-sensors] [PATCH 5/5] pwm: Declare local variables as such
Message-Id: <20130428114719.1db6af16@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Declare local variables as such to avoid unintended side effects.
---
 prog/pwm/fancontrol |   27 +++++++++++++++++++--------
 prog/pwm/pwmconfig  |   22 ++++++++++++++--------
 2 files changed, 33 insertions(+), 16 deletions(-)

--- lm-sensors.orig/prog/pwm/fancontrol	2013-04-03 13:21:55.936015106 +0200
+++ lm-sensors/prog/pwm/fancontrol	2013-04-03 13:28:05.602865576 +0200
@@ -43,9 +43,10 @@ PIDFILE="/var/run/fancontrol.pid"
 #DEBUG=1
 MAX%5
 
-declare -i pwmval
+function LoadConfig
+{
+	local fcvcount fcv
 
-function LoadConfig {
 	echo "Loading configuration from $1 ..."
 	if [ ! -r "$1" ]
 	then
@@ -206,8 +207,9 @@ function ValidateDevices()
 }
 
 # Check that all referenced sysfs files exist
-function CheckFiles {
-	local outdated=0
+function CheckFiles
+{
+	local outdated=0 fcvcount pwmo tsen fan
 
 	let fcvcount=0
 	while (( $fcvcount < ${#AFCPWM[@]} )) # go through all pwm outputs
@@ -311,7 +313,8 @@ echo $$ > "$PIDFILE"
 # $1 = pwm file name
 function pwmdisable()
 {
-	ENABLE=${1}_enable
+	local ENABLE=${1}_enable
+
 	# No enable file? Just set to max
 	if [ ! -f $ENABLE ]
 	then
@@ -344,7 +347,8 @@ function pwmdisable()
 # $1 = pwm file name
 function pwmenable()
 {
-	ENABLE=${1}_enable
+	local ENABLE=${1}_enable
+
 	if [ -f $ENABLE ]
 	then
 		echo 1 > $ENABLE 2> /dev/null
@@ -358,7 +362,8 @@ function pwmenable()
 
 function restorefans()
 {
-	local status=$1
+	local status=$1 fcvcount pwmo
+
 	echo 'Aborting, restoring fans...'
 	let fcvcount=0
 	while (( $fcvcount < ${#AFCPWM[@]} )) # go through all pwm outputs
@@ -376,7 +381,13 @@ trap 'restorefans 0' SIGQUIT SIGTERM
 trap 'restorefans 1' SIGHUP SIGINT
 
 # main function
-function UpdateFanSpeeds {
+function UpdateFanSpeeds
+{
+	local fcvcount
+	local pwmo tsens fan mint maxt minsa minso minpwm maxpwm
+	local tval pwmpval fanval min_fanval one_fan one_fanval
+	local -i pwmval
+
 	let fcvcount=0
 	while (( $fcvcount < ${#AFCPWM[@]} )) # go through all pwm outputs
 	do
--- lm-sensors.orig/prog/pwm/pwmconfig	2013-04-03 13:21:55.936015106 +0200
+++ lm-sensors/prog/pwm/pwmconfig	2013-04-03 13:22:22.909661030 +0200
@@ -144,7 +144,7 @@ fi
 # $1 = padding
 function print_devices()
 {
-	local name
+	local name device
 
 	for device in $DEVICES
 	do
@@ -157,7 +157,8 @@ function print_devices()
 # $1 = pwm file name
 function is_pwm_auto()
 {
-	ENABLE=${1}_enable
+	local ENABLE=${1}_enable
+
 	if [ -f $ENABLE ]
 	then
 		if [ "`cat $ENABLE`" -gt 1 ]
@@ -172,7 +173,8 @@ function is_pwm_auto()
 # $1 = pwm file name
 function pwmdisable()
 {
-	ENABLE=${1}_enable
+	local ENABLE=${1}_enable
+
 	# No enable file? Just set to max
 	if [ ! -f $ENABLE ]
 	then
@@ -211,7 +213,8 @@ function pwmdisable()
 # $1 = pwm file name
 function pwmenable()
 {
-	ENABLE=${1}_enable
+	local ENABLE=${1}_enable
+
 	if [ -w $ENABLE ]
 	then
 		echo 1 2>/dev/null > $ENABLE
@@ -326,9 +329,9 @@ STEP2_BELOW1
 
 function pwmdetail()
 {
-	P=$1
-	F=$2
-	PLOT+	local P=$1 F=$2
+	local X PLOT= TMP1 TMP2
+	local threshold0000 pwm S
 
 	type $PLOTTER > /dev/null 2>&1
 	if [ $? -eq 0 ]
@@ -359,7 +362,6 @@ function pwmdetail()
 		> $TMP2
 	fi
 
-	local threshold0000
 	let pwm=$MAX
 	pwmenable $P
 	while [ $pwm -ge 0 ]
@@ -666,6 +668,8 @@ LoadConfig $FCCONFIG
 # $1 = pwm value below which the fan is stopped
 function TestMinStart()
 {
+	local fanok FANTEST
+
 	echo
 	echo 'Now we increase the PWM value in 10-unit-steps.'
 	echo 'Let the fan stop completely, then press return until the'
@@ -791,6 +795,8 @@ function RememberDevices()
 
 function SaveConfig()
 {
+	local tmpfile
+
 	RememberDevices "$FCTEMPS" "$FCFANS"
 
 	echo

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
