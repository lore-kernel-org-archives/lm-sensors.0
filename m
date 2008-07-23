From: Achim Gottinger <achim@ag-web.biz>
Date: Wed, 23 Jul 2008 11:38:20 +0000
Subject: Re: [lm-sensors] AMD Phenom temperature driver
Message-Id: <4887182C.3030100@ag-web.biz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4881063D.60906@assembler.cz>
In-Reply-To: <4881063D.60906@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek schrieb:
> Hello all,
>
> I think I put all parties up in CC. Thanks to Andreas, I have received 
> missing information about the TControlMax temperature. It means we can 
> get further to a new driver.
>
> I did some experimental driver which works fine (attached as k8temp.c) 
> Kryzstof Went even further and made changes to original k8temp driver.
>
> I will go for vacation soonish (middle of next week) and I'm very 
> busy, but at least we can start. I will write a short list of things 
> which needs to be discussed in the meanwhile:
>
> 1) driver name
>
> AMD proposes the change to amdtemp (from k8temp) I think we can merge 
> the drivers together, it should be still simple.
>
> Jean, please do you remember how autoloading/driver name change is 
> handled in the kernel? I have some feeling that it should be simple to 
> handle. Please confirm.
>
> The name change can be done if we know that old name will work, so we 
> dont break too much things around.
>
> 2) Maximum temperature.
>
> The new Phenom temperature is non-physical it means we must know the 
> limit so we know when we cross it.
>
> Therefore our new driver must export either temp1_max or temp1_crit. 
> The TcontrolMax is for all fam 10h CPUs 70 degrees.
>
> The Intel driver has temp1_max as maximum temperature from which all 
> fans must start cooling. The temp1_crit is when the CPU will fail.
>
> I think the thremtrip_l is asserted for much higher temperatures, I 
> think we can go for temp1_max.
>
> We can put the TcontrolMax into a variable, because for future 
> revisions we may need cpuid to put there right value.
>
> 3) Errata #319
>
> I think all CPU revisions still may have problem with the temp sensor 
> inside the CPU (not the diode interface which is analog and works fine).
>
> Please can someone test mine k8temp.c attached, and report back the 
> values you got? If we detect a CPU with the errata we should print a 
> warning to syslog.
Hi Rudolf,

I tried your attached code  with an 9950BE and the temps reported look 
equal to those everest reports under winxp 32bit with similar load 
conditions. I have a few other phenoms here and will report if i find 
one whos affected by the errata.

achim~


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
