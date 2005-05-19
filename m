From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: [PATCH 2.6] ADM1030 and Co sensors chips support for 2.6.7-mm1
Message-Id: <200406301454.i5UEsV14042921@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040622195209.77f852a6.alex@alexdalton.org>
In-Reply-To: <20040622195209.77f852a6.alex@alexdalton.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I agree on that point. I will have to re-send the patch updated.

I think you should rather send an additional patch with just the changes,
to be applied after your original patch. It's far easier for the
reviewers. If you send a brand new patch they have to review the whole
thing again, or do a diff against your patches, which is usually hard to
read.

Greg especially cannot "just trust you" and assume that the new patch
is really the old one (which MMH and I reviewed) with the few requested
changes. You could be an evil guy! ;)

Thanks,
Jean Delvare
