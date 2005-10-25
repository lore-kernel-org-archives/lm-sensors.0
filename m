From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Tue, 25 Oct 2005 13:21:06 +0000
Subject: [lm-sensors] Patch for 'w83627thf' Chipset add SmartFan control
Message-Id: <20051025112011.GC15778@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
In-Reply-To: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 25 Oct 2005, Eric Pascal wrote:
> I have maintained a patch (published on a forum by Peter Oehry -
> http://archives.andrew.net.au/lm-sensors/msg27345.html) for w83627thf
> chipsets that enable SmartFan control on the chipset to automaticaly
> control the CPU Fan speed depending on the CPU temperature. The forum
> describes the function of the drivers as followed:
> 
> They correspond direct with the datasheet of the w83627thf
[...]

There is this new idea in lm-sensors to try to make these things
hardware-independant (although at the state it is right now, it just broke
some drivers, and took away functionality).

I have a working setup that is reasonably hardware independant for smart fan
control, for the LM85 and friends.  Since there is NO proper documentation
for this "device independant" interface, and any queries about it to this
list are met with silence, I suppose it is up to us who need it to fix that.

Are you willing to work with me so that we can draft such an interface
(based on what already is in lm-sensors)?  Your patch would change a bit, as
it is 100% different from what is already in use in lm-sensors, though.

Also, from what I can see, your chip can do a *great* deal many things, we
would probably have to automate a few of them (they wouldn't fit an useable
generic interface), and if you need to expose the underlying controls
anyway, we'd need a hardware_specific namespace to do so.

What do you think?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
