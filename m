From: pinkel@gmail.com (Ivo Manca)
Date: Tue, 20 Mar 2007 12:39:45 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <00e701c76aec$d8e941e0$0901a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean,


> This is a good point. DMI data is indeed mainly about the motherboard,
> while sensors can be found in other parts of the computer: CPU as you
> found yourself, but also graphics adapter, memory module or hard disk
> drive (not yet supported by lm-sensors.) The DMI database you're
> working on can obviously only cover the motherboard sensors.

We were aware about these situaties. But since the harddisk and videocard 
sensors are found by probing, we'd rather not do anything with them. Because 
we figured out the CPU detection might be safe, we considered that option as 
well.

> The current detection of CPU-embedded sensors is totally safe. It's
> not based on physical probing as is the case for SMBus or Super-I/O
> hardware monitoring chips. Instead, it is based on the presence of a
> given PCI device (for AMD) or on the CPU ID (for Intel.) So it's OK to
> include that part of sensors-detect in conjunction with your DMI-based
> identification for the motherboard sensors.

That sounds good! Must be easy to call the cpu detection after the DMI 
probing has succeeded :).

> Note that PCI drivers can be automatically loaded, so we could even
> stop handling them in sensors-detect. We leave them in for
> completeness, but chances are that the driver will already be loaded
> before the user runs sensors-detect (assuming the required driver is
> available on the system, of course.)

Noted

> Good point again. Using the local database first will lower the load on
> our server significantly, and will be overall faster for the user.
> Missing configurations that were added later to the online database are
> not a problem, we obviously want to try the online database if the
> local cache has no information. The case where the configuration file
> was updated is admittedly more problematic. I wonder how frequently the
> configurations will be updated in practice. It's hard to predict.
>
> I'm not too sure, but I'd say use the online database first, and
> fallback to the cache if network is not available OR if the user
> doesn't want the script to connect (a command-line option would be
> welcome.)

Noted, and the user will ofcourse be noticed. A commandline option for 
dissabling it (or just _only_ updating the cache without doing anything 
else) will be added.

>> You were also saying that you could provided quite some more DMI strings 
>> to
>> complement the list Rudolf send earlier. Could you please do that? Would 
>> be
>> nice to find out about strange exceptions in an early stage ;).
>
> OK, I will extract the info and send it to you in private tomorrow.
>
> -- 
> Jean Delvare

I received them, thank you!

Ivo Manca 


