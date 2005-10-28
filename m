From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 28 Oct 2005 00:58:21 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch,
Message-Id: <43615CBD.7030501@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Matt Stamp wrote:
> I am getting an error when trying to insert module and it will not force.
> 
> I get.
> 
> insmod abituguru.ko
> insmod: error inserting 'abituguru.ko' : -1 Unknown symbol in module
> 
> I am using debian unstable with kernel 2.6.13.4.
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

Yes, my mistake (in the docs), you should use kernel 2.6.14rc4 or newer 
2.6.13 is not new enough.

Regards,

Hans
