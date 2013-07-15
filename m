From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 15 Jul 2013 17:13:20 +0000
Subject: Re: [lm-sensors] [PATCH v3 0/2] Enable lm90 in Tegra30 and Tegra114.
Message-Id: <51E42DB0.8090006@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615364-18559-1-git-send-email-wni@nvidia.com> <51E427F1.9010106@wwwdotorg.org>
In-Reply-To: <51E427F1.9010106-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/15/2013 10:48 AM, Stephen Warren wrote:
> On 07/12/2013 01:49 AM, Wei Ni wrote:
>> Enable thermal sensor lm90 for Tegra30 Cardhu and Tegra114 Dalmore.
> 
> I have applied the series to Tegra's for-3.12/dt branch.

Actually, I see the following on Dalmore (although Cardhu works):

[   29.448539] lm90 0-004c: Register 0x4 read failed (-121)
[   29.453930] lm90 0-004c: Failed to read convrate register!
[   29.460034] lm90 0-004c: Register 0x3 read failed (-121)
[   29.465408] lm90 0-004c: Initialization failed!

So, there's something wrong here, and I've dropped the patch for
Dalmore. Does this patch actually work for you?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
