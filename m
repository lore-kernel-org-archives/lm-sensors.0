From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Mar 2010 13:37:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Don't load if ACPI
Message-Id: <20100331153719.5c700763@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100330132132.GA16657@srcf.ucam.org>
	<20100330214732.42f488ba@hyperion.delvare>
	<20100330194835.GA32322@srcf.ucam.org>
	<20100330223251.76c6b000@hyperion.delvare>
	<20100330211049.GA1524@srcf.ucam.org>
	<68676e01003301445v1b3ee070nfc0f0b53716c4740@mail.gmail.com>
	<20100330215305.GA2220@srcf.ucam.org>
	<20100331093004.5143415f@hyperion.delvare>
	<20100331125122.GA16583@srcf.ucam.org>
	<20100331152500.4b2ef6a0@hyperion.delvare>
	<20100331132711.GA17104@srcf.ucam.org>
In-Reply-To: <20100331132711.GA17104@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Wed, 31 Mar 2010 14:27:11 +0100, Matthew Garrett wrote:
> If the firmware tells us that a resource range using indexed access is 
> reserved, it's not safe to assume that the firmware isn't using it.

Whether it is safe of not is irrelevant. The user is telling us he/she
_will_ use it nevertheless. So what is wrong with doing our best to
avoid problems?

The user paid for the hardware, and firmwares are often crappy. You
know that better than anyone else, having worked on ACPI for some time
now. 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
