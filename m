From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 13 Feb 2014 11:58:12 +0000
Subject: Re: [lm-sensors] [RFC PATCH] hwmon: (max6650) Convert to be a platform driver
Message-Id: <20140213125812.7ce5d0c9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392281438-31836-1-git-send-email-lpapp@kde.org>
	<20140213095817.GD32508@lee--X1>
	<20140213111530.2a2b4982@endymion.delvare>
	<20140213111607.GK32508@lee--X1>
In-Reply-To: <20140213111607.GK32508@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Laszlo Papp <lpapp@kde.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Lee,

On Thu, 13 Feb 2014 11:16:07 +0000, Lee Jones wrote:
> On Thu, 13 Feb 2014, Jean Delvare wrote:
> > Guenter just did:
> > 
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2014-February/041224.html
> 
> Nice, FWIW:
>   Acked-by: Lee Jones <lee.jones@linaro.org>  
> 
> > Any change to the max6650 driver should go on top of his patch series
> > to avoid conflicts:
> > 
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2014-February/041223.html
> 
> Do you have a tree Laszlo can rebase on top of?

Now that the patches have my Reviewed-by and your Acked-by, I believe
Guenter will add them shortly to:

http://git.kernel.org/cgit/linux/kernel/git/groeck/linux-staging.git/log/?h=hwmon-staging

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
