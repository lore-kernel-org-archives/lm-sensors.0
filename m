From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 21 Feb 2007 14:54:44 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070221155444.99386b98.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
	<45D6DDCE.5050803@assembler.cz>
	<45D7461A.2040808@redhat.com>
	<45D8D6AE.3000204@assembler.cz>
	<45DB0EEA.2010205@redhat.com>
In-Reply-To: <45DB0EEA.2010205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Chuck,

On Tue, 20 Feb 2007 10:08:26 -0500, Chuck Ebbert wrote:
> I blacklisted the k8temp driver (and the out-of-tree k8_edac driver
> in Fedora) and the temps were still volatile, so that's not causing
> it. Since then I've upgraded the system BIOS from F.06 to F.27 and
> the problems _may_ have gone away. My own custom 2.6.19 kernel has
> never been a problem, so I'm thinking it's one of these drivers
> loaded by Fedora that I never even compile:
> 
> 	i2c_core

i2c-core doesn't touch the hardware by itself.

> 	i2c_ec

Presumably autoloaded by the ACPI subsystem, I guess your ACPI
implementation includes an SMBus 2.0 controller.

> 	i2c_piix4

i2c-piix4 will autoload if a supported PCI device is found on your
system. Assuming this is the same physical bus as i2c_ec is exposing,
it's no good to load both i2c-piix4 and i2c_ec at the same time.
Unfortunately i2c_ec doesn't request the I/O resources it uses so this
kind of conflict cannot be avoided currently.

Can you try to load the i2c-dev driver, then run the following commands
and report the results:
$ i2cdetect -l
For each bus listed:
$ i2cdetect N
(where N is the i2c bus number)

> 	asus_acpi (on a Compaq???)
> 	sbs

This is a new battery driver used in conjunction with i2c_ec. I guess
you have a smart battery in your laptop which is accessed through
the SMBus. I found that this driver bypasses the i2c-core locking,
which is really bad. I reported it one week ago:
http://marc.theaimsgroup.com/?l=linux-acpi&m7160531631100&w=2
(for some reason my original post wasn't archived)
My patch wasn't applied, but the problems you describe could well be
caused by this locking issue. So I suggest that you unload the sbs
driver and see if things get better. If they do, you could try to apply
my patch and load sbs again, and see if it fixes it.

-- 
Jean Delvare

