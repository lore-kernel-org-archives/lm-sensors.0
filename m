From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 05 Dec 2013 13:13:32 +0000
Subject: Re: [lm-sensors] [patch] hwmon: prevent some divide by zeros in FAN_TO_REG()
Message-Id: <20131205131332.GY5443@mwanda>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131205105845.GA23161@elgon.mountain>
In-Reply-To: <20131205105845.GA23161@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Thu, Dec 05, 2013 at 01:06:13PM +0100, Jean Delvare wrote:
> Hi Dan,
> 
> On Thu, 5 Dec 2013 13:58:45 +0300, Dan Carpenter wrote:
> > It's not enough to just test if "rpm" is zero, the "rpm * div" operation
> > could overflow and that could also lead to a divide by zero.
> 
> If you believe an overflow can happen (and indeed it can) then this
> isn't the way to handle it. Avoiding a divide by zero is certainly nice
> but properly handling the other overflow cases too would be better.
> 
> In practice, this means for the vt8231 driver:
> 
> 	if (rpm = 0 || rpm > 1310720)
> 		return 0;
> 
> and for the lm78 and sis5595 drivers:
> 
> 	if (rpm <= 0)
> 		return 255;
> 	if (rpm > 1350000)
> 		return 0;

For these two are you sure the return value shouldn't be 1?

regards,
dan carpenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
