From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Oct 2007 08:51:50 +0000
Subject: Re: [lm-sensors] What todo with driver entry in sensors-detect for
Message-Id: <20071020105150.6cf61ae2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47187757.3000308@hhs.nl>
In-Reply-To: <47187757.3000308@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 19 Oct 2007 15:15:05 +0200, Hans de Goede wrote:
> I've changed sensors-detect so that it will only advice the use of the fschmd 
> driver for chips with alternatives when the running kernel >= 2.6.24 and I've 
> made sensors-detect identical in both branches again.

OK, great. I've made some cleanups on top of that, I hope you don't mind:
* Renamed the arrays to something clearer.
* Moved fscscy to the standard 2.4 vs. 2.6 arrays.

Please also remember to add a line to CHANGES when doing non-trivial
changes.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
