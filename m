From: Robert Hancock <hancockr@shaw.ca>
Date: Thu, 20 Dec 2007 01:09:54 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <4769C0E2.4000500@shaw.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <fa.QPUBl9Xd2PDsImgWn6hbR+ShV1U@ifi.uio.no>
 <fa.ri5Klmu4+MwjYC8x5nSms+xKXfI@ifi.uio.no>
 <fa.B/J+j9kGGZ1+gW9FrfHky+cj0Eo@ifi.uio.no>
 <fa.Xv3BmMxnCGLOeEijySte5mKDO5k@ifi.uio.no>
In-Reply-To: <fa.Xv3BmMxnCGLOeEijySte5mKDO5k@ifi.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Jean Delvare <khali@linux-fr.org>, Shaohua Li <shaohua.li@intel.com>, Mike Houston <mikeserv@bmts.com>, Adrian Bunk <bunk@stusta.de>, Elvis Pranskevichus <el@prans.net>, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Adam Belay <ambx1@neo.rr.com>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org

Carlos Corbacho wrote:
> On Thursday 20 December 2007 00:20:21 Bjorn Helgaas wrote:
>> I suspect the manufacturers would say "Oh, the sensors?  The BIOS
>> isn't broken, you're just supposed to use WMI or some (undocumented)
>> ACPI device to get at those."
> 
> It's quite possible - can we have DSDTs for the boards in question so we can 
> quickly check if this is a possibility? (Basically, to see if they have 
> PNP0C14 devices - if they don't, then I'm afraid it's nothing to do with 
> WMI).
> 
> -Carlos

It's quite possible that the BIOS accesses the device either from ACPI 
AML or possibly even from SMI. In that case it would be quite reasonable 
for the BIOS to reserve that region to prevent another driver from 
loading and trying to take conflicting control of the device. One has to 
be careful before assuming that any such reservation is bogus.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
