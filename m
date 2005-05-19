From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: gl518sm
Message-Id: <20020205121432.I19496@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I don't see a bus driver listed.  In order to communicate with your
chip (a GL518SM, I presume), you need a i2c bus driver which supports
your hardware installed.  Assuming you have a PIIX4, a good start
might be to insmod i2c-piix4.  Good luck!


Phil

On Wed, Feb 05, 2003 at 09:18:15AM +0100, Franssens wrote:
> I'm having quit some difficulties with lm-sensors.
> Everything, including installing and compiling worked great,
> but now it doesn't seem to recognize my gl518sm detectors.
> when I modprobe that module,
> and then perform a "sensors -s", it says; no sensors found!.
> But it really IS listed on your supported hardware page.
> 
> some help:
> motherboard: FullYes (82440lx), pentiumII 300HMz, 96MB RAM.
> 
> lsmod:
> Module                  Size  Used by
> gl518sm                 8096   0  (unused)
> i2c-proc                6064   0  [gl518sm]
> i2c-dev                 3712   0
> i2c-core               13328   0  [gl518sm i2c-proc i2c-dev]
> 
> the problem was, that sensordetect did not detect that gl518sm,
> but a piix4 an an eeprom.
> The only output sensors would give me then, was some info from eeprom,
> NOT voltages or fans etc.
> then I manually tried to modprobe gl518sm, with success. (as you can see)
> but unfortunately;
> sensors -s now says: no sensors found!
> 
> can you help me?
> 
> thnx!
> Anne

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
