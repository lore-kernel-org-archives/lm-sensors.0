From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <20040703084530.4f515868.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Ok in attach, version that can be used for testing. It is using the
> numerical VRM, "while" instead of "for" in lookup func and other
> changes proposed by you. I think this is the end of email storm :)

Tested.

On my laptop computer it says 85, CPU is an Intel P3-M Tualatin.

On my desktop computer and my girlfriend's computer it says 90, CPU is
AMD Athlon for each.

On my server it says 0, CPU is an Intel Pentium.

So it's working fine for me, isn't it? :)

-- 
Jean Delvare
http://khali.linux-fr.org/
