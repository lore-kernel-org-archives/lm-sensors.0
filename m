From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 25 Oct 2005 14:42:04 +0000
Subject: [lm-sensors] Patch for 'w83627thf' Chipset add SmartFan control
Message-Id: <TIWetMW6.1130243384.1260640.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
In-Reply-To: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Henrique,

On 2005-10-25, Henrique de Moraes Holschuh wrote:
> There is this new idea in lm-sensors to try to make these things
> hardware-independant (although at the state it is right now, it just broke
> some drivers, and took away functionality).

Can you please develop on this? Which drivers were broken? What
functionality was taken away?

> I have a working setup that is reasonably hardware independant for smart
> fan control, for the LM85 and friends.  Since there is NO proper
> documentation for this "device independant" interface,

There is. Read Documentation/hwmon/sysfs-interface, it's all there, in
the PWM section, since 2.6.10-rc1.

Not that many driver seems to actually implement this interface. Only
adm1026 actually seems to do actually, adm1031 and lm85 aren't far but
are not there yet. Anyway, the standard is defined. Whether or not the
driver authors follow it or not is a different matter.

This interface was discussed a long time ago on this list, it even made
some noise if I recall properly.

> and any queries about it to this list are met with silence, I suppose
> it is up to us who need it to fix that.

This is exactly the way it is supposed to work. Work never gets done
better and faster than when the workers themselves are interested in the
result.

BTW, it's really great that you are proposing to help us. Our project
really needs good souls willing to spend their time reviewing and
integrating code, analyzing and fixing bugs, and supporting users, for
free. As you may have noticed, there is more work that the volunteers
can currently deal with. More manpower is always welcome.

> Are you willing to work with me so that we can draft such an interface
> (based on what already is in lm-sensors)?

As said above, the interface already exists. No need to draft anything as
far as I can see. If the interface doesn't fit your needs, please
explain why.

> (...) and if you need to expose the underlying controls
> anyway, we'd need a hardware_specific namespace to do so.

That's fine with me. Not everything fits in the standard. The additional
sysfs names must simply not interfere with the current or future
standard names.

Thanks,
--
Jean Delvare
