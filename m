From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 08 Jan 2009 12:02:38 +0000
Subject: Re: [lm-sensors] abituguru3: no Abit uGuru3 found
Message-Id: <4965EB5E.8060301@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <49657F3B.3060607@NickAndBarb.net>
In-Reply-To: <49657F3B.3060607@NickAndBarb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Nick Pasich wrote:
> No BIOS update....
> 
> Here's the output from "dmidecode" Attached...
> 

Hmm, nasty. We've got "IP35 Pro(Intel P35-ICH9R)" as identifaction string in 
the driver, and your DMI table has: "IP35 PRO(P35+ICH9R)"

You should be able to work around your problem (for now) by doing this (as root):

modprobe abituguru3 force=1

After that, please do "dmesg" and copy paste the relevant (abituguru related) 
lines in your mail, that will help us diagnose this.

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
