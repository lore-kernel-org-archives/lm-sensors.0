From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Thu, 24 Nov 2005 02:58:15 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051124015757.GB17550@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 23 Nov 2005, Jean Delvare wrote:
> abandonned. I wish I had an SMBus 2.0 system myself to experiment with,
> but unfortunately even the most recent systems I have don't support
> SMBus 2.0.

Well, I suppose this means there is a device in that bus doing it, because I
have the same SMBus controller and there is no such 0x61 (neither is there a
0x64) device in the scan report.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
