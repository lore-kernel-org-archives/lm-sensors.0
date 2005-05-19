From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <Pine.LNX.4.58.0407021229300.26054@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Yes, use 100. That's already what MDS did if I'm not mistaking.

done

> Yes, it's definitely compile-time stuff. You compile for a given
> architecture anyway! So what you did is fine.

Ok in attach, version that can be used for testing. It is using the
numerical VRM, "while" instead of "for" in lookup func and other changes
proposed by you. I think this is the end of email storm :)


Regards

Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cpuidvrm2.c
Type: text/x-csrc
Size: 2232 bytes
Desc: all your base are belong to us :)
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040702/866c3cf6/cpuidvrm2.bin
