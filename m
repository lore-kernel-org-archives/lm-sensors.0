From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 01 May 2006 10:44:37 +0000
Subject: [lm-sensors] sensors work but broke the network and sound
Message-Id: <20060501124437.eb01248e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060430120557.12F6E18C67F@mail.host.bg>
In-Reply-To: <20060430120557.12F6E18C67F@mail.host.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> *motherboard - nvidia nforce2

What brand and model, please?

> So I disabled sensors modules and made a cold reboot, but
> still no network and sound. In the outputs at boot/shutdown
> I saw that it can't find any sound card.

You may need to physically unplug the power cord of your system for one
minute and restart it again in order to get sound and network back. A
number of chips are powered by a "stand-by" power source which is
always on even when the system is down.

-- 
Jean Delvare

