From: Borislav Petkov <bp@suse.de>
Date: Thu, 14 Aug 2014 21:08:16 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon, k10temp: Add support for F15h M60h
Message-Id: <20140814210816.GC18887@pd.tnic>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408035262-18026-1-git-send-email-aravind.gopalakrishnan@amd.com>
 <20140814201730.GA501@roeck-us.net>
 <53ED1A87.6000400@ladisch.de>
In-Reply-To: <53ED1A87.6000400@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>, jdelvare@suse.de, rdunlap@infradead.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, dan.carpenter@oracle.com, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 14, 2014 at 10:22:31PM +0200, Clemens Ladisch wrote:
> >> +	depends on X86 && PCI && AMD_NB
> >
> > Is the added dependency acceptable ?
> 
> Yes, it is automatically set from CPU_SUP_AMD.

Well, we can always move that function to k10temp but I'll venture a
guess that Aravind wants to use it somewhere else too? Correct, Aravind?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
