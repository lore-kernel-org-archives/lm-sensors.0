From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 23 Sep 2006 10:06:52 +0000
Subject: [lm-sensors] [PATCH] w83l785ts - fix unchecked return codes
Message-Id: <20060923120652.2171169c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45146318.3030408@assembler.cz>
In-Reply-To: <45146318.3030408@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> Following patch fixes the w83l785ts driver. It adds error checking to 
> device_create file and also cares to destroy the files upon exit. Compile tested.

Looks good, applied, thanks.

-- 
Jean Delvare

