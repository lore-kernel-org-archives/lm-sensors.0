From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Jun 2006 17:28:22 +0000
Subject: [lm-sensors] [PATCH] OpenCores I2C bus driver
Message-Id: <20060606192822.4954e78f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <874q0n1505.fsf@sleipner.barco.com>
In-Reply-To: <874q0n1505.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

> > > #define OCI2C_CMD		4
> > > #define OCI2C_STATUS		4
> 
> Jean> Two registers with the same number? If it's true this deserves a
> Jean> comment, methinks.
> 
> Yes, comment added in patch below.
> 
>  >> static struct i2c_adapter ocores_adapter = {
>  >> .owner		= THIS_MODULE,
>  >> .name		= "i2c-ocores",
>  >> .class		= I2C_CLASS_HWMON,
>  >> .algo		= &ocores_algorithm,
>  >> .timeout	= 2,
>  >> .retries	= 1,
>  >> };
> 
>  Jean> Why define .timeout and .retries if you don't use them in your driver?
> 
> Sorry, I guess that was a case of too much cut'n'paste - fixed below.
> 
>  Jean> Last, I would like you to become the maintainer for this new driver if
>  Jean> you feel like it. If you accept, please send a patch to MAINTAINERS and
>  Jean> I'll apply it.
> 
> Added below.
> 
> Signed-off-by: Peter Korsgaard <jacmet at sunsite.dk>
> ---
>  MAINTAINERS                     |    6 ++++++
>  drivers/i2c/busses/i2c-ocores.c |    6 ++----
>  2 files changed, 8 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Jean Delvare

