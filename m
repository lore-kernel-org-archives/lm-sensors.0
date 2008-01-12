From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Jan 2008 09:56:58 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <20080112105658.6fb3995f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <fa.QPUBl9Xd2PDsImgWn6hbR+ShV1U@ifi.uio.no>
	<fa.ri5Klmu4+MwjYC8x5nSms+xKXfI@ifi.uio.no>
	<fa.B/J+j9kGGZ1+gW9FrfHky+cj0Eo@ifi.uio.no>
	<fa.Xv3BmMxnCGLOeEijySte5mKDO5k@ifi.uio.no>
	<4769C0E2.4000500@shaw.ca>
In-Reply-To: <4769C0E2.4000500@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Hancock <hancockr@shaw.ca>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Shaohua Li <shaohua.li@intel.com>, Mike Houston <mikeserv@bmts.com>, Adrian Bunk <bunk@stusta.de>, Elvis Pranskevichus <el@prans.net>, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Adam Belay <ambx1@neo.rr.com>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org

Hi Robert,

On Wed, 19 Dec 2007 19:09:54 -0600, Robert Hancock wrote:
> It's quite possible that the BIOS accesses the device either from ACPI 
> AML or possibly even from SMI. In that case it would be quite reasonable 
> for the BIOS to reserve that region to prevent another driver from 
> loading and trying to take conflicting control of the device. One has to 
> be careful before assuming that any such reservation is bogus.

Again I am all for honoring such BIOS requests so as to prevent
conflicts between ACPI or SMI and native drivers. The problem is that
no two BIOS out there do the same in this respect. I couldn't see any
correlation between machines declaring their hwmon device in PNP and
machines where ACPI or SMI access the device in question. Many boards
declare their device and seemingly never touch it so it's fine for
Linux to drive them. Some boards no not declare the devices but still
access them in our back.

Thomas' patches should deal with the ACPI AML case in most cases, but
not with SMI.

So either the PNP code in Linux isn't exporting enough details to
differentiate, or even the PNP code has no way to tell these cases
apart. In the latter case there's not much we can do. In the former
case, let's have the PNP code export the information so that hwmon
drivers can decide whether they should bind to the devices or not by
default.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
