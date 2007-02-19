From: thomas536@gmail.com (Thomas Garner)
Date: Mon, 19 Feb 2007 19:39:33 +0000
Subject: [lm-sensors] mcp61 sensors support
Message-Id: <9ef864c50702191139v6a4fa97lb82b9a2341ecbba@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9ef864c50702182307q4364770cj53c6dbab30fcd887@mail.gmail.com>
In-Reply-To: <9ef864c50702182307q4364770cj53c6dbab30fcd887@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I would be happy to do any testing for you to get this device into
sensors... Here's the output for you.

[root at ns ~]# lspci -xxx -s 00:01.1
00:01.1 SMBus: nVidia Corporation MCP61 SMBus (rev a2)
00: de 10 eb 03 01 00 b0 00 a2 00 05 0c 00 00 80 00
10: 01 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 1c 00 00 01 f4 00 00 00 00 00 00 19 10 02 26
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 00 00
40: 19 10 02 26 01 00 02 c0 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 10 00 00 01 14 00 00 01 18 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 fe fe 01 00 00 00
80: 00 10 fe fe 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: d4 30 80 01 01 00 00 00 00 00 00 00 00 00 00 00
d0: 40 00 40 01 10 00 00 00 05 00 00 00 00 00 00 00
e0: 88 10 04 00 04 40 00 07 80 12 04 00 41 44 44 11
f0: 02 ff 1e bf 01 00 00 80 10 00 00 00 00 00 00 00

On 2/19/07, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Thomas,
>
> On Mon, 19 Feb 2007 02:07:19 -0500, Thomas Garner wrote:
> > I have an ECS Geforce6100sm-m with an Nvidia mcp61s chipset.  Using
> > 2.6.20, I have support for k8temp cpu temperature monitoring, but
> > would like to have regular motherboard vitals as well.  Searching for
> > mcp61 does not reveal anything particularly conclusive as to whether
> > or not this chipset is supported.  Is it at all supported, and, if so,
> > what do I need to do to get it working?
>
> Looking at:
> http://www.lm-sensors.org/wiki/Devices
> It is listed as possibly compatible with the earlier nVidia south
> bridges, but this needs testing.
>
> Can you please provide a dump of the PCI config space of your device?
> lspci -xxx -s 00:01.1
>
> --
> Jean Delvare
>

