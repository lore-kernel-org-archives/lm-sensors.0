From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 02 Aug 2014 00:58:10 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (ads1015) Fix out-of-bounds array access
Message-Id: <CAFRkauDCmmfPFdX8j7pJn-beyzuwnndOPZxqABfee+tWzsQMVg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406858589.21842.2.camel@phoenix>
In-Reply-To: <1406858589.21842.2.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-08-01 10:03 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> Current code uses data_rate as array index in ads1015_read_adc() and uses pga
> as array index in ads1015_reg_to_mv, so we must make sure both data_rate and
> pga settings are in valid value range. If the setting is out-of-range, don't
> apply it.

Or maybe it's better to use the default settings instead if the setting is
out of range? comments?

diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
index 22e0c92..fe1a5a1 100644
--- a/drivers/hwmon/ads1015.c
+++ b/drivers/hwmon/ads1015.c
@@ -212,6 +212,7 @@ static int ads1015_get_channels_config_of(struct
i2c_client *client)
  dev_err(&client->dev,
  "invalid gain on %s\n",
  node->full_name);
+ pga = ADS1015_DEFAULT_PGA;
  }
  }

@@ -222,6 +223,7 @@ static int ads1015_get_channels_config_of(struct
i2c_client *client)
  dev_err(&client->dev,
  "invalid data_rate on %s\n",
  node->full_name);
+ data_rate = ADS1015_DEFAULT_DATA_RATE;
  }
  }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
