From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Tue, 27 Dec 2005 23:40:58 +0000
Subject: [lm-sensors] [PATCH] X1205 cleanup
Message-Id: <20051228004058.00acb03b@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051213214058.2781e657@inspiron>
In-Reply-To: <20051213214058.2781e657@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Dec 2005 12:13:56 +0100
Jean Delvare <khali at linux-fr.org> wrote:

> Applying this patch adds the following warnings:
> 
>   CC [M]  drivers/i2c/chips/x1205.o
> drivers/i2c/chips/x1205.c:204: warning: `x1205_set_datetime' defined but not used
> drivers/i2c/chips/x1205.c:284: warning: `x1205_get_dtrim' defined but not used
> drivers/i2c/chips/x1205.c:316: warning: `x1205_get_atrim' defined but not used
> 
> What is the point of your cleanup? As I understand it, the driver is no
> more exporting any functionality to the rest of the kernel. As it has no
> user-space interface either, this means that the only thing the driver
> is useful for is running x1205_hctosys at runtime - and even this only
> happens if the module parameter hctosys has been set, which isn't the
> default.

 This cleanup was in preparation for the new rtc subsystem I'm writing,
 so I thought it was better to leave those functions there.

> Missing space before end of comment.
> 
> > +		buf[CCR_YEAR] = BIN2BCD(tm->tm_year % 100);
> >  		buf[CCR_WDAY] = tm->tm_wday & 0x07;
> > -		buf[CCR_Y2K] = BIN2BCD(data->epoch / 100);
> > +		buf[CCR_Y2K] = BIN2BCD(tm->tm_year / 100);
> >  	}
> 
> Isn't this actually changing what the code does? If so, this isn't
> suitable for a cleanup patch and should be moved to a separate patch
> with proper explanations.

 you're right.. I'll fix it asap. Thanks!


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it


