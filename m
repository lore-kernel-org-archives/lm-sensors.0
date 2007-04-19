From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Apr 2007 13:34:27 +0000
Subject: Re: [lm-sensors] w83627dhg msi 975x problems
Message-Id: <20070419153427.50b0e93a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070415185853.GA11766@xeron.cc>
In-Reply-To: <20070415185853.GA11766@xeron.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 17 Apr 2007 21:27:53 -0400, Jordan wrote:
> and here are the isadumps:
> 
> smart fan in bios off:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 04 ff 04 7f 03 00 00 00 01 01 01 01 3c 3c 0a 0a
> 10: 04 ff 00 00 00 01 01 3c 42 17 00 00 ff ff ff c4
> 20: 99 ec cd cd ff b5 c3 22 3a 12 35 da 00 96 18 9e
> 30: 5b 44 34 04 60 38 b6 0f 23 51 08 87 a4 2a 05 ff
> 40: 01 2e 1f fe ff ff 01 05 2d 00 00 04 58 95 00 a3
> 50: ff ff 00 ff ff ff 00 80 c1 70 ff ff 19 e5 04 05
> 60: 04 7f 40 00 01 01 3c ff 01 ff 01 ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: 04 ff 04 7f 03 00 00 00 01 01 01 01 3c 3c 0a 0a
> 90: 04 ff 00 00 00 01 01 3c 42 17 00 00 ff ff ff c6
> a0: 99 ec cd cd ff b5 c3 22 3a 12 35 da 00 96 18 9e
> b0: 5b 44 34 04 60 38 b6 0f 23 51 08 87 a4 2a 05 ff
> c0: 01 00 10 fe ff ff 01 05 2d 00 00 04 58 95 00 a3
> d0: ff ff 00 ff ff ff 00 80 c1 70 ff ff 19 e5 04 05
> e0: 04 7f 40 00 01 01 3c ff 01 ff 01 ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> 
> smart fan in bios on:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 04 ff 04 7f 03 00 00 00 01 01 01 01 3c 3c 0a 0a
> 10: 04 ff 00 00 00 01 01 3c 42 17 00 00 ff ff ff c8
> 20: 98 ec cd cd ff b5 c3 22 38 27 34 da 00 9e 18 9e
> 30: 1b 44 34 04 60 78 96 1f 23 51 08 86 a4 2a 04 ff
> 40: 01 6e 1f fe ff ff 01 05 2d 00 00 04 58 95 00 a3
> 50: ff ff 00 ff ff ff 00 80 c1 70 ff ff 19 e5 04 05
> 60: 04 7f 40 00 01 01 3c ff 01 ff 01 ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: 04 ff 04 7f 03 00 00 00 01 01 01 01 3c 3c 0a 0a
> 90: 04 ff 00 00 00 01 01 3c 42 17 00 00 ff ff ff ca
> a0: 98 ec cd cd ff b5 c3 22 38 28 34 da 00 9e 18 9e
> b0: 1b 44 34 04 60 78 96 1f 23 51 08 86 a4 2a 04 ff
> c0: 01 00 10 fe ff ff 01 05 2d 00 00 04 58 95 00 a3
> d0: ff ff 00 ff ff ff 00 80 c1 70 ff ff 19 e5 04 05
> e0: 04 7f 40 00 01 01 3c ff 01 ff 01 ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Comparing both outputs didn't provide much information. The only
changes are in a reserved register (0x1f), monitored values (expected),
limits (I guess they aren't initialized by the BIOS) and an interrupt
register (probably the result of a different limit value). In
particular, the fan speed control mode registers (0x04, 0x12 and 0x62)
are unchanged. This seems to confirm that the fan speed control is done
by a different device.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
