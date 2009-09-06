From: Rune Svendsen <runesvend@gmail.com>
Date: Sun, 06 Sep 2009 14:15:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (abituguru3) Support multiple DMI
Message-Id: <1252246558.4371.17.camel@runescomp>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(resending because my mail application apparently removed the CC'd addresses.)

On Sun, 2009-09-06 at 14:03 +0200, Jean Delvare wrote:
[snip]
> >  
> >  
> > @@ -947,7 +951,7 @@ static int __devinit abituguru3_probe(struct platform_device *pdev)
> >  		"ID: %04X\n", (unsigned int)id);
> >  
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
> 
> Maybe I am missing something obvious, but why isn't this message
> printed in abituguru3_dmi_detect() directly? This would be more
> efficient and more elegant too IMHO.

After speaking with Alistair I've been thinking about this as well.
Right now, when I'm running a kernel that doesn't support inserting the
abituguru3 module without using the "force=1" option (a kernel to which
this patch has not been applied), I don't receive a message in my kernel
log about sending the output of "dmidecode" - precisely because of what
you mention here.

I'm thinking that that same rules that decide whether I get to insert
the abituguru3 module into the kernel should decide whether the message
about sending the output of "dmidecode" will appear.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
