From: rabin@mellanox.co.il (Eitan Rabin)
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: I2C CMP on Embedded Planet SBC
Message-Id: <506C3D7B14CDD411A52C00025558DED6023D0CDB@mtlex01.yok.mtl.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <506C3D7B14CDD411A52C00025558DED6023D0CD9@mtlex01.yok.mtl.com>
In-Reply-To: <506C3D7B14CDD411A52C00025558DED6023D0CD9@mtlex01.yok.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I have problems using the CPM I2C controller on my cllf cards. 

I installed the latest devel kernel (2.4.21-rc1) and enabled the relocation
I2C patch.

The problem happens whenever I give a start transmition command i2c_i2com |0x80. When ever this is written the machine just freezes.

I have a bit banging code already working as a fall back, but because I need
to generate a lot of I2C long transactions and I would like to use the CMP.

Any assistance will be more than welcomed.

Thanks in advance.

Eitan.

PS: I hope this message is plain text. I can't convince outlook to attach
its html garbage.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030423/ca2a0966/attachment.html
