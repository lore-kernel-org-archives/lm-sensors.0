From: Ben Hutchings <bhutchings@solarflare.com>
Date: Fri, 22 Aug 2008 15:57:57 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] lm87: Restore original configuration
Message-Id: <20080822155756.GS7908@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080820201533.GN7908@solarflare.com>
In-Reply-To: <20080820201533.GN7908@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
[...]
> > @@ -840,12 +842,11 @@ exit:
> >  static void lm87_init_client(struct i2c_client *client)
> >  {
> >  	struct lm87_data *data = i2c_get_clientdata(client);
> > -	u8 config;
> >  
> >  	data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
> > +	data->config = lm87_read_value(client, LM87_REG_CONFIG);
> 
> Would you mind if I add "& 0x6f"? Bits 4 and 7 trigger an action when
> you write to them, and self clear. Thus I think we want to make sure
> that we will never write 1 to them accidentally. It shouldn't make a
> difference in practice, but it feels safer to me that way.
[...]

Sure, that seems reasonable.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
