From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: [PATCH 2.6] New chip driver: pcf8591
Message-Id: <20040409214207.731d2648.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040328160717.GA32728@pc.aurel32.private>
In-Reply-To: <20040328160717.GA32728@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Sorry for the delay, this has now been applied, along with a few
> formatting changes, and one bugfix:
> 
> > +static ssize_t set_out0_output(struct device *dev, const char *buf,
> > size_t count)+{
> > +	unsigned int value;
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct pcf8591_data *data = i2c_get_clientdata(client);
> > +	if ((value = (simple_strtoul(buf, NULL, 10) + 5) / 10) <= 255);
> > +	{
> > +		data->aout = value;
> > +		i2c_smbus_write_byte_data(client, data->control, data->aout);
> > +	}
> > +	return count;
> > +}
> 
> I fixed that if statement above (you really didn't want that ';'
> there, right?

OMG, we missed that...

Nice catching Greg! :)

BTW, wouldn't a "else return -1" make sense here? Silently ignoring
errors doesn't sound good to me.

Sorry for not noticing this before.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
