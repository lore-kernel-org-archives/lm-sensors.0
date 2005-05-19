From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [PATCH] i2c driver changes for 2.5.72
Message-Id: <20030624035657.GE10891@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <10559607053930@kroah.com>
In-Reply-To: <10559607053930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark M. Hoffman <mhoffman@lightlink.com> [2003-06-23 23:32:39 -0400]:
(replying to himself again...)

> 
> > @@ -1070,8 +1062,6 @@
> >  	struct lm85_data *data = i2c_get_clientdata(client);
> >  	int i;
> >  
> > -	down(&data->update_lock);
> > -
> >  	if ( !data->valid ||
> >  	     (jiffies - data->last_reading > LM85_DATA_INTERVAL ) ) {
> >  		/* Things that change quickly */
> > @@ -1209,8 +1199,6 @@
> >  	};  /* last_config */
> >  
> >  	data->valid = 1;
> > -
> > -	up(&data->update_lock);
> >  }
> 
> We only want to service one update_client() call per some interval.
> I think this lock needs to stay.

If this one stays then the one you added in lm85_read_value() must go.
Anyway, the latter causes the update_lock to be used before it's
initialized - lines 779-780 in lm85_detect().

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
