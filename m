From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 06 Jun 2014 20:36:38 +0000
Subject: Re: [lm-sensors] Driver for PC87372
Message-Id: <20140606223638.461571a5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADxL3QmF1q5wmSX=YCCTUc_BREXp2F4khHKdZPTPPuXFUtjLcg@mail.gmail.com>
In-Reply-To: <CADxL3QmF1q5wmSX=YCCTUc_BREXp2F4khHKdZPTPPuXFUtjLcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mike,

There is no such thing as sensors-detect version 1.1. If you meant
3.1.1 then it's quite old and you may get better results from the
latest version:
  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
It may lack some integration with your distribution though.

Yes, you can modify /etc/sysconfig/lm_sensors manually to add the lm85
driver. The format is very simple so I think you'll get it right
easily. That being said I admit I am surprised that the lm85 driver
works out of the box. Well maybe CentOS 6.4 includes a more recent
version of the lm85 driver backported rather than the version from the
kernel.

Anyway, it doesn't really matter I guess, as long as you got monitoring
working I suppose you're happy :-)

Jean

On Fri, 6 Jun 2014 11:46:53 -0600, Mike Dixon wrote:
> Jean, Guenter,
> 
> Thanks for the feedback. Some more information on my setup: I am running
> CentOS 6.4 / lm_sensors 3.1.1 / sensors detect 1.1. It looks like
> sensors-detect does probe the SMBus by default but in my case did not find
> an LM85 compatible chip. However, I manually loaded the lm85 kernel module
> and that got it working.  So I think I should be able to modify
> /etc/sysconfig/lm_sensors to automatically load the lm85 module on bootup?
> Also it does return temperatures, fan speeds, voltages, etc.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
