From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Sun, 19 Oct 2008 18:02:57 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <20081019180257.GA29060@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Oct 19, 2008 at 06:20:00PM +0200, Jean Delvare wrote:

> If you instead refer to a board-specific offset that should be applied
> to compensate for the distance between the thermal sensor and the
> graphics core, or for a non-standard thermal diode, the lm90 driver
> exposes attribute temp2_offset so user-space can set and read the
> temperature offset.

Right. My kernel driver is in the privileged position of knowing 
precisely what offset should be applied to the lm90 readings, so doing 
this in-kernel would be advantageous :)

> Why do you want to retrieve the temperature value from the kernel?
> Please explain your use case.

I'm implementing power management for GPUs. These typically have several 
different performance constraints, but one of them is chip temperature. 
The maximum supported temperature is generally exported via tables in 
the graphics card BIOS, so it's necesssary for the kernel driver to be 
aware of the current temperature in order to limit the available 
performance modes to ensure the GPU stays within its thermal envelope.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
