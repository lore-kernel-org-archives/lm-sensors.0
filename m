From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Date: Thu, 20 Dec 2007 02:17:02 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <200712200217.03861.carlos@strangeworlds.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071204215154.7f26285e.mikeserv@bmts.com> <200712200045.16899.carlos@strangeworlds.co.uk> <200712192113.22974.el@prans.net>
In-Reply-To: <200712192113.22974.el@prans.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Elvis Pranskevichus <el@prans.net>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Jean Delvare <khali@linux-fr.org>, Shaohua Li <shaohua.li@intel.com>, Mike Houston <mikeserv@bmts.com>, Adrian Bunk <bunk@stusta.de>, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Adam Belay <ambx1@neo.rr.com>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Thursday 20 December 2007 02:13:22 Elvis Pranskevichus wrote:
> Hi Carlos,
>
> I've attached the DSDT for Gigabyte GA-965G-DS3 (rev 1.0, bios rev. F9) to
> bugzilla entry #9514:
>
> http://bugzilla.kernel.org/attachment.cgi?id132

A quick look over the DSDT shows that there is no ACPI-WMI mapper device 
(PNP0C14) on this board; so WMI is, at least in this case, not the solution 
to this bug.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
