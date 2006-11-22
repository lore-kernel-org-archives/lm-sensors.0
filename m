From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 22 Nov 2006 17:48:45 +0000
Subject: [lm-sensors] RFC patch to add eeprom write support
Message-Id: <4dfa50520611220948j1b76e919h1aef304e4359064d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <16475947.1164204132228.JavaMail.root@webmail2.tilbu1>
In-Reply-To: <16475947.1164204132228.JavaMail.root@webmail2.tilbu1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Walter,

I am not the lm-sensors maintainer, so if my comments are helpful in
any way, that's all I'm trying to accomplish.

> +config SENSORS_EEPROM_WRITE
> +  bool "EEPROM Write support (experimental)"
> +  depends on I2C && SENSORS_EEPROM && EXPERIMENTAL
> +  help
> +    If you say yes here you get write access to the EEPROM data. Be
> +    VERY carefull when writing since this driver is designed to work
> +    with chips on memory DIMMs which you will NOT want to destroy!
> +
> +    Even when write support is enabled you will need to unlock it at
> +    runtime to prevent errors. Write UNLOCK to the lock file in the
> +    sys/i2c/devices/<address>/ directory to gain write access. Any
> +    other value will lock write support.

This is confusing, I think. In the code below, the correct unlock
value is "0", not the string "UNLOCK."

> +static ssize_t set_lock(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
> +{
> +  struct i2c_client *client = to_i2c_client(dev);
> +  struct eeprom_data *data = i2c_get_clientdata(client);
> +  unsigned long val = simple_strtoul(buf, NULL, 10);
> +  if (val = 0)
> +  {
> +       data->write_lock = 0;
> +  } else {
> +       data->write_lock = 1;
> +  }
> +  return count;
> +}
> +
> +static DEVICE_ATTR(write_lock, S_IWUSR | S_IRUGO, show_lock, set_lock);
> +
> +#endif //CONFIG_SENSORS_EEPROM_WRITE
> +

David Hubbard

