From: waltergoossens@home.nl (Walter Goossens)
Date: Wed, 22 Nov 2006 22:45:46 +0000
Subject: [lm-sensors] RFC patch to add eeprom write support
Message-Id: <4564D31A.20209@home.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <16475947.1164204132228.JavaMail.root@webmail2.tilbu1>
In-Reply-To: <16475947.1164204132228.JavaMail.root@webmail2.tilbu1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David
> Hi Walter,
>
> I am not the lm-sensors maintainer, so if my comments are helpful in
> any way, that's all I'm trying to accomplish.
>
All suggestions are welcome!! (espacially this one)
>> +config SENSORS_EEPROM_WRITE
>> +  bool "EEPROM Write support (experimental)"
>> +  depends on I2C && SENSORS_EEPROM && EXPERIMENTAL
>> +  help
>> +    If you say yes here you get write access to the EEPROM data. Be
>> +    VERY carefull when writing since this driver is designed to work
>> +    with chips on memory DIMMs which you will NOT want to destroy!
>> +
>> +    Even when write support is enabled you will need to unlock it at
>> +    runtime to prevent errors. Write UNLOCK to the lock file in the
>> +    sys/i2c/devices/<address>/ directory to gain write access. Any
>> +    other value will lock write support.
>
> This is confusing, I think. In the code below, the correct unlock
> value is "0", not the string "UNLOCK."
>
It's not confusing. It's wrong.
I was planning to use the UNLOCK word but looking at other drivers I 
concluded I'd better use a 1 or 0 to keep in line with them. Of cource I 
forgot to change the kconfig file when I changed my source...
I will fix this and resend the patch next week when I'm  back at my work.
>> +static ssize_t set_lock(struct device *dev, struct device_attribute 
>> *attr, const char *buf, size_t count)
>> +{
>> +  struct i2c_client *client = to_i2c_client(dev);
>> +  struct eeprom_data *data = i2c_get_clientdata(client);
>> +  unsigned long val = simple_strtoul(buf, NULL, 10);
>> +  if (val = 0)
>> +  {
>> +       data->write_lock = 0;
>> +  } else {
>> +       data->write_lock = 1;
>> +  }
>> +  return count;
>> +}
>> +
>> +static DEVICE_ATTR(write_lock, S_IWUSR | S_IRUGO, show_lock, set_lock);
>> +
>> +#endif //CONFIG_SENSORS_EEPROM_WRITE
>> +
>
> David Hubbard
>


