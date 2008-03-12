From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Mar 2008 14:53:04 +0000
Subject: Re: [lm-sensors] General parse error after update to
Message-Id: <20080312155304.23062bcf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080312154121.3e0834ef@kovinek>
In-Reply-To: <20080312154121.3e0834ef@kovinek>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 12 Mar 2008 15:41:21 +0100, David Kovalsky wrote:
> after upgrading to kernel-2.6.24.3-12.fc8 running `sensors' throws
> general parse error. Everything worked fine with
> kernel-2.6.23.15-137.fc8. I'm running Fedora 8 (i386) will the latest
> and greatest updates on Lenovo T60 (with Core 2 Duo).
> 
> My lm-sensors version is lm_sensors-2.10.5-1.fc8.
> 
> I've opened a bug in Red Hat bugzilla, which containts all of the
> details about my configuration. 
> https://bugzilla.redhat.com/show_bug.cgi?idC6767
> 
> Can anyone point me in the right direction? 

Can we please see the output of "strace sensors"?

lm-sensors 2.10.6, which was released a couple days ago, has a fix for:
http://www.lm-sensors.org/ticket/2087
This might be what you need.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
