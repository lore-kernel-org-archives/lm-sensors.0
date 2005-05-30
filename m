From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 30 May 2005 18:13:24 +0000
Subject: [lm-sensors] SMSC LPC47M192 - "Device is disabled, will not use"
Message-Id: <429B3B8E.7040809@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <429A1930.6040409@gmail.com>
In-Reply-To: <429A1930.6040409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Please can you do:

modprobe i2c-i801
modprobe i2c-dev
i2cdetect 0
i2cdump 0 0x2d

Thanks

regards

Rudolf

