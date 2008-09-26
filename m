From: Riku Voipio <riku.voipio@movial.fi>
Date: Fri, 26 Sep 2008 08:16:46 +0000
Subject: Re: [lm-sensors] Legal questions regarding LM-sensors....
Message-Id: <48DC9A6E.1090200@movial.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <30B6C5E7EF81EC429436AECD02583340382CBC97@Corpappl054.corp.saab.se>
In-Reply-To: <30B6C5E7EF81EC429436AECD02583340382CBC97@Corpappl054.corp.saab.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hammargren Lukas (Consultant) wrote:
> Hello,
>  
> I have a couple of questions regarding your software (LM-sensors) for 
> hardware monitoring which I hope that you please could give me answers 
> to?
>  
> The questions below:
>  
> * Does LM-Sensors have a assigned ECCN (Export Control Classification 
> Number)?
Debian used to send export notices for all software under ECCN 5D002
(using the TSU exception), including lm-sensors. There might be some more
matching ECCN lm-sensors specifically, but in Debian's case it was merely
easier to notify about everything than to check which software may contain
cryptography or use other cryptographic libraries.

http://lists.debian.org/debian-legal/2007/08/msg00074.html
http://azure.humbug.org.au/~aj/blog/2008/03/07#2008-03-07-10years2

> * Does it contain any chrypto's?
No.

> * Is the country of origin: NL (Netherlands)?
You might want to update your views on how software is developed these days.

I am not a lawyer and nothing I say me be considered legal advice.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
