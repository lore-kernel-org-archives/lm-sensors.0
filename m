From: =?iso-8859-1?Q?Hector_Lahoz_Gra=F1ena?= <hectorlahoz@yahoo.es>
Date: Wed, 03 Sep 2008 00:19:30 +0000
Subject: Re: [lm-sensors] plans to implement Smartguardian support on it87
Message-Id: <65091.86556.qm@web26406.mail.ukl.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <732978.84919.qm@web26404.mail.ukl.yahoo.com>
In-Reply-To: <732978.84919.qm@web26404.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 02, 2008 at 10:29:22AM -0400, Frank Myhr wrote:
> 
> Hi Hector,
> 
> I've been working to add automatic fan mode to the it87 driver. It works on the
> it8718, but I'm still changing the sysfs interface, and adding auto mode support
> for the other it87 chips. I'll post the code to this list when ready. It would
> be great if you could help test it on your it8705_v2, I don't have one here.
>
Of course

> Auto mode varies a bit from chip to chip, and for the 8705, for different
> versions of the chip*. For your it8705_v2, auto mode allows 5 discrete fan
> speeds: off, low, medium, high, and all fans full speed.
Yes. It's a little bit annoying and not very smart.

> You could get smoother
> control by using the software pwm mode you already have working along with the
> lm_sensors fancontrol script.
>
The script works fine. Sometimes you've got it just before your nose...
Thanks a lot for your help


      

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
