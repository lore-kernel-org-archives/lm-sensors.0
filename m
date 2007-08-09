From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 09 Aug 2007 05:53:23 +0000
Subject: Re: [lm-sensors] k8temp, BE-2350 CPU
Message-Id: <46BAABD3.5000103@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Sorry for the delay. I'm CCing the list too please do too.


Alistair John Strachan wrote:
> Hi,
> 
> I've noticed a problem with the k8temp driver on a new BE-2350 processor. It 
> seems the sensors report bogus values on this CPU. This is when it is idling:
> 
> root@joyeuse:~# cat /sys/bus/pci/drivers/k8temp/0000\:00\:18.3/temp*
> -5000
> -5000
> -3000
> 1000
> 
> And this is under load:
> 
> root@joyeuse:~# cat /sys/bus/pci/drivers/k8temp/0000\:00\:18.3/temp*
> 7000
> 12000
> 11000
> 17000
> 
> This is a socket AM2 processor. Any idea what's wrong? Using kernel 
> 2.6.23-rc1, but it's also broken on Debian's 2.6.22.

Hmm perhaps the formula does not work anymore :/ Can you send me output of cat
/proc/cpuinfo?

Or even better output of cpuid utillity?

Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuqvT3J9wPJqZRNURAl22AKCrWdYSRaU7yWQ8W8YXQ6kuMbWzJgCeJfwg
kyqz2BC9CRDjeNY37zDE+8s=Ig1D
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
