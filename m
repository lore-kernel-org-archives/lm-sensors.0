From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Feb 2007 18:48:29 +0000
Subject: [lm-sensors] mcp61 sensors support
Message-Id: <20070219194829.947b2a34.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9ef864c50702182307q4364770cj53c6dbab30fcd887@mail.gmail.com>
In-Reply-To: <9ef864c50702182307q4364770cj53c6dbab30fcd887@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

On Mon, 19 Feb 2007 02:07:19 -0500, Thomas Garner wrote:
> I have an ECS Geforce6100sm-m with an Nvidia mcp61s chipset.  Using
> 2.6.20, I have support for k8temp cpu temperature monitoring, but
> would like to have regular motherboard vitals as well.  Searching for
> mcp61 does not reveal anything particularly conclusive as to whether
> or not this chipset is supported.  Is it at all supported, and, if so,
> what do I need to do to get it working?

Looking at:
http://www.lm-sensors.org/wiki/Devices
It is listed as possibly compatible with the earlier nVidia south
bridges, but this needs testing.

Can you please provide a dump of the PCI config space of your device?
lspci -xxx -s 00:01.1

-- 
Jean Delvare

