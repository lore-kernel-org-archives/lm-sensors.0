From: Sean MacLennan <seanm@seanm.ca>
Date: Tue, 19 Feb 2008 02:21:02 +0000
Subject: Re: [lm-sensors] [PATCH] Add driver for AD7414 i2c temperature
Message-Id: <47BA3D0E.5060800@seanm.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <A42C17A8FF150C4DB98BFD6497D1D00007F45D79@ussvlexmbpf1.spansion.com>
In-Reply-To: <A42C17A8FF150C4DB98BFD6497D1D00007F45D79@ussvlexmbpf1.spansion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Great, thanks for testing. Would you also feel like reviewing the code?
>
>   
I grabbed the original message from the web interface. Some of the 
longer lines were wrapped,  I am not sure if that is a problem with the 
original patch, or the web interface. An example is:

+ * Copyright 2006 Stefan Roese <sr at denx.de>, DENX Software
Engineering


Some comments:

+struct ad7414_data {
+	struct i2c_client	client;
+	struct class_device	*dev;

I this this should be struct device, not class_device.

+	struct mutex	lock;	/* atomic read data updates */

Line up?

+	char			valid;	/* !=0 if following fields are
valid */
+	unsigned long	last_updated;	/* In jiffies */

Line up?

+	u16			temp_input;	/* Register values */
+	u8			temp_max;
+	u8			temp_min;
+	u8			temp_alert;
+	u8			temp_max_flag;
+	u8			temp_min_flag;
+};



Much codes goes by ;)

+static int ad7414_remove(struct i2c_client *client)
+{
+	struct ad7414_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->dev);
+	sysfs_remove_group(&client->dev.kobj, &ad7414_group);
+	kfree(data);
+	return 0;
+}
+
+static struct i2c_driver ad7414_driver = {
+	.driver = {
+		.name	= "ad7414",
+	},
+	.probe	= ad7414_probe,
+	.remove	= __devexit_p(ad7414_remove),
+};

I believe the ad7414_remove function needs a _devexit to match the 
__devexit_p. Other than that, the code looks clean.

Cheers,
   Sean

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
