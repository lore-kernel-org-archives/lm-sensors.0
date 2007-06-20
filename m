From: "Arjun Veneshetty" <arjun.veneshetty@patni.com>
Date: Wed, 20 Jun 2007 10:18:51 +0000
Subject: [lm-sensors] help
Message-Id: <200706201003.l5KA39bK001472@pcsnoida.patni.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----------=_1182333793-1496-126"
List-Id: <lm-sensors.vger.kernel.org>
References: <20020728124708.244675c6.nec@chello.hu>
In-Reply-To: <20020728124708.244675c6.nec@chello.hu>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1182333793-1496-126
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 
Please unsubscribe me from this group.

 Arjun Veneshetty

-----Original Message-----
From: lm-sensors-bounces@lm-sensors.org
[mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of
lm-sensors-request@lm-sensors.org
Sent: Wednesday, June 20, 2007 3:30 PM
To: lm-sensors@lm-sensors.org
Subject: lm-sensors Digest, Vol 26, Issue 52

Send lm-sensors mailing list submissions to
	lm-sensors@lm-sensors.org

To subscribe or unsubscribe via the World Wide Web, visit
	http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
or, via email, send a message with subject or body 'help' to
	lm-sensors-request@lm-sensors.org

You can reach the person managing the list at
	lm-sensors-owner@lm-sensors.org

When replying, please edit your Subject line so it is more specific than
"Re: Contents of lm-sensors digest..."


Today's Topics:

   1. Re: initial fintek f71882fg driver, test please (Walt H)


----------------------------------------------------------------------

Message: 1
Date: Tue, 19 Jun 2007 17:47:13 -0500
From: Walt H <walt_h@lorettotel.net>
Subject: Re: [lm-sensors] initial fintek f71882fg driver, test please
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: h_siegel@gmx.de, mgri@zaphod.sax.de, LM Sensors
	<lm-sensors@lm-sensors.org>,	Jacob Heerikhuisen <jacobh@ucr.edu>,
	holger.bocklet@arcor.de
Message-ID: <46785CF1.4010307@lorettotel.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Hans de Goede wrote:
> Hi all,
>
> Here is my first work on a fintek f71882fg driver (also epox 1308). 
> Still todo:
> in1 max, beep and alarm read and write tempX fault read tempX beep and 
> alarm read and write tempX max / crit / hyst writing fanX fault read 
> pwm support
>
> This version should work on non Epox motherboards like MSI too (Thanks 
> Mathias Grimmberger)
>
> To test drop fintek71882 and the Makefile in a dir, type make and then 
> insmod fintek71882.ko
>
> The easiest way to then read the settings is by using the 3.0 sensors 
> branch, which comes with dyn chipsupport:
> remove your current lm-sensors userspace package (for example on 
> Fedora do rpm -e lm_sensors --nodeps) svn checkout 
> http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0
> cd lm-sensors-3.0.0
> make
> sudo make install
> sudo ldconfig
>
>
> I've also attached a sensors.conf for the Epox M1697 motherboard I'm 
> using for testing, modify as needed.
>
>
> Thanks for testing & Regards,
>
> Hans

Compiled and installed fine against a patched 2.6.21 x86_64 kernel .  
Looks good so far.  I'm displaying sensor values through gkrellm and the 
temps and fan values look good.  Vcor1 looks high, and the voltage 
inputs need tweaks under gkrellm, but I'm mainly interested in temp and 
fan values anyway.  Appreciate everybody's work on this!  Thanks,

-Walt





------------------------------

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

End of lm-sensors Digest, Vol 26, Issue 52
******************************************



http://www.patni.com
World-Wide Partnerships. World-Class Solutions.
_____________________________________________________________________

This e-mail message may contain proprietary, confidential or legally
privileged information for the sole use of the person or entity to
whom this message was originally addressed. Any review, e-transmission
dissemination or other use of or taking of any action in reliance upon
this information by persons or entities other than the intended
recipient is prohibited. If you have received this e-mail in error
kindly delete  this e-mail from your records. If it appears that this
mail has been forwarded to you without proper authority, please notify
us immediately at netadmin@patni.com and delete this mail. 
_____________________________________________________________________

------------=_1182333793-1496-126
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------------=_1182333793-1496-126--
