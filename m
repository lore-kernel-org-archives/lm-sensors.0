From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: [PATCH] ALI1563 SMBus driver fix
Message-Id: <425C471F.8040006@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050411081712.17417.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050411081712.17417.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg and Jean

I'm very sorry about my patch submitting policy I hope I will improve in future :)

> 
>>+	/* device error - probably missing ACK, from autdetection I2C_QUICK */
>>+	if (data & HST_STS_DEVERR) {
>>+		dev_dbg(&a->dev, "Device error!\n");
>>+	}
> 
> 
> I don't like this. If this "error" is normal for I2C_QUICK, then don't
> issue any message and return 0 in this case, and issue an *error*, not
> debug, message in the other cases.

Yes this will happen when no-one will respond to I2C_QUICK. If we would return 0;
then i2cdetect would have detected all devices as "present"??? (Or am I missing something? Its quite late
here...When someting will respond to I2C QUICK we would leave the routine more to the top)

> 
> As far as I can see, this means adding a second parameter to
> ali1563_transaction, but I don't think this is a problem.

Please can you explain more? Or tomorrow on IRC if you want...

I will remove all noise in future revisions of this patch.

> I'm otherwise fine with your patch, thanks a lot for your great
> investigation work on this.

Thank you, it was nice detective story, so I'm proud that I found all "murders" in our case.
Funny is that I could not take a look to book :)

Before I will create new patch I will send patch to Patrick in extra thread.

Regards

Rudolf
