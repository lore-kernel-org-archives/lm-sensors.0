From: Robert Hancock <hancockrwd@gmail.com>
Date: Fri, 11 Dec 2009 23:58:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for intel PCI thermal
Message-Id: <4B22DCBB.7040701@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1260546750-6206-1-git-send-email-mjg@redhat.com>	 <68676e00912110828q26e511edt52546f09490c9431@mail.gmail.com>	 <20091211163328.GA1596@srcf.ucam.org>	 <68676e00912110836p278985cfv3d052e16a22916b1@mail.gmail.com>	 <20091211163822.GA1869@srcf.ucam.org>	 <68676e00912110847o3594931etf6e045340043e2c6@mail.gmail.com>	 <20091211165004.GA2156@srcf.ucam.org> <68676e00912110858i1cb8f7aclc8e7802840b6f84e@mail.gmail.com>
In-Reply-To: <68676e00912110858i1cb8f7aclc8e7802840b6f84e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 12/11/2009 10:58 AM, Luca Tettamanti wrote:
> On Fri, Dec 11, 2009 at 5:50 PM, Matthew Garrett<mjg59@srcf.ucam.org>  wrote:
>> On Fri, Dec 11, 2009 at 05:47:29PM +0100, Luca Tettamanti wrote:
>>> Sorry, I think we're not understanding each other :)
>>> Does the PCH samples the values directly from the probes? Or is it an
>>> interface for the real monitoring chip (most likely the superio chip)?
>>> In the latter case it might be possible to access directly the
>>> monitoring hardware using another driver (e.g. w83627ehf, lm80, etc.),
>>> thus racing against the PCI driver.
>>> Did I make myself clear?
>>
>> I don't think there's any other chip. On systems using external chips,
>> this PCI device will simply be disabled by the BIOS before the OS boots.
>
> Ok, good.
> The other potential issue is asus_atk0110 driver; ASUS boards have a
> ACPI interface to the hwmon stuff.
> Will check with my testers.

Well, on my P7P55D PRO board, this PCI device does not show up. I assume 
the BIOS disables it because the board uses its own monitoring hardware.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
