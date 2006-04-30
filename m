From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 30 Apr 2006 12:24:53 +0000
Subject: [lm-sensors] sensors work but broke the network and sound
Message-Id: <20060430142453.f2a94edd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060430120557.12F6E18C67F@mail.host.bg>
In-Reply-To: <20060430120557.12F6E18C67F@mail.host.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I configured the sensors, now they're working great,
> but I haven't got network and sound !!!! My sound card is
> realtek ac97 and the ethernet card is Intel 3Com. I didn't
> do anything different from typing sensors-detect and then
> editing /etc/modules.conf and /etc/rc.d/rc.modules as
> shown in the examples ! Have you got any suggestions
> how could I repair it ?? Please help!

You need to provide much more information than that if you want us to
be able to help you:

* What motherboard and/or system is it?

* Linux distribution?

* Kernel version?

* lm_sensors version?

* What kernel modules are you loading for sensors?

* What kernel modules are you loading for network and sound?

* Are the sound and network back if you disable the sensors modules and
cold reboot?

Oh, and I doubt that something as an "Intel 3Com" network adapter
exists. It has to be Intel or 3Com, not both.

-- 
Jean Delvare

