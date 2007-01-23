From: juergh@gmail.com (Juerg Haefliger)
Date: Tue, 23 Jan 2007 15:32:27 +0000
Subject: [lm-sensors] sensors and i2cdump disagree on bus number
Message-Id: <191fb4ca0701230732k3c7a90a6n1f69483c099d502e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0701222114x22dfb5bcn255c300df4fd3a84@mail.gmail.com>
In-Reply-To: <191fb4ca0701222114x22dfb5bcn255c300df4fd3a84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

> The dump actually matches the sensors output. Look at the sensors
> values, they are all broken! I suspect you forced the driver to attach
> to this specific bus and address, so it shows in "sensors", but there
> really is no chip there. You probably just need to adjust your modprobe
> options to force the driver to attach to the right bus.

Hmm... How would I do that? I did 'modprobe lm85 force_emc6d102=1,0x2e'
duh, I just realized that force_emc6d102=1 means bus 1 and not enable forcing...

Thanks, all's fine
...juerg

