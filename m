From: j.dittmer@portrix.net (Jan Dittmer)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm sensors sysfs file structure
Message-Id: <3E83459A.3090803@portrix.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com>
In-Reply-To: <20030326225234.GA27436@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com

Greg KH wrote:
> That would give us one value per file, use no floating point in the
> kernel (fake or not) and generally make things a whole lot more orderly.
> Also, if a sensor does not have a max value (for example, I don't really
> know if this is true), instead of having to fake a value, it can just
> not create the file.  Then userspace can easily detect this is not
> supported, and is not a placeholder value.
> 

Is this the way you want to go? Just an example for the voltages.

Btw, is it indended behaviour of sysfs, that after writing to a file, 
the size is zero?

ds666:/sys/devices/legacy/i2c-0/i2c_dev_0# echo 100 > in4_min
ds666:/sys/devices/legacy/i2c-0/i2c_dev_0# ls -l in4_min
-rw-r--r--    1 root     root            0 Mar 27 19:18 in4_min


-r--r--r--    1 root     root         4096 Mar 27 19:18 in0_input
-rw-r--r--    1 root     root         4096 Mar 27 19:18 in0_max
-rw-r--r--    1 root     root         4096 Mar 27 19:18 in0_min
-r--r--r--    1 root     root         4096 Mar 27 19:18 in1_input
-rw-r--r--    1 root     root         4096 Mar 27 19:18 in1_max
-rw-r--r--    1 root     root         4096 Mar 27 19:18 in1_min
-r--r--r--    1 root     root         4096 Mar 27 19:18 in2_input
-rw-r--r--    1 root     root         4096 Mar 27 19:18 in2_max
-rw-r--r--    1 root     root         4096 Mar 27 19:18 in2_min
-r--r--r--    1 root     root         4096 Mar 27 19:18 in3_input
-rw-r--r--    1 root     root         4096 Mar 27 19:18 in3_max
-rw-r--r--    1 root     root         4096 Mar 27 19:18 in3_min
-r--r--r--    1 root     root         4096 Mar 27 19:18 in4_input
-rw-r--r--    1 root     root         4096 Mar 27 19:18 in4_max
-rw-r--r--    1 root     root         4096 Mar 27 19:18 in4_min

/* 7 voltage sensors */
static ssize_t show_in(struct device *dev, char *buf, int nr) {
         struct i2c_client *client = to_i2c_client(dev);
         struct via686a_data *data = i2c_get_clientdata(client);
         via686a_update_client(client);
         return sprintf(buf,"%ld\n", IN_FROM_REG(data->in[nr], nr) );
}

static ssize_t show_in_min(struct device *dev, char *buf, int nr) {
         struct i2c_client *client = to_i2c_client(dev);
         struct via686a_data *data = i2c_get_clientdata(client);
         via686a_update_client(client);
         return sprintf(buf,"%ld\n", IN_FROM_REG(data->in_min[nr], nr) );
}

static ssize_t show_in_max(struct device *dev, char *buf, int nr) {
         struct i2c_client *client = to_i2c_client(dev);
         struct via686a_data *data = i2c_get_clientdata(client);
         via686a_update_client(client);
         return sprintf(buf,"%ld\n", IN_FROM_REG(data->in_max[nr], nr) );
}

static ssize_t set_in_min(struct device *dev, const char *buf,
                 size_t count, int nr) {
         struct i2c_client *client = to_i2c_client(dev);
         struct via686a_data *data = i2c_get_clientdata(client);
         unsigned long val = simple_strtoul(buf, NULL, 10);
         data->in_min[nr] = IN_TO_REG(val,nr);
         via686a_write_value(client, VIA686A_REG_IN_MIN(nr),
                         data->in_min[nr]);
         return count;
}
static ssize_t set_in_max(struct device *dev, const char *buf,
                 size_t count, int nr) {
         struct i2c_client *client = to_i2c_client(dev);
         struct via686a_data *data = i2c_get_clientdata(client);
         unsigned long val = simple_strtoul(buf, NULL, 10);
         data->in_max[nr] = IN_TO_REG(val,nr);
         via686a_write_value(client, VIA686A_REG_IN_MAX(nr),
                         data->in_max[nr]);
         return count;
}
#define show_in_offset(offset)                                  \
static ssize_t                                                  \
         show_in##offset (struct device *dev, char *buf)         \
{                                                               \
         return show_in(dev, buf, 0x##offset);                   \
}                                                               \
static ssize_t                                                  \
         show_in##offset##_min (struct device *dev, char *buf)   \
{                                                               \
         return show_in_min(dev, buf, 0x##offset);               \
}                                                               \
static ssize_t                                                  \
         show_in##offset##_max (struct device *dev, char *buf)   \
{                                                               \
         return show_in_max(dev, buf, 0x##offset);               \
}                                                               \
static ssize_t set_in##offset##_min (struct device *dev,        \
                 const char *buf, size_t count)                  \
{                                                               \
         return set_in_min(dev, buf, count, 0x##offset);         \
}                                                               \
static ssize_t set_in##offset##_max (struct device *dev,        \
                         const char *buf, size_t count)          \
{                                                               \
         return set_in_max(dev, buf, count, 0x##offset);         \
}                                                               \
static DEVICE_ATTR(in##offset##_input,                          \
                 S_IRUGO, show_in##offset, NULL)                 \
static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,         \
                 show_in##offset##_min, set_in##offset##_min)    \
static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,         \
                 show_in##offset##_max, set_in##offset##_max)

show_in_offset(0);
show_in_offset(1);
show_in_offset(2);
show_in_offset(3);
show_in_offset(4);
