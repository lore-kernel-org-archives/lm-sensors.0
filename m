From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: lm-sensors - hangs on Tyan Tiger S2460 motherboard
Message-Id: <20011127093611.B5595@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011125202705.A612@gallifrey>
In-Reply-To: <20011125202705.A612@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 27, 2001 at 09:45:11AM +0000, Dr. David Gilbert wrote:
> [...]
> Also the sensors-detect program is finding three eeproms (also in the 
> sensors output) - I only have two DIMMs though; so I don't know what the 
> other one is.  Is there some nice program to dump the eeprom contents?

50 and 51 are almost certainly your dimms.  54 could be an eeprom on
your CPU or something else?  You can see the contents (the first 256
bytes or so anyway) at /proc/sys/dev/sensors/eeprom* and you can use
lm_sensors2/prog/eeprom/decode-dimms.pl to see what the values mean if
your dimms follow the SPD spec.


Phil 

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
