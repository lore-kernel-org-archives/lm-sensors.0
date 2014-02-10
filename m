From: linux@roeck-us.net
Date: Mon, 10 Feb 2014 16:53:46 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6650) Rename the device ids to contain the hwmon suffix
Message-Id: <20140210105346.14592yef0najhyio@67.228.131.205>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392045953-26596-1-git-send-email-lpapp@kde.org>
 <20140210160842.GB26997@lee--X1> <20140210173811.04ba5964@endymion.delvare>
In-Reply-To: <20140210173811.04ba5964@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: Lee Jones <lee.jones@linaro.org>, Laszlo Papp <lpapp@kde.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Quoting Jean Delvare <jdelvare@suse.de>:

>
> That being said, going with MFD in this case seems quite overkill to
> me. MFD makes a lot of sense when each function has its own resources.
> As this isn't the case here, a single driver registering both an hwmon
> interface and a pinctrl interface would seem sufficient to me. But I
> think Guenter already discussed this in the past so I'll let him
> continue and decide.
>

That is what I had suggested as well (though we were talking gpio
at the time). Laszlo didn't want to do it this way for some reason.
Right now I don't really have an idea what to do.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
