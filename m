From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 03 Jun 2005 21:46:27 +0000
Subject: [lm-sensors] Re: RFC PATCH I2C: w83781d: remove non-i2c sensor chips
Message-Id: <20050603214632.284070a6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <bulu915hhnr8oj5orjq2p5i53ublc3b6gu@4ax.com>
In-Reply-To: <bulu915hhnr8oj5orjq2p5i53ublc3b6gu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> This patch removes non-i2c w83697hf, w83627thf sensor chips from the 
> w83781d driver.  Compile tested.
> 
> Also remove references to those sensor chips in w83781d docs.

Great, except for:

> -	}
> -	
> +

Please avoid this "noise" change (same holds for all future patches, of
course).

> -	if (kind != w83697hf)
> -		device_create_file_vid(new_client);
> +	device_create_file_vid(new_client);
>  
> -	if (kind != w83697hf)
> -		device_create_file_vrm(new_client);
> +	device_create_file_vrm(new_client);

You could additionally remove the blank line in between, as vid and vrm
are tightly linked.

All the rest is OK, good work.

-- 
Jean Delvare
