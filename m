From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Nov 2008 20:54:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081109215439.72aec540@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Sun, 09 Nov 2008 20:56:54 +0100, Rudolf Marek wrote:
> Thanks for the review. I'm attaching fixed version.
>
> Following patch adds warning about wrong CPU temperature readouts on all fam f
> rev f revision of CPUs.
> 
> Used switch statement, more code changes follows.
> 
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

I've applied it, thanks. Note that I added a "break" at the end of the
case 0xf, otherwise it's an invitation to get things wrong in the next
patch...

> > If all revision F and later CPUs are affected by the errata and the
> > temperature reported is never correct, we should simply blacklist these
> > CPUs. I guess this isn't the case, otherwise you'd have proposed that
> > we do that long ago.
> 
> Yes.
> 
> > If most but not all of these CPUs are affected, then it would make
> > sense to disable them by default but give the user a chance to still
> > enable them (using a module parameter.)
> 
> I tried hard to get this info from AMD. All versions are affected, but some may
> be fixed/not tested.
> 
> > If there are more revision F and later CPUs with working thermal
> > diodes, and working ones can be told from non-working ones based on the
> > exact revision, we could implement blacklisting and/or whitelisting
> > base on the revision.
> 
> The errata is for all revs.

For what it's worth, Jordan Crouse seems to think that blacklisting on
a per-revision basis may still work.

> > Does anyone have an idea about the ratio of working/broken revision F
> > and later CPU models?
> 
> Dont sorry.
> 
> > Does the status (broken or not) of the thermal diode depend on the
> > exact CPU revision, or is it purely random?
> 
> Perhaps random.
> 
> > Alternatively, or additionally, we could use a heuristic to detect
> > broken diodes. I don't much like this in general, as monitoring should
> > normally not assume anything on what it is monitoring, but in this
> > specific case I think it makes some sense because the thermal sensor in
> > question is not a generic chip and brokenness is so widely spread.
> 
> I agree. This could work. However I would like to first get the fam 10h and fam
> 11h support in, because otherwise I would need to rewrite the patches again and
> changing lot of at the same time is no good.

I understand.

> So please can you accept the patch as it is now and have a look on second one
> too? I fixed the case indent and we need to write some docs too, but first check
> code.

This second patch is larger, I will try to find some time to review it
but I can't promise anything. Also note that I am not familiar with the
Fam 10h CPUs at all and I don't have any so I can't test the code.

> Andreas can you test please the second patch too? I'm especially curious if you
> see  the high limit when running sensors command.
> 
> Once second patch is in, I would like to rewrite the driver with the help of
> heuristic and put there more generic logic for "place/core" selectors and temp1_
> etc sysfs files creation logic.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
