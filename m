From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Any success reading sensors on IBM 326, HP DL145, Sunfire v20z
Message-Id: <TIeU4lTX.1108459241.2508010.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0502141723200.11696@boxer.fnal.gov>
In-Reply-To: <Pine.LNX.4.58.0502141723200.11696@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Steven,

On 2005-02-14, Steven Timm wrote:

> I have tried to use lm_sensors to read out IBM e-server 326, HP DL145,
> Sun Sunfire v20z.  On the IBM and sun all I can get are the eeprom's,
> on the Sun sunfire I can get one w83627hf but with nothing
> important attached to it.  Has anyone else done better up till now?

I am not surprised for the IBM eServer, we had several reports that these
were using proprietary stuff for the hardware monitoring, so there's
not much we can do. For the HP and Sun we didn't have reports that I
can remember.

There are several reasons why lm_sensors may not work on a given machine,
we hardly know every hardware so it's hard for us to tell unless you
provide more data. That would be:
1* Output of sensors-detect.
2* Visual inspection of the motherboards. If you see familiar chip names,
tell us. Searching is easier when we know what we're after.
3* Documentation browsing. Maybe the technical documentation available
for your products give hints. If they give the name of the chip, it
helps. If they tell how many voltages, temperatures and fans are
supposed to be monitored, that helps as well.

If you provide that information, we'll let you know what you can hope to
get from lm_sensors on your boards.

--
Jean Delvare
