From: Himanshu Chauhan <hschauhan@nulltrace.org>
Date: Thu, 06 Oct 2011 04:22:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon class driver registration with a
Message-Id: <20111006041011.GB2125@ubuntu.ubuntu-domain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317834791-2803-1-git-send-email-hschauhan@nulltrace.org>
 <20111005193359.GB26664@kroah.com>
In-Reply-To: <20111005193359.GB26664@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org, lm-sensors@lm-sensors.org

Hi Greg,

> 
> How do you later remove a device created with this new interface?  As it
> is, I think the existing calls will fail, right?
> 
If I have not missed out anything from hwmon_device_unregister(), it shouldn't
fail. Why did you point that out?

-Himanshu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
