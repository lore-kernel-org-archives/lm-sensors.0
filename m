From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Jan 2009 17:09:43 +0000
Subject: Re: [lm-sensors] abituguru3: no Abit uGuru3 found
Message-Id: <20090108180943.1922daf0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49657F3B.3060607@NickAndBarb.net>
In-Reply-To: <49657F3B.3060607@NickAndBarb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 08 Jan 2009 13:02:38 +0100, Hans de Goede wrote:
> Nick Pasich wrote:
> > No BIOS update....
> > 
> > Here's the output from "dmidecode" Attached...
> > 
> 
> Hmm, nasty. We've got "IP35 Pro(Intel P35-ICH9R)" as identifaction string in 
> the driver, and your DMI table has: "IP35 PRO(P35+ICH9R)"
> 
> You should be able to work around your problem (for now) by doing this (as root):
> 
> modprobe abituguru3 force=1
> 
> After that, please do "dmesg" and copy paste the relevant (abituguru related) 
> lines in your mail, that will help us diagnose this.

Might be worth reading this discussion thread again:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-October/024522.html

We gave up on fixing it back then, but apparently there really is a
need. Alistair, do you have a patch?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
