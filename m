From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Winbond W83792D driver
Message-Id: <WNlWKwce.1113206671.9704600.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42461044.3080406@mds.gotdns.com>
In-Reply-To: <42461044.3080406@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> > 3* Your code does *not* free the memory you allocated for subclients
> > when unloading the driver. Please add the necessary code.
>
> I added three lines, please refer to the codes below, Am I right?
>
> static int
> w83792d_detach_client(struct i2c_client *client)
> {
>        int err;
>        struct w83792d_data *data = i2c_get_clientdata(client);
>
>        if ((err = i2c_detach_client(client))) {
>                .../* some codes omitted here! */
>        }
>
>        if (i2c_get_clientdata(client)=NULL) {
>                /* subclients */
>                i2c_detach_client(&(data->lm75[0])); <-- added!
>                i2c_detach_client(&(data->lm75[1])); <-- added!
>                kfree(data->lm75);                   <-- added!
>                kfree(client);
>        } else {
>                /* main client */
>                kfree(i2c_get_clientdata(client));
>        }
>        return 0;
> }

This can't work! By definition if i2c_get_clientdata(client)=NULL, then
data is NULL, so data->lm75 doesn't exit. Also, you would be detaching
subclients more than once if it did work, and freeing memory more than
once too.

You are facing the problem I expected. With your current allocation
model, only the main client can free the memory allocated for
subclients. the problem is that you cannot be sure that the subclients
will be unregistered first, so you can't do that.

I really think you will have to move to a different allocation model. See
asb100 for a good example of how things should be done.

> I meet a problem when load the 792 module after the modification to
> 1*-5*: W83792d 0-002f: Subclient 1 registration at address 0x48 failed.
>
> The 792 modules does not work, does it have something to do with your
> item 6*?
> Do you know how to solve this problem?

This might have been caused by the deregistration problems. If a
subclient wasn't properly unregistered, then it's marked as used until
next reboot. I'd suggest that you change the implementation and try
again. Hopefully the problem will be fixed.

Thanks,
--
Jean Delvare
