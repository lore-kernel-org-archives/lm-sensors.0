From: azarah@gentoo.org (Martin Schlemmer)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm sensors sysfs file structure
Message-Id: <1048792523.7569.102.camel@nosferatu.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048582394.4774.7.camel@workshop.saharact.lan>
	 <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>
	 <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com>
	 <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com>
	 <3E83459A.3090803@portrix.net>  <20030327185222.GI32667@kroah.com>
In-Reply-To: <20030327185222.GI32667@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>, KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com

On Thu, 2003-03-27 at 20:52, Greg KH wrote:

> > Is this the way you want to go? Just an example for the voltages.
> 
> That looks very good to me, nice 

While we are at it, some form question.  The w83781d have a
magnitude of files in sysfs if you split them like this, so
I went for the shorter (easier?) way.

This ok, or should I split it up a bit more.  Note that I
have not done much for indentation yet.

------------------------------------------------------
#define show_in_reg(reg) \
static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
{ \
    struct i2c_client *client = to_i2c_client(dev); \
    struct w83781d_data *data = i2c_get_clientdata(client); \
    w83781d_update_client(client); \
     \
    return sprintf(buf,"%ld\n", \
        IN_FROM_REG(data->reg[nr])); \
}
show_in_reg(in);
show_in_reg(in_min);
show_in_reg(in_max);

#define store_in_reg(REG,reg) \
static ssize_t store_##reg (struct device *dev, const char *buf, size_t
count, int nr) \
{ \
    struct i2c_client *client = to_i2c_client(dev); \
    struct w83781d_data *data = i2c_get_clientdata(client); \
    int reg, ret; \
     \
    ret = sscanf(buf, "%d", &reg); \
    if (ret = -1) return -EINVAL; \
    if (ret >= 1) { \
        data->reg[nr] = IN_TO_REG(reg); \
        w83781d_write_value(client, W83781D_REG_IN_##REG(nr),
data->reg[nr]); \
    } \
    return count; \
}
store_in_reg(MIN, in_min);
store_in_reg(MAX, in_max);

#define show_in_offset(offset) \
static ssize_t \
show_in_##offset (struct device *dev, char *buf) \
{ \
        return show_in(dev, buf, 0x##offset); \
} \
static DEVICE_ATTR(in_input##offset, S_IRUGO | S_IWUSR,
show_in_##offset, NULL)

#define show_in_reg_offset(reg,offset) \
static ssize_t show_##reg##offset (struct device *dev, char *buf) \
{ \
    return show_##reg (dev, buf, 0x##offset); \
} \
static ssize_t store_##reg##offset (struct device *dev, const char *buf,
size_t count) \
{ \
    return store_##reg (dev, buf, count, 0x##offset); \
} \
static DEVICE_ATTR(##reg##offset, S_IRUGO| S_IWUSR, show_##reg##offset,
store_##reg##offset)

#define show_in_offsets(offset) \
show_in_offset(offset); \
show_in_reg_offset(in_min, offset); \
show_in_reg_offset(in_max, offset);

show_in_offsets(0);
show_in_offsets(1);
show_in_offsets(2);
show_in_offsets(3);
show_in_offsets(4);
show_in_offsets(5);
show_in_offsets(6);
show_in_offsets(7);
show_in_offsets(8);



-- 

Martin Schlemmer



-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030327/b7e1284f/attachment.bin
