From: greg@kroah.com (Greg KH)
Date: Wed, 12 Jul 2006 23:27:24 +0000
Subject: [lm-sensors] [PATCH 12/13] [PATCH] hwmon: Fix for first generation
Message-Id: <11527468804095-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Hans de Goede <j.w.r.degoede at hhs.nl>

Now that the abituguru driver is seeing some more widespread testing
it has turned out that one the first generation of Abit uGuru
motherboards, with uGuru revision 1, the autodetect bank1 sensor type
code doesn't (always) work. This patch adds a module param to override
the autodetect, and it adds validity checks for the value of the 2
other autodetection override module params. An example of howto use
the new param can be found here:
http://lm-sensors.org/wiki/Configurations/Abit/AN7

Signed-off-by: Hans de Goede <j.w.r.degoede at hhs.nl>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/abituguru.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index 59122cc..cc15c4f 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -142,6 +142,14 @@ static const u8 abituguru_pwm_max[5] = {
 static int force;
 module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Set to one to force detection.");
+static int bank1_types[ABIT_UGURU_MAX_BANK1_SENSORS] = { -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 };
+module_param_array(bank1_types, int, NULL, 0);
+MODULE_PARM_DESC(bank1_types, "Bank1 sensortype autodetection override:\n"
+	"   -1 autodetect\n"
+	"    0 volt sensor\n"
+	"    1 temp sensor\n"
+	"    2 not connected");
 static int fan_sensors;
 module_param(fan_sensors, int, 0);
 MODULE_PARM_DESC(fan_sensors, "Number of fan sensors on the uGuru "
@@ -397,6 +405,15 @@ abituguru_detect_bank1_sensor_type(struc
 	u8 val, buf[3];
 	int ret = ABIT_UGURU_NC;
 
+	/* If overriden by the user return the user selected type */
+	if (bank1_types[sensor_addr] >= ABIT_UGURU_IN_SENSOR &&
+			bank1_types[sensor_addr] <= ABIT_UGURU_NC) {
+		ABIT_UGURU_DEBUG(2, "assuming sensor type %d for bank1 sensor "
+			"%d because of \"bank1_types\" module param\n",
+			bank1_types[sensor_addr], (int)sensor_addr);
+		return bank1_types[sensor_addr];
+	}
+
 	/* First read the sensor and the current settings */
 	if (abituguru_read(data, ABIT_UGURU_SENSOR_BANK1, sensor_addr, &val,
 			1, ABIT_UGURU_MAX_RETRIES) != 1)
@@ -514,7 +531,7 @@ abituguru_detect_no_bank2_sensors(struct
 {
 	int i;
 
-	if (fan_sensors) {
+	if (fan_sensors > 0 && fan_sensors <= ABIT_UGURU_MAX_BANK2_SENSORS) {
 		data->bank2_sensors = fan_sensors;
 		ABIT_UGURU_DEBUG(2, "assuming %d fan sensors because of "
 			"\"fan_sensors\" module param\n",
@@ -568,7 +585,7 @@ abituguru_detect_no_pwms(struct abitugur
 {
 	int i, j;
 
-	if (pwms) {
+	if (pwms > 0 && pwms <= ABIT_UGURU_MAX_PWMS) {
 		data->pwms = pwms;
 		ABIT_UGURU_DEBUG(2, "assuming %d PWM outputs because of "
 			"\"pwms\" module param\n", (int)data->pwms);
-- 
1.4.1


