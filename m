From: j.dittmer@portrix.net (Jan Dittmer)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm sensors sysfs file structure
Message-Id: <3E833D90.4050104@portrix.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E82D678.9000807@portrix.net> <20030327172516.GA32667@kroah.com>
In-Reply-To: <20030327172516.GA32667@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com

Greg KH wrote:
>>If we're restructuring it, I think we should also agree on _one_ common 
>>denominator for all values ie. mVolt and milli-Degree Celsius, so that 
>>no userspace program ever again has know how to convert them to 
>>user-readable values and every user can just cat the values and doesn't 
>>have to wonder if it's centi-Volt, milli-Volt, centi-Degree, dezi-Degree 
>>or whatever.
> 
> 
> Um, that's what my proposal stated.  Do you not agree with it?  (You're
> quoting the existing document above, not my proposed changes.)


I just wanted to emphasis that _all_ units should be milli oder centi. 
Not mixing centiDegrees and milliVolts or one driver using milliVolt and 
another centiVolt.
 From your description it could well be, that one driver uses centi's 
and another milli's, both for voltage or one driver uses milliVolt but 
centi-degree.

Thanks,

Jan
