From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 16:07:58 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fscher-bugfix-read-control.patch
Message-Id: <20070722180758.08b88556@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <469F6DC0.8070401@hhs.nl>
In-Reply-To: <469F6DC0.8070401@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Thu, 19 Jul 2007 15:57:20 +0200, Hans de Goede wrote:
> Here is a small fscher bugfix for 2.6.23 merging, lifted from my other fscher
> work, as requested by Jean. The current driver has a control sysfs attribute,
> which shows the contents of the control register, but the underlying
> global_control value in the data structure currently never gets filled with
> the actual contents of this register.
> 
> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Acked-by: Jean Delvare <khali@linux-fr.org>

Note that the Linux 2.4 driver in the lm-sensors SVN repository has the
same bug, so it should be fixed there too.

While we're here...

static ssize_t set_control(struct i2c_client *client, struct fscher_data *data,
			   const char *buf, size_t count, int nr, int reg)
{
	/* bits 1..7 reserved => mask with 0x01 */  
	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x01;

	mutex_lock(&data->update_lock);
	data->global_control &= ~v;
	fscher_write_value(client, reg, v);
	mutex_unlock(&data->update_lock);
	return count;
}

Is the code above correct? It behaves as if bit 0 was "write 1 to clear"
while the datasheet says this bit is regular read-write, and the Linux
2.4 driver treats it as such.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
