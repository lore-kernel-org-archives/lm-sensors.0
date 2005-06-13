From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 13 Jun 2005 19:15:20 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address
Message-Id: <20050613191240.22f75b29.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sukhdeep,

> The Motherbowrd is from VIAPRO, it's similar to kt400.

VIA Pro / KT400 is the name of the South Bridge. This doesn't tell me
the motherboard itself is. Have you no idea? dmidecode [1] may help.

[1] http://www.nongnu.org/dmidecode/

> Client found at address 0x29
> (...)
> Probing for `Winbond W83782D'... Success!
>     (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
> (...)
> Client found at address 0x2d
> (...)
> Probing for `Winbond W83782D'... Success!
>     (confidence 8, driver `w83781d'), other addresses: 0x48 0x49

Wow. So it does actually find *two* W83782D chips, which share the same
subclient addresses. This is no good.

Can you please provide the output of the following commands:
i2cdump -y 0 0x29
i2cdump -y 0 0x2d

(I assume this is on i2c bus 0; if not, put the correct ID.)

> Probing for `Winbond W83697HF Super IO Sensors'
>   Success... but not activated

And the Super-I/O is there. I suspect that the W83697F has the same ID,
so we cannot differenciate, but the W83697F has no hardware monitoring
logical device - which would explain why it is listed as 'not activated"
here.

So... the correct modprobe line for you would be:

modprobe w83781d force_subclient=0,0x29,0x4a,0x4b

Try it :)

-- 
Jean Delvare
