From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Wed, 31 Mar 2010 13:27:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Don't load if
Message-Id: <20100331132711.GA17104@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100330132132.GA16657@srcf.ucam.org> <20100330214732.42f488ba@hyperion.delvare> <20100330194835.GA32322@srcf.ucam.org> <20100330223251.76c6b000@hyperion.delvare> <20100330211049.GA1524@srcf.ucam.org> <68676e01003301445v1b3ee070nfc0f0b53716c4740@mail.gmail.com> <20100330215305.GA2220@srcf.ucam.org> <20100331093004.5143415f@hyperion.delvare> <20100331125122.GA16583@srcf.ucam.org> <20100331152500.4b2ef6a0@hyperion.delvare>
In-Reply-To: <20100331152500.4b2ef6a0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Wed, Mar 31, 2010 at 03:25:00PM +0200, Jean Delvare wrote:
> On Wed, 31 Mar 2010 13:51:23 +0100, Matthew Garrett wrote:
> > On Wed, Mar 31, 2010 at 09:30:04AM +0200, Jean Delvare wrote:
> > 
> > > It definitely does. At least on some of the affected boards, no access
> > > to the I/O area in question is done at all as long as the asus_atk0110
> > > driver is not loaded.
> > 
> > You've audited the system management code?
> 
> No, I did not. But you did not review the system management code of all
> computers out there either, and you are still writing kernel code that
> could be broken by it. So what's the point?

If the firmware tells us that a resource range using indexed access is 
reserved, it's not safe to assume that the firmware isn't using it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
