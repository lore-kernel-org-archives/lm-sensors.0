From: Nate Case <ncase@xes-inc.com>
Date: Tue, 24 Jun 2008 20:42:54 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] hwmon: (lm90) Convert some macros
Message-Id: <1214340175.7559.468.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1213989596-8716-2-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1213989596-8716-2-git-send-email-ncase@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2008-06-23 at 19:06 +0200, Jean Delvare wrote:
> This is because you changed temp1_from_reg and temp2_from_reg to
> return
> longs instead of ints. We don't need longs, so the easiest fix is to
> revert that change. If you insist on returning longs then you must
> change %d to %ld in the sprintf calls.

I'll use ints for those and re-submit patch v3.  Thanks.

-- 
Nate Case <ncase@xes-inc.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
