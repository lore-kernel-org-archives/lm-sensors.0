From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 Jan 2006 04:29:54 +0000
Subject: [lm-sensors] ISA vs. SMBus
Message-Id: <20060119042954.GC17365@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060117083114.7f2e826b.khali@linux-fr.org>
In-Reply-To: <20060117083114.7f2e826b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali at linux-fr.org> [2006-01-17 08:31:14 +0100]:
> After all detections have been done, sensors-detect currently asks the
> user whether he/she prefers ISA access or SMBus access when both are
> possible. This option only makes sense for "hybrid" drivers (lm78,
> w83781d, it87), and only in a few cases (i.e. at least one alias has
> been detected by sensors-detect).
> 
> This question tends to confuse people, precisely due to the fact that
> it is asked unconditionally while most people simply don't need to
> care. Also, I see very little reason why someone would prefer not to
> use the ISA access, given the increased speed and reliability. Thus, I
> propose that we drop this question and assume "ISA" as the answer for
> everyone:
> [...]

FWIW, I agree.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


