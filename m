From: Borislav Petkov <bp@suse.de>
Date: Thu, 14 Aug 2014 22:05:30 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon, k10temp: Add support for F15h M60h
Message-Id: <20140814220530.GD18887@pd.tnic>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408035262-18026-1-git-send-email-aravind.gopalakrishnan@amd.com>
 <20140814201730.GA501@roeck-us.net>
 <53ED1A87.6000400@ladisch.de>
 <20140814210816.GC18887@pd.tnic>
 <53ED30BD.90403@amd.com>
In-Reply-To: <53ED30BD.90403@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.de, rdunlap@infradead.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, dan.carpenter@oracle.com, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 14, 2014 at 04:57:17PM -0500, Aravind Gopalakrishnan wrote:
> Actually I don't need it outside of k10temp as of now (or near future)
> I added it in amd_nb as that was Clemens, Guenter's suggestion on the
> previous version;
> Besides, it made sense as it's an indirect access of NB_SMU register and
> amd_nb seems a good place to put the function in case someone needs it in
> the future.

Then someone can move it then. But until that happens it is pretty
pointless of having the Kconfig dependency just for one small function
with a single user.

> I can move it locally to k10temp and remove the dependency if that's
> more preferable.

Yeah, it looks like a fabricated and not true dependency, which doesn't
make any sense currently.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
