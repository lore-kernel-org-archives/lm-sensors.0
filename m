From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: sensord: rrd database and timeslots
Message-Id: <20040501143244.61879c6a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040421222823.GA14256@pc.aurel32.private>
In-Reply-To: <20040421222823.GA14256@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It seems that the points of view on this problem are very different. 
> Some of us say that the values should be averaged, some other says
> they should not.
> 
> That's why I propose a new patch that let the user choice if the
> values are average or not. Please also not that with this patch the
> timeslots are not faked anymore.
> 
> Please give me your comments!

If it works for Mario, it's OK with me (modulo the few trivial comments
I formulated over IRC).

-- 
Jean Delvare
http://khali.linux-fr.org/
