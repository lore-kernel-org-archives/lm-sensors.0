From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Sun, 06 Sep 2009 13:55:08 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (abituguru3) Support multiple DMI
Message-Id: <200909061455.08450.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sunday 06 September 2009 13:03:51 Jean Delvare wrote:
> On Sun,  6 Sep 2009 10:15:53 +0100, Alistair John Strachan wrote:
> >  #ifdef CONFIG_DMI
> > -	if (!abituguru3_motherboards[i].dmi_name) {
> > +	if (!abituguru3_motherboards[i].dmi_name[0]) {
> >  		printk(KERN_WARNING ABIT_UGURU3_NAME ": this motherboard was "
> >  			"not detected using DMI. Please send the output of "
> >  			"\"dmidecode\" to the abituguru3 maintainer "
> 
> This test is no longer as perfect as it used to be. Now that you admit
> that each ID can correspond to more than one board model, it is
> possible that the board was _not_ detected using DMI but this message
> will not show (because another board with this ID is already known.)
> While this is not a blocker, I still think it would be worth improving.

You're right. I think the message should go in abituguru3_init() after 
abituguru3_detect() (legacy probing) succeeds. Because..

> Maybe I am missing something obvious, but why isn't this message
> printed in abituguru3_dmi_detect() directly? This would be more
> efficient and more elegant too IMHO.

I don't think it would be correct though. I assume we don't want to print 
anything out if somebody loads the driver on truly unsupported hardware. In 
this case abituguru3_dmi_detect() will fail (rightfully) and then the legacy 
probe method will also fail (hopefully) and modprobe will fail. Nothing would 
be printed.

There's the unfortunate case where DMI match can fail (due to incomplete 
cataloguing of strings) and the legacy probe can also fail (due to it being 
rubbish) and this can also result in no messages being printed for supported 
hardware. However, I don't think there's much we can do about that.

-- 
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
