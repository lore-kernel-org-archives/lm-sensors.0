From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 04 Feb 2007 14:16:00 +0000
Subject: [lm-sensors] Intel motherborard S3000
Message-Id: <45C5EAA0.1040500@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c731b2$3d228280$fbe4fea9@bbhome>
In-Reply-To: <000001c731b2$3d228280$fbe4fea9@bbhome>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Sorry for the delay.

> the board name is Server Boards S3000AH
> The manual descibe regarding to hardware monitoring:
> The server board has implemented hardware monitoring function into the super 
> I/O SCH5027

Hmm I dont know this chip either. It seems it may live on ISA bus and maybe it
is compatible with SCH311xx.

Please can you try following and post the output back here?

isadump -k 0x55 0x2e 0x2f
isadump -k 0x87,0x87 0x2e 0x2f

(and full output of sensors-detect from lm-sensors)

Thanks,
Rudolf

