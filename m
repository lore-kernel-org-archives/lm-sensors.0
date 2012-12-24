From: Chris Verges <kg4ysn@gmail.com>
Date: Mon, 24 Dec 2012 08:49:49 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] lm73: added 'update_interval' attribute
Message-Id: <CAG4_upQO4q76_TFcCSOQrT3_0-LFa7n1smzF0ajJW_3yk0mtLg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356336669-18722-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356336669-18722-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 24, 2012 at 12:11 AM, Chris Verges <kg4ysn@gmail.com> wrote:
> +
> +static ssize_t show_convrate(struct device *dev, struct device_attribute *da,
> +                            char *buf)
> +{
> +       struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +       struct i2c_client *client = to_i2c_client(dev);
> +       uint32_t ctrl;
> +       u8 res_bits = 0;
> +
> +       /* Read existing control value */
> +       ctrl = i2c_smbus_read_byte_data(client, attr->index);
> +       if (ctrl < 0)
> +               return ctrl;
> +
> +       res_bits = (ctrl & ~LM73_CTRL_RES_MASK) >> LM73_CTRL_RES_OFFSET;
> +       return scnprintf(buf, PAGE_SIZE, "%u\n", res_bits);
> +}

1 bug found.  The masking of "res_bits" above is incorrect.  The
offset shift should happen before the "and", and the "and" needs to
drop the "not" concept.  I'll publish another patch after more testing
and any feedback is integrated.

Thanks in advance,
Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
