From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Tue, 25 Oct 2005 13:54:39 +0000
Subject: [lm-sensors] Patch for 'w83627thf' Chipset add SmartFan control
Message-Id: <20051025115404.GD15778@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
In-Reply-To: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 25 Oct 2005, Eric Pascal wrote:
> 	I'd like to help you but I'm really not an expert in hardware
> 	programming or in motherboard chipsets, I have just been able to
> 	keep this patch alive for 1 year but apparently it's not enough.
> 	Could you tell me in what this patch is 100% different from what is
> 	in lm-sensors and I could fix it? It would be a pity that these
> 	working modifications would be lost forever. 

The sysfs interface to userland needs to be changed, and it won't map 1:1 to
your hardware.

Here is the LM85 interface (as per 2.6.13.3):

alarms
cpu0_vid
vrm

fan#_input
fan#_min
in#_input
in#_max
in#_min

pwm#
pwm#_auto_channels
pwm#_auto_pwm_freq
pwm#_auto_pwm_min
pwm#_auto_pwm_minctl
pwm#_enable

temp#_auto_temp_crit
temp#_auto_temp_max
temp#_auto_temp_min
temp#_auto_temp_off
temp#_input
temp#_max
temp#_min

Where # is a number that varies with the number of channels.  Some of these
entries are RW, others are RO, and some are automatically updated if others
are changed.

My version of LM85 adds the following entries:
auto_acoustics_enhancement
auto_acoustics_enhancement_pwm#   (adm1027/adt7463)
auto_acoustics_enhancement_temp#  (lm85b/c, emc6d100/101/102)

The implementation of auto_acoustics_enhancement* is up do discursion, I
don't like the current one I took as a first approach, which I described in
a post to this ML a few weeks ago.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
