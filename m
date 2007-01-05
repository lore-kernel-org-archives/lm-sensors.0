From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 05 Jan 2007 20:36:39 +0000
Subject: [lm-sensors] Problem with MSI K9N6SGM-V motherboard sensors
Message-Id: <4dfa50520701051236x54495031o491fd9069d874e9c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <459CA045.7050603@verizon.net>
In-Reply-To: <459CA045.7050603@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

This is the information sensors gives you that identifies your chip:

> Probing for Super-I/O at 0x4e/0x4f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       Yes
> Found unknown chip with ID 0x0541

I am going to guess it's a new chip not seen before. The MSI K9N6SGM-V
uses the nVidia MCP-61 chipset. I downloaded the manual from:

http://www.msi.com.tw/program/support/download/dld/spt_dld_file_record.php?folder=3&kind=1&name=M7309v1.1.zip

(JAVASCRIPT WARNING)

In the manual on about page 4, there's a diagram showing the board
layout. If this is accurate enough, then the hardware monitoring chip
*must* be integrated in the nVidia MCP-61. The chip is probably only
recognizable by the chip ID 0x0541. I don't know what chip it is.

Hope that helps,
David

