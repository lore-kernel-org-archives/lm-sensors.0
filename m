From: Jordan Crouse <jordan@cosmicpenguin.net>
Date: Mon, 10 Nov 2008 01:27:53 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <49178E19.9050301@cosmicpenguin.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Rudolf,
> 
> On Sun, 09 Nov 2008 20:56:54 +0100, Rudolf Marek wrote:
>> Thanks for the review. I'm attaching fixed version.
>>
>> Following patch adds warning about wrong CPU temperature readouts on all fam f
>> rev f revision of CPUs.
>>
>> Used switch statement, more code changes follows.
>>
>> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
> 
> I've applied it, thanks. Note that I added a "break" at the end of the
> case 0xf, otherwise it's an invitation to get things wrong in the next
> patch...
> 
>>> If all revision F and later CPUs are affected by the errata and the
>>> temperature reported is never correct, we should simply blacklist these
>>> CPUs. I guess this isn't the case, otherwise you'd have proposed that
>>> we do that long ago.
>> Yes.
>>
>>> If most but not all of these CPUs are affected, then it would make
>>> sense to disable them by default but give the user a chance to still
>>> enable them (using a module parameter.)
>> I tried hard to get this info from AMD. All versions are affected, but some may
>> be fixed/not tested.
>>
>>> If there are more revision F and later CPUs with working thermal
>>> diodes, and working ones can be told from non-working ones based on the
>>> exact revision, we could implement blacklisting and/or whitelisting
>>> base on the revision.
>> The errata is for all revs.
> 
> For what it's worth, Jordan Crouse seems to think that blacklisting on
> a per-revision basis may still work.

I think it can.  A much larger sample would probably need to be taken to 
be completely sure - but I hope that we'll find that the problem is 
deterministic enough for a blacklist.  I think we would agree that a 
blacklist would be the more user friendly solution.

Jordan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
