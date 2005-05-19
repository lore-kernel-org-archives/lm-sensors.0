From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Issues with lm_sensors on Intel SE7501cw2 (including the max6651)
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E13FD8A@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm using an Intel SE7501cw2 motherboard.  It's not an exotic or unusual motherboard, though I agree that the way that its fans are wired is weird.

My interpretation of the 6651 data sheet is that you can either set the voltage (open loop) or the fan speed (closed loop).  Given the way my board is wired, I don't expect closed loop to work.  Open loop seems to work, though the "speed" register is misleading.  

Would it make sense to have more explicit support for open loop mode?  Maybe offer a "pwm" interface similar to what they have on the Winbond w83627hf?  Then the "pwmconfig" program could use it.  And any use of the pwm setting would ensure selection of open loop mode, just like use of the "speed" setting ensures closed loop mode.  Just blue-skying here.  I probably wouldn't use this feature if it were implemented.

What about at least putting a note in the documentation to explain the multiple modes, the fact that the driver doesn't change modes, and what the speed setting does in each?

What are your thoughts about the assumption of two pulses per rotation?  The doc mentions that the Max datasheet makes this assumption, but other chips and drivers don't make this assumption, and I for one have some fans that seem to only give one pulse per revolution.  What is the best way to report the actual fan speed for a one-pulse fan?

Thanks!


> -----Original Message-----
> From: Morris, John [mailto:John.Morris@spirentcom.com]
> Sent: Tuesday, October 21, 2003 2:06 PM
> To: Marc Rieffel; Mark Studebaker
> Cc: sensors@stimpy.netroedge.com; Morris, John; Bob Y. Hsin
> Subject: RE: Issues with lm_sensors on Intel SE7501cw2
> 
> 
> Apologies - I missed this mail trail when my name was first 
> mentioned (I watch for "6650" in the title :-) and I haven't 
> been following the conversation.
> 
> Anyway, yes, the 6650 driver mostly assumes that the bios (or 
> something) has already configured the chip, following a message 
> trail here which suggested that drivers should not mess up 
> existing config settings. The one exception is if the "speed"
> value is written: that's really only meaningful in closed loop
> mode, so then the driver makes sure closed loop is indeed set.
> 
> Other than that, the driver does very little with the "speed" 
> register - it just translates between rps and register values, 
> using the formulae from the datasheet, and pokes the result into 
> the 6650. The 6650, if properly wired, will then automatically 
> vary the fan drive voltage in an attempt to maintain fan1 at 
> the configured speed.
> 
> Note that the "speed" register on the 6650, and hence the
> corresponding value in /proc/... reports the *configured* speed,
> not the *actual* speed. The actual speed can be read from the 
> fan1 register.
> 
> The 6650's speed control only reads fan1 (that's a chip 
> limitation), so if that fan's tach is not connected it's just
> not going to work. I think what the chip would do in that case -
> and assuming the output is connected to the proper FET which
> is in turn wired up for fan speed control - is turn the speed up
> to maximum, in an ultimately futile attempt to get fan1 up to
> speed. Depending on the circuit, all the other fans would go
> to full speed too.
> 
> One other note about the 6650: it will work with 5 and 12V fans,
> but needs to be configured for the right one. We use 12V fans, 
> which is how I have the chip configured here. That may need 
> to be changed for other systems.
> 
> You seem to have some weird hardware there...
> 
> I'll start watching this thread now: let me know if I can help 
> further.
> 
> J.
> 
