From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <200407020916.i629GA0a049649@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>Because extended family is used iff ( read as if and only if) family is
>fixed to 0xF. So I think it is safe.

OK... They are stupid, they are wasting their numbering space by doing
that.

>I can use numbers later. Only tell me VRM_INTEL_8x should be which ?

82.

(our code does the same for 8.1, 8.2 and 8.3 if I remember correctly, and
8,4 is compatible)

>Also we dont have any number for itanums for example...

We will have to find one. If none we have to pick an arbitrary number,
much like was done for AMD. If possible, pick one which makes some sense
and is not likely to be needed later (i.e. < 80).

Thanks,
Jean Delvare
