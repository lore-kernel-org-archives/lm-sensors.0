From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Mar 2007 20:29:10 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <20070318212910.1694a5b9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Fri, 16 Mar 2007 14:06:08 +0100, Ivo Manca wrote:
> First of all, is it good idea to scan for sensors in the CPU's after our 
> script successfully finds a match with the DMI information?
> If we don't do this, the user might have a disadvantage using the new way of 
> detection, since the DMI information will only used be for mainboard 
> information.
> However, we are not completely sure if the CPU detection is currently 
> completely safe. Do you have any idea about that? Because if it isn't, it 
> might not be a good idea to "just" let that also run.

This is a good point. DMI data is indeed mainly about the motherboard,
while sensors can be found in other parts of the computer: CPU as you
found yourself, but also graphics adapter, memory module or hard disk
drive (not yet supported by lm-sensors.) The DMI database you're
working on can obviously only cover the motherboard sensors.

The current detection of CPU-embedded sensors is totally safe. It's
not based on physical probing as is the case for SMBus or Super-I/O
hardware monitoring chips. Instead, it is based on the presence of a
given PCI device (for AMD) or on the CPU ID (for Intel.) So it's OK to
include that part of sensors-detect in conjunction with your DMI-based
identification for the motherboard sensors.

Note that PCI drivers can be automatically loaded, so we could even
stop handling them in sensors-detect. We leave them in for
completeness, but chances are that the driver will already be loaded
before the user runs sensors-detect (assuming the required driver is
available on the system, of course.)

> Secondly, do you prefer using the local database (/cache, which contains the 
> dmi-info versus configuration) as the default option, or to prefer it when 
> the default option fetching the online database first?
> 
> Downloading the online database is a big pro, since faulty and new 
> configurations can be fixed and updated.
> 
> Just wondering what you think about it.

Good point again. Using the local database first will lower the load on
our server significantly, and will be overall faster for the user.
Missing configurations that were added later to the online database are
not a problem, we obviously want to try the online database if the
local cache has no information. The case where the configuration file
was updated is admittedly more problematic. I wonder how frequently the
configurations will be updated in practice. It's hard to predict.

I'm not too sure, but I'd say use the online database first, and
fallback to the cache if network is not available OR if the user
doesn't want the script to connect (a command-line option would be
welcome.)

> You were also saying that you could provided quite some more DMI strings to 
> complement the list Rudolf send earlier. Could you please do that? Would be 
> nice to find out about strange exceptions in an early stage ;).

OK, I will extract the info and send it to you in private tomorrow.

-- 
Jean Delvare

