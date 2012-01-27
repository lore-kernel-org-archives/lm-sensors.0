From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Jan 2012 08:32:18 +0000
Subject: Re: [lm-sensors] [PATCH 79/79] hwmon: (it87) Fix vrm value range
Message-Id: <20120127093218.606e6a7e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-80-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-80-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 26 Jan 2012 13:53:03 -0800, Guenter Roeck wrote:
> Doesn't sound good. Worse, recent CPUs don't seem to report the current
> VID in MSR_IA32_PERF_STATUS anymore.

I seem to remember that this register was never officially documented
as holding the VID value. Which is why the coretemp driver doesn't
support it. I'm really not sure what Intel is up to with this, it would
have been very easy and useful to properly implement and document this.

> (...)
> You are right. Obviously 0x00 is just as bad as 0xff.

The problem is that the VRM/VRD specs don't treat 0xff differently from
other codes. So while it looks highly suspicious when you see that, we
can't discard this value at driver level because it _could_ be correct,
according to the spec.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
