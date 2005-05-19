From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: adm1026 driver port for kernel 2.6.10-rc2  [RE-REVISED DRIVER]
Message-Id: <20041123185820.5b58ef86.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041102221745.GB18020@penguincomputing.com>
	<NN38qQl1.1099468908.1237810.khali@gcu.info>
	<20041103164354.GB20465@penguincomputing.com>
	<20041118185612.GA20728@penguincomputing.com>
	<1100945635.2639.31.camel@laptop.fenrus.org>
	<20041122194327.GB4698@penguincomputing.com>
In-Reply-To: <20041122194327.GB4698@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Thiessen <jthiessen@penguincomputing.com>, Arjan van de Ven <arjan@infradead.org>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

> > > int adm1026_attach_adapter(struct i2c_adapter *adapter)
> > > {
> > > 	if (!(adapter->class & I2C_CLASS_HWMON)) {
> > > 		return 0;
> > > 	}
> > 
> > no need for extra { }'s in such a case
> 
> Of course there's no _need_.  But I find the result stylistically
> easier to read.  Is there any real objection?

There isn't as far as I can tell. The CodingStyle document doesn't
mention a preference for any form or the other, nor does Greg's talk
about coding style. This means that you are free. If anyone wants it the
other way and is brave enough, he/she can submit an incremental patch
for Greg to consider and see how Greg receives it ;)

> > > static ssize_t show_in(struct device *dev, char *buf, int nr)
> > > {
> > > 	struct adm1026_data *data = adm1026_update_device(dev);
> > > 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]));
> > > }
> > 
> > any chance you could make this use snprintf instead ?
> 
> I'll defer to Jean's response...

And I'll defer to Arjan's myself. As said in another post, no other i2c
client driver does use snprintf. If there is no good reason for them to
do (and actually I don't see any) let's stick to sprintf for everyone.
If there is, then we shall fix all drivers, not only adm1026.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
