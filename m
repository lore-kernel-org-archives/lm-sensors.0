From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 14 Jan 2007 18:02:00 +0000
Subject: [lm-sensors] [PATCH] W83793: ignore the temperature readings
Message-Id: <45AA7018.2000708@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A77F63.5080808@assembler.cz>
In-Reply-To: <45A77F63.5080808@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Rudolf, Gong,
> 
> Hm, the patch is incomplete. The following changes are missing:

Hi again, sorry I forgot to think in wider scale completely :/
I'm attaching updated patch.

w83793: ignore the temperature readings when its channel is disabled, ignore 
AMDSI readings.

Signed-off-by: Gong Jun <jgong at winbond.com>
Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-patch-w83793-temp-display.patch
Type: text/x-patch
Size: 4573 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070114/3df49b68/attachment.bin 
