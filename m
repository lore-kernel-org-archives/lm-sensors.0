From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 25 Sep 2006 21:01:19 +0000
Subject: [lm-sensors] [patch] hwmon: fix unchecked returncodes in w83791d
Message-Id: <20060925230119.17395e77.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060925192533.40929faf.khali@linux-fr.org>
In-Reply-To: <20060925192533.40929faf.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> > > @@ -1029,6 +1054,8 @@ static int w83791d_detach_client(struct 
> > >  	if (data)
> > >  		hwmon_device_unregister(data->class_dev);
> > >  
> > > +	sysfs_remove_group(&client->dev.kobj, &w83791d_group);
> > > +
> > >  	if ((err = i2c_detach_client(client)))
> > >  		return err;
> >
> > The "if (data)" is used to differenciate between the real client and
> > the subclients, exactly as is done in the w83781d driver. As subclients
> > have no files, the call to sysfs_remove_group() should be made
> > conditional as well. If not, it'll still work, but with a significant
> > performance drop.
>
> on this item, I actually checked :-)
> 
>  w83791d_detect will fail unless data is sucessfully allocated,
> so it must be there if detach_client is called.
> 
> but I suppose its safer (less action-at-a-distance) your way, esp wrt 
> any future changes.
> redo attached.

I'm sorry to insist, but you overlooked another function which also
attaches clients: w83791d_create_subclient(). And this one does _not_
associate data to the client. All three clients (one main and two
subclients) have the same driver, so w83791d_detach_client() is called
for all of them. The "if (data)" test is there exactly for this reason,
so this test is really needed.

The new patch looks OK to me, thanks.

-- 
Jean Delvare

