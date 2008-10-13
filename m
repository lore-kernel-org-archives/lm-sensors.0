From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Oct 2008 10:55:54 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: w83781d: use new style driver
Message-Id: <20081013125554.27a7f1bc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CB7FFA.10202@grandegger.com>
In-Reply-To: <48CB7FFA.10202@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wolfgang,

On Mon, 13 Oct 2008 10:43:05 +0200, Wolfgang Grandegger wrote:
> Jean Delvare wrote:
> > I will send an updated patch set to the lm-sensors list now. This patch
> > set is also available at:
> >   http://jdelvare.pck.nerim.net/sensors/w83781d/
> > Please test these patches as your time permits. If possible, it would
> > be great if you could review them and give me your ack on them, before
> > I push them upstream.
> 
> I just verified the patch series on my embedded PowerPC MPC8344E board
> and it worked fine. Unfortunately I can not test the ISA interface due
> to lack of hardware. Just some nitpicking. In the final w83781d.c I

OK, thanks for reporting. I was able to test the ISA case here and it
worked fine.

> realized redundant labels:
> 
>   static int
>   w83781d_detect_subclients(struct i2c_client *new_client)
>   {
>   ...
>   /* Undo inits in case of errors */
>   ERROR_SC_3:
> 	  i2c_unregister_device(data->lm75[0]);
>   ERROR_SC_2:
>   ERROR_SC_1:
> 	  return err;

That's on purpose, to make the patch smaller / more readable. These
labels suck anyway and we should replace them, so whoever does this in
the future (possibly me) can drop the redundant label at the same time.
If you think the current state is too ugly then I can do that right now
and add a 7th patch to the series.

Did you have time to review the patches? Can I add your Acked-by on
some of them?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
