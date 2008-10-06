From: "Jean-Marc Spaggiari" <jean-marc@spaggiari.org>
Date: Mon, 06 Oct 2008 17:37:12 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] k8temp add support for family 10h and
Message-Id: <79c9d4530810061037h4db98db7u5df14144dbcc9434@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F7B6.4000901@assembler.cz>
In-Reply-To: <48E3F7B6.4000901@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

I can do as many tests as you want.

I already installed k10temp (
http://alt.nntp2http.com/os/linux/2008/08/3e7de045c54f5cd5b7e563330597ab79.html
) as a test and it's working pretty fine. I have update sensors-detect
to use it.

2008/10/1 Rudolf Marek <r.marek@assembler.cz>:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hello all,
>
> I finally had time to add support to k8temp  for the new family 10h and family
> 11h of CPUs.
>
> The patch adds support for new fam10h and fam11h CPUs (aka Phenom and new 45nm
> CPUs). The patch was tested on K8 fam 0fh revE and revF CPU. I dont know if it
> works at all on new CPUs. Please test. You should see the max temp (always 70C
> and one temperature per CPU). Of course test is on your own risk ;)
>
> Andreas, please is TcontrolMax also 70C for fam 11h CPUs?
>
> The patch needs review too. I tried not to change many things in the driver,
> especially the sensorsp logic, but mine test sempron has -49 at core0 place0,
> which needs to be fixed by another logic which will tell driver what CPU
> temperatures are usable. But maybe this is for another "cleanup" patch. I think
> we really need to get this kind of change to kernel first.
>
> What do you think?
>
> Thanks,
> Rudolf
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iD8DBQFI4/e13J9wPJqZRNURAojeAJ9OCFor1n+sDshe1gkfMOVGa1LlSwCgxEAF
> b7YgrXlA2eC/aWyEsnNwLGg> =wSE1
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
