From: michaelnel@comcast.net (Michael Nelson)
Date: Sun, 10 Sep 2006 19:46:22 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060910194622.GA11993@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Sep 10, 2006 at 07:52:59PM +0200, Jean Delvare wrote:

> You need lm_sensors SVN for voltage values:
> http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4155-20060908.tar.bz2

OK, I will grab that.

> Expected, as the W83627DHG doesn't have this voltage input. You'd need
> to edit the script to skip in9 completely.

I just noticed this morning that in the BIOS setup at the top of one of the
pages it says "Configure Win627EHF Super IO Chipset".  I had not noticed
that before (perhaps it wasn't there before, I just updated my BIOS to the
latest one).

Anyway, that doesn't appear to be the same chip, does it?

Michael

-- 

San Francisco, CA

