From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 03 Jun 2006 21:33:08 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded
Message-Id: <44820014.5010407@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Sat, Jun 03, 2006 at 11:50:32AM +0200, Jean Delvare wrote:
> I admit it's acceptable by today's standards, but given that it's 5
> times the size of lm_sensors itself (user-space part), I'd expect
> distributions to ship it as a separate, optional package. And we
> probably should do as well.
> 

I've thought some more about this and I must say I like the idea, if we
have a package* containing known working config files for each
motherboard and an include statement for sensors.conf, then an
autoconfig tool would only have to generate the nescesarry #include
lines(s). This way it will also be easy to generate configs which
contain the correct config for both a motherboard and say a graphics
card, simply by having 2 include lines in sensors.conf one for each.

*preferably a package generated from some kinda database with a
webinterface, as will be created by the google SOC project)


Regards,

Hans


