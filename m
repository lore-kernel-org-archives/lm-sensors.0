From: R Kimber <rkimber@ntlworld.com>
Date: Sat, 23 Jun 2007 14:05:48 +0000
Subject: Re: [lm-sensors] Change in reported CPU temperatures
Message-Id: <20070623150548.e1c705b1.rkimber@ntlworld.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070613223645.40f82f42.rkimber@ntlworld.com>
In-Reply-To: <20070613223645.40f82f42.rkimber@ntlworld.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sat, 23 Jun 2007 14:46:57 +0200
Jean Delvare wrote:

> > Asus M2N-E with amd64x2
> > Ubuntu 7.04
> > lm-sensors 1:2.10.1-2ubuntu2

> > When running Boinc (5.4.11-5) projects on both processors, CPU
> > temperatures were reported as being around 53C.  Idle temperature
> > was around 28C.
> > 
> > However, on 1 June the kernel was upgraded to 2.6.20-16.28 and the
> > reported temperatures immediately dropped to around 38C, without any
> > config changes on my part, or as far as I know a
> > Boinc-manager/client upgrade. Idle temperature remained the same.

> Maybe you should trust both. You seem to assume that the k8temp driver
> was reporting a wrong value, or is now. But maybe it is correct and
> has always been, and your CPU temperature really is different now.
> This could happen if you have a different CPUFreq policy for example
> (or CPUFreq wasn't working on your CPU before and is now.)

That's a good point.  I have no way of knowing whether there was a
change of policy.  If there was, it was nothing I did - that kind of
technicality is out of my league.

> Don't you have another hardware monitoring chip on the board? On an
> Asus M2N-E, I'd really guess so. Probably an ITE or Winbond Super-I/O
> with integrated sensors.

IT8716 reports temp1 as 42C, though I'm not sure what it relates to.

temp2, which I'm pretty sure is the MB, has remained around 34C
throughout.

THRM seems permanently stuck on 40C.  It never ever changes.

> Also, what temperature does the BIOS report? That would be an
> interesting comparison point.

I thought of that, but concluded that there wasn't much point in
looking, since the machine would be effectively idle and it does cool
down very quickly after any load stops. shutting down and rebooting
takes time.

Unless there's a way of reading the BIOS while the machine
is running??

> > I have seen newsgroup comments from two other people both reporting
> > different levels on similar machines !
> 
> "Similar machines" doesn't mean much. There are sooooo many things
> which can affect the temperature of a system, both in hardware and
> software. Every system is different.

By 'similar' I meant the same except theirs is the SLI version.

- Richard
-- 
Richard Kimber
http://www.psr.keele.ac.uk/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
