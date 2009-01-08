From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 08 Jan 2009 22:22:53 +0000
Subject: Re: [lm-sensors] abituguru3: no Abit uGuru3 found
Message-Id: <49667CBD.4020105@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <49657F3B.3060607@NickAndBarb.net>
In-Reply-To: <49657F3B.3060607@NickAndBarb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Nick Pasich wrote:
> I applied the patch after applying your 2 other patches:
> 
> 1) "eliminating whitespace"
> 2) "Switch the AW9D-MAX over from port probing to the
>    preferred DMI probe method".
> 
> The patch applied and the module loaded without any problems.
> 
> Syslog Entry:
> Jan 8 10:49:36 localhost kernel: abituguru3: found Abit uGuru3, 
> motherboard ID: 001A
> 

1A is good, that is the same ID as we had for the other DMI string, so it looks 
like we're good to go with Alistair's patch.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
