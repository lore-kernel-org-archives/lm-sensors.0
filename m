From: nemesis@icequake.net (Ryan Underwood)
Date: Fri, 17 Nov 2006 18:58:50 +0000
Subject: [lm-sensors] sensord and missing alarms
Message-Id: <20061117185850.GB16208@dbz.icequake.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061110190557.GA25801@dbz.icequake.net>
In-Reply-To: <20061110190557.GA25801@dbz.icequake.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Fri, Nov 17, 2006 at 07:30:30PM +0100, Jean Delvare wrote:
> 
> > So in general, the alarms are useless and the application should simply
> > check the current value against the ranges always?
> 
> In general, alarm flags work as intended and applications can use them.
> Only the W83781D causes trouble, and it's just bad luck that this is
> the chip you are using. So for the W83781D, yes, comparing the readings
> with the limit values is better.

What luck.  Should it be considered a bug that W83781D has alarm
behavior inconsistent with the rest of the sensors?

-- 
Ryan Underwood, <nemesis at icequake.net>

