From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 07 Jun 2006 16:39:01 +0000
Subject: [lm-sensors] [PATCH] Fix the AMD756 SMBus Controller hang
Message-Id: <20060607183901.b89bc7c1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485AD8C.5010906@sh.cvut.cz>
In-Reply-To: <4485AD8C.5010906@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> This patch seems to fix the hang of AMD756 SMBus controller. After certain 
> ammount of bus transactions the controller refused to start new transactions
> and abort was not working. This patch is based on mine and Dieter Jurzitza's 
> investigations.
> 
> Please apply.

> --- linux/drivers/i2c/busses/i2c-amd756.c
> +++ linux/drivers/i2c/busses/i2c-amd756.c
> @@ -121,6 +121,8 @@
>  		inb_p(SMB_HOST_DATA));
>  
>  	/* Make sure the SMBus host is ready to start transmitting */
> +	/* And wait for the SMBus controller to settle down (avoids hang) */
> +	msleep(1);
>  	if ((temp = inw_p(SMB_GLOBAL_STATUS)) & (GS_HST_STS | GS_SMB_STS)) {
>  		dev_dbg(&adap->dev, "SMBus busy (%04x). Waiting...\n", temp);
>  		do {
> 

I don't like it. This is basically doubling the amount of sleep time
for all simple transactions. For HZ0, this means 10 ms of
additional delay per transaction. For an EEPROM dump, this means 5
seconds instead of 2.5 seconds, this makes a big difference. This is
true also for I2C/SMBus hardware monitoring chips with a large number of
registers.

Given that the problem was only reported on one system by one user,
it's quite a high price to pay, don't you think? I'd like this to be
investigated further. Can we find other reports which could be related
to the same problem? If not, why this one system has the problem when
others don't? If we can understand that, maybe we can add the delay
only when it is really needed, this would limit the impact of the
change and make it more acceptable.

Rudolf, I also see that you alreay applied this change to lm_sensors
CVS, with the mention "backport of 2.6". That's not the right way to do
it, sorry. For one thing you can't technically backport something
before it was accepted and applied. For another, non-critical fixes
should really get some broad testing in 2.6 before being actually
backported.

Thanks,
-- 
Jean Delvare

