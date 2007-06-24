From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 12:11:15 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070624141115.00ca3477@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

Just answering a couple questions:

On Tue, 19 Jun 2007 10:31:01 +0200, Hans de Goede wrote:
> 2) If this really is seen as an issue, all of the table, except for the entry
>     of the detected motherboard can be freed after init.

Yes, I'd definitely like this to be done. Shouldn't be difficult.

> Actually I think the k8temp driver should provide tempX_label,
> what if a dual core processor with only one tempsensor per core shows up?
> 
> Does the sensor in the second core then gets called temp3, thus temp2 gets 
> skipped to match the labels currently in sensors.conf?

Yes. Note that all hardware monitoring drivers do this. Missing inputs
are just not in sysfs and don't cause other inputs to be renumbered.
This makes the code much cleaner. That's something I don't like in your
abituguru3 driver.

> What about quad core's?

I don't think we've seen any, and I don't think the k8temp driver
currently supports them.

> Howto differentitatie between multiple core's in one die, and multiple sockets?

My understanding is that there's one PCI device per socket, so you have
one k8temp device in the former case and two in the latter.

> Also the current k8temp setup is broken, as with 2.10.4 with the default 
> sensors.conf it will print 3 missing temp errors in gkrellm
> there are 4 temp sensors, thus one needs to add ignore lines for 3.

The k8temp driver does the right thing. gkrellm is broken, it shouldn't
print errors for missing inputs with 2.6 kernels. The problem is not
specific to the k8temp driver at all, BTW. The core problem is that
libsensors was designed for the old procfs interface, where drivers
couldn't omit an input even if they knew the chip didn't have it. The
kernel evolved and user-space is lagging behind.

> With dynchip support this problem will no longer exist,

Which is exactly why we implemented it...

> and when combined with 
> foo#_label files and PCI-id based k8temp loading (already happening) this will 
> make the end user experience truely plug and play, which is exactly what we want.

This will be the case even without foo#_label.

> Yet another problem, is that I can currently add support for new abituguru3 
> motherboards as soon as abit releases a new windows uguru software supporting 
> them. With your approach, to get plug and play support dmi based config will 
> have to be integrated (planned) and then I need to wait for a user to contact 
> me with the dmi strings for this new motherboard, only then can I get a new 
> mobo truely supported. So the chain changes from:
> 
> -New mobo release
> -Download windows software, add info to kernel driver table
> -As soon as user gets new kernel through distro everything will work
> 
> to:
> 
> -New mobo release
> -Download windows software, add info to kernel driver table
> -Wait for user to start complaining that things don't work
> -Ask dmi strings
> -Add dmi strings + hand written config file to dmi - configfile database
> -User must get both new kernel and new config-file database through distro,
>   before things start to work.
> 
> Notice how the second scenario contains all the steps of the first + many more 
> steps.

Good point. I thought that the configuration file from Abit also
included the motherboard names, so that it would be easy to write and
publish the new sensors.conf files yourself. If you need to wait for
user reports to find out which motherboards have the new IDs, then
indeed it's more work that I hoped it would be.

>                                                 For example what happens when 
> the in kernel driver table skips the temp sensor with address 25 because that 
> seemed right and later that turns out to be a bug? Then all tempX with X > 1 
> will become temp(X+1), with all the info in the driver, things will still work 
> fine, with things spit, all the labels but for temp1 will be wrong.

You driver shouldn't renumber inputs to start with.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
