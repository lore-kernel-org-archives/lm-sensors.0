From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 08 Jan 2009 07:49:26 +0000
Subject: Re: [lm-sensors] abituguru3: no Abit uGuru3 found
Message-Id: <4965B006.6090500@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <49657F3B.3060607@NickAndBarb.net>
In-Reply-To: <49657F3B.3060607@NickAndBarb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Nick Pasich wrote:
> Starting getting this error after upgrading from 2.6.26.2 to 2.6.27.10
> 

Hmm, did you by any chance perhaps also did a BIOS update, BIOS update's are 
known to cause problems (which we know how to fix, but we need to do this on a 
motherboard by motherboard basis).

To fix this we need the output of the command dmidecode (run as root), redirect 
it to a log file:
dmidecode &> log

And attach the log file please.

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
