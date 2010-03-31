From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Mar 2010 13:25:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Don't load if ACPI
Message-Id: <20100331152500.4b2ef6a0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100309135636.373a40a9@hyperion.delvare>
	<20100330120319.627e8f9a@hyperion.delvare>
	<20100330132132.GA16657@srcf.ucam.org>
	<20100330214732.42f488ba@hyperion.delvare>
	<20100330194835.GA32322@srcf.ucam.org>
	<20100330223251.76c6b000@hyperion.delvare>
	<20100330211049.GA1524@srcf.ucam.org>
	<68676e01003301445v1b3ee070nfc0f0b53716c4740@mail.gmail.com>
	<20100330215305.GA2220@srcf.ucam.org>
	<20100331093004.5143415f@hyperion.delvare>
	<20100331125122.GA16583@srcf.ucam.org>
In-Reply-To: <20100331125122.GA16583@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Wed, 31 Mar 2010 13:51:23 +0100, Matthew Garrett wrote:
> On Wed, Mar 31, 2010 at 09:30:04AM +0200, Jean Delvare wrote:
> 
> > It definitely does. At least on some of the affected boards, no access
> > to the I/O area in question is done at all as long as the asus_atk0110
> > driver is not loaded.
> 
> You've audited the system management code?

No, I did not. But you did not review the system management code of all
computers out there either, and you are still writing kernel code that
could be broken by it. So what's the point?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
