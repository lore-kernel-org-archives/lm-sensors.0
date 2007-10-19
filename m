From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 19 Oct 2007 18:33:46 +0000
Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from 'sensors'
Message-Id: <4718F88A.5040105@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1192816904.8203.11.camel@homedev.skoona.net>
In-Reply-To: <1192816904.8203.11.camel@homedev.skoona.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

James Scott Jr wrote:
>     Folks,
> 
> I have a system with an Intel Q6600 quad core on a ABit IP35 Pro
> mainboard, using Fedora 7 x64, and lm_sensors-2.10.4-1.fc7.  The output
> from sensors is wrong.  Is there a preformatted config file for these
> mainboard somewhere that I can find?  Or can you give me a hit on what I
> need to know in order to create/adjust one?
> 

Abit usually does not use the sensors of the super io chip (which the w83627dhg 
is), instead they use their own solution called uguru. There is a driver for 
this, but the uguru isn't detected by sensors-detect.

Try modprobe abituguru3, and then try running sensors again.

The abituguru3 driver is only available in kernel 2.6.23 and higher, to install 
this kernel for F-7 do:
yum update --enable-repo=updates-testing kernel

After rebooting into the new kernel do
modprobe abituguru3
sensors


Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
