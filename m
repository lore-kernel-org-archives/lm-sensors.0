From: markrages@gmail.com (Mark Rages)
Date: Sat, 08 Apr 2006 16:06:39 +0000
Subject: [lm-sensors] nForce 430 SMBus
Message-Id: <74ee72ca0604080906g57a9ce52t7e285539a38ce179@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
In-Reply-To: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 4/8/06, Jean Delvare <khali at linux-fr.org> wrote:
>
> Hey, good work. lease provide the output of (as root):
>   lspci -s 00:0a.1 -xxx
>

Here it is:
 lspci -s 00:0a.1 -xxx
00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a2)
00: de 10 64 02 01 00 b0 00 a2 00 05 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 06 00 00 01 07 00 00 00 00 00 00 de 10 84 cb
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 00 00
40: de 10 84 cb 01 00 02 c0 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 05 00 00 01 08 00 00 01 09 00 00 00 00 00 00
70: 01 00 00 00 00 00 b8 fe 00 00 fe fe 01 20 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: d4 30 80 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 10 10 04 00 00 a0 90 00 80 30 00 00 41 44 44 11
f0: 5a ff 5f bf 00 00 00 c0 10 00 00 00 00 00 00 00


--
You think that it is a secret, but it never has been one.
  - fortune cookie

