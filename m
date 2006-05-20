From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 20 May 2006 08:59:32 +0000
Subject: [lm-sensors] [PATCH] OpenCores I2C bus driver
Message-Id: <20060520105932.0713d04b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <874q0n1505.fsf@sleipner.barco.com>
In-Reply-To: <874q0n1505.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

Greg> Unless Jean sent it to me, I'm not taking i2c patches, as he is the
Greg> maintainer and I am merely the conduit to Linus and Andrew.

Peter> Ok, sorry about that - I just saw you were in the To: and Jean just
Peter> CC'ed so I assumed you took it.
Peter> 
Peter> Jean, did you take the patch?

No, I didn't. I was waiting for it to be reviewed (thanks Rudolf!) and
updated accordingly. If you have something ready now, please send the
updated patch here and I'll take it.

Remember that we enjoy having documentation for i2c bus drivers under
Documentation/i2c/busses.

If you are using quilt, please add "QUILT_NO_DIFF_INDEX=1" to your
~/.quiltrc file, this is how Linus wants the patches.

Thanks,
-- 
Jean Delvare

