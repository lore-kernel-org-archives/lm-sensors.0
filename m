From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 26 Feb 2007 17:24:05 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070226182405.baa4aa41.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
In-Reply-To: <45D5EA88.7090300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 23 Feb 2007 09:08:30 +0100, Hans de Goede wrote:
> I'm glad you like it, but how does this relate to using dmi info in 
> sensors-detect, if we add that capability to sensors-detect and add a database 
> with known motherboards and there configs, then that would be a doublure with 
> having the info in the drivers, this is the main reason why I hesitate.

Very good point.

I believe that the abituguru case is a bit special. The DMI data is not
only useful to find out which boards need the driver. It is also useful
to prevent the driver from being loaded on random hardware. Given that
the chip is impossible to detect, it would sound sensible to at least
prevent the abituguru driver from being loaded on non-Abit systems. If
the list of supported boards is short and well known, including it too
can't hurt.

But we can't do that for the rest of the hwmon drivers. The list of
supported boards for each driver is too long and growing too fast to
live in the kernel. For other drivers my plan is to just detect them
and trigger the module load. For Super-I/O chips, they have ID
registers, we can read them and have a table that match IDs to drivers.
For SMBus chip, once we have David Brownell's new i2c-core
infrastructure, we should be able to write a hwmon-smbus-probe drivers
which would probe the SMBus for chips and trigger the right module
loading.

But it might take a long time before we manage to implement all this.
In the meantime we have to let user-space deal with it, which is the
case at the moment, and it doesn't work so bad if you ask me.

As for sensors-detect itself, there's much more to do with the DMI data
than just finding which drivers need to be loaded. I don't think we
would bother adding DMI support to sensors-detect just for that, except
for the few boards with undetectable chips (uGuru) or which are
otherwise known to cause trouble when probed. The true value of using
DMI data in sensors-detect is to have a repository of configuration
files identified by DMI data, so that sensors-detect can fetch and
install a custom configuration file for your system. Being able to find
out the right drivers without probing is more or less a side effect.

-- 
Jean Delvare

