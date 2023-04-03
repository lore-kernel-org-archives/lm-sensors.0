From: Michael Heimpold <michael.heimpold@chargebyte.com>
Date: Mon, 03 Apr 2023 09:59:28 +0000
Subject: [PATCH] Fix support for pwmfan driver since kernel v6.1
Message-Id: <20230403095928.5112-1-michael.heimpold@chargebyte.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Our product is an embedded Linux system, a charging station
controller with the possibility to attach a fan.
This fan can be controlled via PWM and the Linux driver we
use for it is "pwmfan". On top in userspace, we use
fancontrol and pwmconfig from lm-sensors.

We recently switched over to a newer Linux kernel version and
noticed that commit b99152d4f04b379e31db6c1a2dda6b272c92039b
(hwmon: (pwm-fan) Switch regulator dynamically) introduced an
issue: now the pwm1_enable file is present in the sysfs API
but the way the driver implements this is not compatible with
the expectations by fancontrol/pwmconfig:

According to https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface:

-snip-
pwm[1-*]_enable
    Fan speed control method:
    0: no fan speed control (i.e. fan at full speed)
    1: manual fan speed control enabled (using pwm[1-*])
    2+: automatic fan speed control enabled
    Check individual chip documentation files for automatic mode
    details.
-snap-

This is also what pwmconfig and fancontrol expects.

But the driver implementation does this:

Quote from https://www.kernel.org/doc/Documentation/hwmon/pwm-fan.rst
-snip-
pwm1_enable rw keep enable mode, defines behaviour when pwm1=0
    0 -> disable pwm and regulator
    1 -> enable pwm; if pwm=0, disable pwm, keep regulator enabled
    2 -> enable pwm; if pwm=0, keep pwm and regulator enabled
    3 -> enable pwm; if pwm=0, disable pwm and regulator
-snap-

So we have a regression here when using fancontrol/pwmconfig with
newer kernels.

As workaround, we have adapted the two mentioned scripts. The uses approach
is to check whether this special hwmon driver is used and ignore the
pwm1_enable file in this moment.

We are not sure, what the "correct" resolution here would be. So just
take this a discussion proposal.

Signed-off-by: Michael Heimpold <michael.heimpold@chargebyte.com>
---

PS: I'm not subscribed to the list, please keep Cc-ing me, thanks.

 prog/pwm/fancontrol | 11 ++++++++---
 prog/pwm/pwmconfig  | 21 ++++++++++++++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/prog/pwm/fancontrol b/prog/pwm/fancontrol
index 886a7367..5158be1a 100755
--- a/prog/pwm/fancontrol
+++ b/prog/pwm/fancontrol
@@ -399,9 +399,12 @@ declare -A PWM_ORIG_STATE
 function pwmdisable()
 {
 	local ENABLE=${1}_enable
+	local NAME="$(dirname ${1})/name"
+	local DRVNAME="$(cat $NAME)"
 
-	# No enable file? Just set to max
-	if [ ! -f $ENABLE ]
+	# No enable file? Just set to max;
+	# pwmfan driver implements enable file, but with different purpose
+	if [ ! -f $ENABLE ] || [ "$DRVNAME" = "pwmfan" ]
 	then
 		echo $MAX > $1
 		return 0
@@ -470,8 +473,10 @@ function pwmdisable()
 function pwmenable()
 {
 	local ENABLE=${1}_enable
+	local NAME="$(dirname ${1})/name"
+	local DRVNAME="$(cat $NAME)"
 
-	if [ -f $ENABLE ]
+	if [ -f $ENABLE ] && [ "$DRVNAME" != "pwmfan" ]
 	then
 		# save the original pwmN_control state, e.g. 1 for manual or 2 for auto,
 		# and the value from pwmN
diff --git a/prog/pwm/pwmconfig b/prog/pwm/pwmconfig
index edcbde9e..3e4af78a 100755
--- a/prog/pwm/pwmconfig
+++ b/prog/pwm/pwmconfig
@@ -157,6 +157,14 @@ function print_devices()
 function is_pwm_auto()
 {
 	local ENABLE=${1}_enable
+	local NAME="$(dirname ${1})/name"
+	local DRVNAME="$(cat $NAME)"
+
+	# pwmfan driver does not implement auto mode
+	if [ "$DRVNAME" = "pwmfan" ]
+	then
+		return 1
+	fi
 
 	if [ -f $ENABLE ]
 	then
@@ -173,9 +181,12 @@ function is_pwm_auto()
 function pwmdisable()
 {
 	local ENABLE=${1}_enable
+	local NAME="$(dirname ${1})/name"
+	local DRVNAME="$(cat $NAME)"
 
-	# No enable file? Just set to max
-	if [ ! -f $ENABLE ]
+	# No enable file? Just set to max;
+	# pwmfan driver implements enable file, but with different purpose
+	if [ ! -f $ENABLE ] || [ "$DRVNAME" = "pwmfan" ]
 	then
 		echo $MAX > $1
 		return 0
@@ -213,8 +224,12 @@ function pwmdisable()
 function pwmenable()
 {
 	local ENABLE=${1}_enable
+	local NAME="$(dirname ${1})/name"
+	local DRVNAME="$(cat $NAME)"
 
-	if [ -w $ENABLE ]
+	# enable pwm, but only if driver is not pwmfan since
+	# this one implements enable with different purpose
+	if [ -w $ENABLE ] && [ "$DRVNAME" != "pwmfan" ]
 	then
 		echo 1 2>/dev/null > $ENABLE
 		if [ $? -ne 0 ]
-- 
2.34.1
