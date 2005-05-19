From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: max1619
Message-Id: <20040527194515.04c995e8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405211303.18083.fishor@gmx.net>
In-Reply-To: <200405211303.18083.fishor@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > +show_temp(temp_input1, TEMP_FROM_REG);
> > +show_temp(temp_input2, TEMP_FROM_REG);
> > +show_temp(temp_low2, TEMP_FROM_REG);
> > +show_temp(temp_high2, TEMP_FROM_REG);
> > +show_temp(temp_crit2, TEMP_FROM_REG);
> > +show_temp(temp_hyst2, TEMP_FROM_REG);
> >
> > TEMP_FROM_REG doesn't have to be passed by parameter, since it's
> > always the same.
> 
> Jaen, I'm not sure what you mean. If you about "temp_hyst2", in these
> driverer  hyst is chenchebl, not always the same.

What I mean is that you could avoid passing the converter as a
parameter:

+#define show_temp(value) \
+static ssize_t show_##value(struct device *dev, char *buf) \
+{ \
+	struct max1619_data *data = max1619_update_device(dev); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
+}
+show_temp(temp_input1);
+show_temp(temp_input2);
+show_temp(temp_low2);
+show_temp(temp_high2);
+show_temp(temp_crit2);
+show_temp(temp_hyst2);

Because all the files use the same converter (TEMP_FROM_REG).

> Actioly i dont know who is Greg. Am i can finde his Email in
> documentation ?

Greg Kroah-Hartman (aka Greg KH) is the person responsible (among
several over things) of the I2C subsystem in Linux 2.6. He was in CC: in
my previous post. And yes, you will find his contact information several
times in both CREDITS and MAINTAINERS files.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
