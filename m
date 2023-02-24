From: Jonas Malaco <jonas@protocubo.io>
Date: Fri, 24 Feb 2023 05:57:13 +0000
Subject: Re: kernel modules
Message-Id: <20230224055713.fitivi4mirunb5ex@calvin.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <Y/fpAAvvSZxIJnPF@linux4>
In-Reply-To: <Y/fpAAvvSZxIJnPF@linux4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mike,

On Thu, Feb 23, 2023 at 10:30:24PM +0000, mike mccool wrote:
> hello,
> 
> i am using lm-sensors/sensors on an AMD AM4 motherboard w/ 5700G APU
> and ubuntu 22.04
> 
> i added kernel module 'drivetemp' to get temp data from the 10 SATA
> drives on this box. i would like to filter-out(ignore) the drivetemp
> output from /usr/bin/sensors but cannot. the keyword 'chip' does not
> work so 'ignore' statements have no effect.
> 
> please add a new keyword, eg, 'module', so that it would be possible
> to craft filters like this:
> 
> module "drivetemp-scsi-0-*"
>    ignore temp1
> 
> or
> 
> module "k10temp-pci-00c3"
>    ignore Tctl
> 
> or
> 
> module "nvme-pci-2600"
>    ignore Sensor 1
>    ignore Sensor 2
> 
> regards

Is the error you're seeing "Undeclared bus id referenced"?

If that's the case, there are a couple of issues already open on GitHub
for that problem:

- <https://github.com/lm-sensors/lm-sensors/issues/230>
- <https://github.com/lm-sensors/lm-sensors/issues/369>

and I have a patch that addresses it:

- <https://github.com/lm-sensors/lm-sensors/pull/371.patch>

Please let me know if you give it a try.

Alternatively, either:

    chip drivetemp-scsi-*-*
        ignore temp1

or:

    chip drivetemp-*
        ignore temp1

might work even without the patch. And they should be enough since you
don't actually need to identify each drive individually.

Finally, yet another alternative is to not load (or build) the drivetemp
driver.

Jonas
