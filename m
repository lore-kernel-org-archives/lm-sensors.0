From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Mon, 24 Aug 2015 10:52:02 +0000
Subject: [lm-sensors] [RFC] i2c: Revert back to old device naming for ACPI enumerated I2C slaves
Message-Id: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Dustin Byford <dustin@cumulusnetworks.com>, linux@roeck-us.net, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Commit 70762abb9f89 ("i2c: Use stable dev_name for ACPI enumerated I2C
slaves") broke the lm-sensors which relies on I2C hwmon slave devices under
/sys/bus/i2c/devices/ to be named as "x-00yz". However if those hwmon
devices are ACPI 5 enumerated their name became "i2c-INTABCD:ij" and sysfs
code in lm-sensors does not find them anymore:

lib/sysfs.c:665:
if ((!subsys || !strcmp(subsys, "i2c")) &&
    sscanf(dev_name, "%hd-%x", &entry.chip.bus.nr,
	   &entry.chip.addr) = 2) {

This patch fixes this by reverting back the old device naming in i2c-core
but at the same avoids regression to ALSA SoC drivers that depend on stable
device binding.

Reverted I2C slave device naming is handled in ALSA SoC core by using the
ACPI name as a component name if device is ACPI probed. This keeps the
component binding in ALSA SoC stable and requires only minimal changes to
affected machine drivers.

Fixes: 70762abb9f89 i2c: Use stable dev_name for ACPI enumerated I2C slaves
Reported-by: Dustin Byford <dustin@cumulusnetworks.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
This is on top of 4.2.0-rc8. I didn't check exact kernel versions where this
still applies but I know we would need a few different versions for older
stable versions. Mainly because of added and moved drivers in
sound/soc/intel/.

This is for discussion so I didn't cc stable@vger.kernel.org yet. I was
thinking would it work if we'd keep the stable name but have an another
symlink in /sys/bus/i2c/devices/ that uses "x-00yz" name. However this
feels ill-use of devices directory and probably causes more troubles
elsewhere.

I don't know how common ACPI enumerated I2C hwmon devices are but I guess
they exists since Dustin notices this issue and wrote "With that change,
/sys/bus/i2c/devices/i2c-0-004a, for example, became
/sys/bus/i2c/devices/i2c-PNPXXXX:xx".

It could be possible there is use for the new device naming. I found a
comment from Documentation/hid/hid-sensor.txt introduced by commit
b2eafd7282fd ("HID: sensor: Update document for custom sensor") that seems
to indicate current i2c-INTABCD:xy naming may be used from userspace too but
I didn't find examples of that.
---
 drivers/i2c/i2c-core.c                       | 21 ++++-----------------
 sound/soc/intel/boards/broadwell.c           |  6 +++---
 sound/soc/intel/boards/byt-max98090.c        |  2 +-
 sound/soc/intel/boards/byt-rt5640.c          |  2 +-
 sound/soc/intel/boards/bytcr_rt5640.c        |  2 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |  4 ++--
 sound/soc/intel/boards/cht_bsw_rt5645.c      |  4 ++--
 sound/soc/intel/boards/cht_bsw_rt5672.c      |  6 +++---
 sound/soc/intel/boards/haswell.c             |  2 +-
 sound/soc/soc-core.c                         | 10 ++++++++++
 10 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c83e4d13cfc5..e9c227b9dc92 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -913,22 +913,6 @@ void i2c_unlock_adapter(struct i2c_adapter *adapter)
 }
 EXPORT_SYMBOL_GPL(i2c_unlock_adapter);
 
-static void i2c_dev_set_name(struct i2c_adapter *adap,
-			     struct i2c_client *client)
-{
-	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
-
-	if (adev) {
-		dev_set_name(&client->dev, "i2c-%s", acpi_dev_name(adev));
-		return;
-	}
-
-	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
-	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
-		     client->addr | ((client->flags & I2C_CLIENT_TEN)
-				     ? 0xa000 : 0));
-}
-
 /**
  * i2c_new_device - instantiate an i2c device
  * @adap: the adapter managing the device
@@ -987,7 +971,10 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->dev.of_node = info->of_node;
 	client->dev.fwnode = info->fwnode;
 
-	i2c_dev_set_name(adap, client);
+	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
+	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
+		     client->addr | ((client->flags & I2C_CLIENT_TEN)
+				     ? 0xa000 : 0));
 	status = device_register(&client->dev);
 	if (status)
 		goto out_err;
diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 8bafaf6ceab1..3abcf0d7682e 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -205,7 +205,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 		.cpu_dai_name = "snd-soc-dummy-dai",
 		.platform_name = "snd-soc-dummy",
 		.no_pcm = 1,
-		.codec_name = "i2c-INT343A:00",
+		.codec_name = "INT343A:00",
 		.codec_dai_name = "rt286-aif1",
 		.init = broadwell_rt286_codec_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
@@ -223,7 +223,7 @@ static int broadwell_suspend(struct snd_soc_card *card){
 	struct snd_soc_codec *codec;
 
 	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
-		if (!strcmp(codec->component.name, "i2c-INT343A:00")) {
+		if (!strcmp(codec->component.name, "INT343A:00")) {
 			dev_dbg(codec->dev, "disabling jack detect before going to suspend.\n");
 			rt286_mic_detect(codec, NULL);
 			break;
@@ -236,7 +236,7 @@ static int broadwell_resume(struct snd_soc_card *card){
 	struct snd_soc_codec *codec;
 
 	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
-		if (!strcmp(codec->component.name, "i2c-INT343A:00")) {
+		if (!strcmp(codec->component.name, "INT343A:00")) {
 			dev_dbg(codec->dev, "enabling jack detect for resume.\n");
 			rt286_mic_detect(codec, &broadwell_headset);
 			break;
diff --git a/sound/soc/intel/boards/byt-max98090.c b/sound/soc/intel/boards/byt-max98090.c
index 7ab8cc9fbfd5..ae336b8522a8 100644
--- a/sound/soc/intel/boards/byt-max98090.c
+++ b/sound/soc/intel/boards/byt-max98090.c
@@ -116,7 +116,7 @@ static struct snd_soc_dai_link byt_max98090_dais[] = {
 		.stream_name = "Audio",
 		.cpu_dai_name = "baytrail-pcm-audio",
 		.codec_dai_name = "HiFi",
-		.codec_name = "i2c-193C9890:00",
+		.codec_name = "193C9890:00",
 		.platform_name = "baytrail-pcm-audio",
 		.init = byt_max98090_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
diff --git a/sound/soc/intel/boards/byt-rt5640.c b/sound/soc/intel/boards/byt-rt5640.c
index ae89b9b966d9..275b056c495c 100644
--- a/sound/soc/intel/boards/byt-rt5640.c
+++ b/sound/soc/intel/boards/byt-rt5640.c
@@ -186,7 +186,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.stream_name = "Audio",
 		.cpu_dai_name = "baytrail-pcm-audio",
 		.codec_dai_name = "rt5640-aif1",
-		.codec_name = "i2c-10EC5640:00",
+		.codec_name = "10EC5640:00",
 		.platform_name = "baytrail-pcm-audio",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 7f55d59024a8..973f07548b08 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -171,7 +171,7 @@ static struct snd_soc_dai_link byt_dailink[] = {
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
 		.codec_dai_name = "rt5640-aif1",
-		.codec_name = "i2c-10EC5640:00",
+		.codec_name = "10EC5640:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 						| SND_SOC_DAIFMT_CBS_CFS,
 		.be_hw_params_fixup = byt_codec_fixup,
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 70f832114a5a..1a5348771e03 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -232,7 +232,7 @@ static struct snd_soc_ops cht_be_ssp2_ops = {
 static struct snd_soc_aux_dev cht_max98090_headset_dev = {
 	.name = "Headset Chip",
 	.init = cht_max98090_headset_init,
-	.codec_name = "i2c-104C227E:00",
+	.codec_name = "104C227E:00",
 };
 
 static struct snd_soc_dai_link cht_dailink[] = {
@@ -265,7 +265,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
 		.codec_dai_name = "HiFi",
-		.codec_name = "i2c-193C9890:00",
+		.codec_name = "193C9890:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 					| SND_SOC_DAIFMT_CBS_CFS,
 		.init = cht_codec_init,
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index bdcaf467842a..c05841264dc7 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -290,7 +290,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
 		.codec_dai_name = "rt5645-aif1",
-		.codec_name = "i2c-10EC5645:00",
+		.codec_name = "10EC5645:00",
 		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
 					| SND_SOC_DAIFMT_CBS_CFS,
 		.init = cht_codec_init,
@@ -365,7 +365,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		}
 	}
 	card->dev = &pdev->dev;
-	sprintf(codec_name, "i2c-%s:00", drv->acpi_card->codec_id);
+	sprintf(codec_name, "%s:00", drv->acpi_card->codec_id);
 	/* set correct codec name */
 	strcpy((char *)card->dai_link[2].codec_name, codec_name);
 	snd_soc_card_set_drvdata(card, drv);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 2c9cc5be439e..632926d0c595 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -280,7 +280,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.no_pcm = 1,
 		.nonatomic = true,
 		.codec_dai_name = "rt5670-aif1",
-		.codec_name = "i2c-10EC5670:00",
+		.codec_name = "10EC5670:00",
 		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
 					| SND_SOC_DAIFMT_CBS_CFS,
 		.init = cht_codec_init,
@@ -296,7 +296,7 @@ static int cht_suspend_pre(struct snd_soc_card *card)
 	struct snd_soc_codec *codec;
 
 	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
-		if (!strcmp(codec->component.name, "i2c-10EC5670:00")) {
+		if (!strcmp(codec->component.name, "10EC5670:00")) {
 			dev_dbg(codec->dev, "disabling jack detect before going to suspend.\n");
 			rt5670_jack_suspend(codec);
 			break;
@@ -310,7 +310,7 @@ static int cht_resume_post(struct snd_soc_card *card)
 	struct snd_soc_codec *codec;
 
 	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
-		if (!strcmp(codec->component.name, "i2c-10EC5670:00")) {
+		if (!strcmp(codec->component.name, "10EC5670:00")) {
 			dev_dbg(codec->dev, "enabling jack detect for resume.\n");
 			rt5670_jack_resume(codec);
 			break;
diff --git a/sound/soc/intel/boards/haswell.c b/sound/soc/intel/boards/haswell.c
index 22558572cb9c..6fd6491e368d 100644
--- a/sound/soc/intel/boards/haswell.c
+++ b/sound/soc/intel/boards/haswell.c
@@ -160,7 +160,7 @@ static struct snd_soc_dai_link haswell_rt5640_dais[] = {
 		.cpu_dai_name = "snd-soc-dummy-dai",
 		.platform_name = "snd-soc-dummy",
 		.no_pcm = 1,
-		.codec_name = "i2c-INT33CA:00",
+		.codec_name = "INT33CA:00",
 		.codec_dai_name = "rt5640-aif1",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0e1e69c7abd5..811d63e31a7a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -34,6 +34,7 @@
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
@@ -2476,10 +2477,18 @@ static char *fmt_single_name(struct device *dev, int *id)
 {
 	char *found, name[NAME_SIZE];
 	int id1, id2;
+	struct acpi_device *adev;
 
 	if (dev_name(dev) = NULL)
 		return NULL;
 
+	if (ACPI_HANDLE(dev) &&
+	    !acpi_bus_get_device(ACPI_HANDLE(dev), &adev)) {
+		/* use ACPI name as a component name for ACPI probed devices */
+		strlcpy(name, acpi_dev_name(adev), NAME_SIZE);
+		goto out;
+	}
+
 	strlcpy(name, dev_name(dev), NAME_SIZE);
 
 	/* are we a "%s.%d" name (platform and SPI components) */
@@ -2508,6 +2517,7 @@ static char *fmt_single_name(struct device *dev, int *id)
 			*id = 0;
 	}
 
+out:
 	return kstrdup(name, GFP_KERNEL);
 }
 
-- 
2.5.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
