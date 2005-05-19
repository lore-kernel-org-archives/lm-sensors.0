From: b-gruber@gmx.de (Berni)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors && bt869
Message-Id: <1147226401.20040101132806@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031228153744.49065c91.khali@linux-fr.org>
In-Reply-To: <20031228153744.49065c91.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean Delvare,

>> 6. switch_output_format : 2=RGB, 1=SVIDEO, 0=Composite

JD> Using "format" is a bit confusing IMHO. What about "output_source"? (Oh
JD> well this is maybe even more confusing...)

Perhaps output_mode ?

JD> As a general rule, you don't want to prepend the action to the file
JD> names.

Sorry, I didn't know that.

JD> Well, without the hardware I probably won't help much - and I don't
JD> really plan to read the full data sheet ;) Don't know what to do with
JD> these. If it's not a "public" think, we don't care much, except that it
JD> might conflict with something else someday... Do as you want. If it's
JD> not widely used, this also mean we can change it later if needed.

When I tried it in the past (with a 2.4 kernel) it gave out quite
strange results. I think I'll name it bt869_status[1-3] so that it
doesn't interfere. OK?

Bernhard Gruber
