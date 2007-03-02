From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 02 Mar 2007 21:00:52 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070302220052.f93f3976.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
	<45D6DDCE.5050803@assembler.cz>
	<45D7461A.2040808@redhat.com>
	<20070218183805.5a4fd813.khali@linux-fr.org>
	<20070228213803.GA4877@ucw.cz>
	<20070301152655.f232db64.khali@linux-fr.org>
	<20070302114023.GD2163@elf.ucw.cz>
	<20070302114747.GB1212@srcf.ucam.org>
	<20070302135810.GF2156@elf.ucw.cz>
In-Reply-To: <20070302135810.GF2156@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Pavel,

On Fri, 2 Mar 2007 14:58:10 +0100, Pavel Machek wrote:
> Actually for the acpi stuff... we might wrap ACPI interpretter with a
> semaphore that needs to be taken before starting any AML code. Then
> just make sure sensors take same semaphore?

I like the idea, it should work as long as we are guaranteed that all
the hwmon device accesses happen in the AML code? I'm not familiar with
ACPI, so you tell me.

In practice it's rather the SMBus drivers which will need to take the
lock, as this is what the AML code will access (for SMBus-based
hardware monitoring drivers.) For non-SMBus based hardware monitoring
drivers, indeed the driver itself should take it. We will have to pay
attention to deadlocks on systems with multiple hardware monitoring
chips and/or SMBus channels.

Can you please provide a patch implementing your proposal in acpi? Then
I could implement the i2c/hwmon part on some selected drivers and start
testing real world scenarii.

Thanks,
-- 
Jean Delvare

