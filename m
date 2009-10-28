From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 28 Oct 2009 14:55:26 +0000
Subject: Re: [lm-sensors] Help needed with lm-sensors & 9.10 & Asus M2N
Message-Id: <68676e00910280755i4e30d8c1ja3ed6c707e58193@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <69c4cb750910280749l54d2260egbe1189689ac25e9@mail.gmail.com>
In-Reply-To: <69c4cb750910280749l54d2260egbe1189689ac25e9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 28, 2009 at 3:49 PM, pepe@fernandezfreire.com
<pepe@fernandezfreire.com> wrote:
> Hi there,
>
> I've decided to write this e-mail, because most people who installed
> lm-sensors in 9.04 using synaptic can be affected with this change in 9.10
> (http://lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31).
[...]
> 2. I have updated to 9.10 and I have all symtoms described in FAQ section.
>
> Now I'm quite confused. I don't know if I firstly have to uninstall last
> version of lm-sensors. Is there a PPA where I can get some .deb's for latest
> versions of lm-sensors? I also would like to know where I can pick sensord
> program, because if I install lm-sensors 3.1.1 from here
> (http://dl.lm-sensors.org/lm-sensors/releases/lm_sensors-3.1.1.tar.bz2), I
> also need sensord, but if I try from Synaptic, other version of lm-sensors
> is intended to install.
>
> So, please, Can I get a simple howto to put my lm-sensors to work again.

asus_atk0110 should work with your board (and is loaded
automatically). Fan control is not supported by the driver though, so
if you want that you must pass acpi_enforce_resources=lax on kernel
command line and blacklist asus_atk0110 module.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
