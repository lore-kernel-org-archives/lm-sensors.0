From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 17 Jan 2007 21:27:59 +0000
Subject: [lm-sensors] [PATCH] W83793: fix the fan input detection
Message-Id: <20070117222759.b6f106ab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45AA7145.1000908@assembler.cz>
In-Reply-To: <45AA7145.1000908@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 16 Jan 2007 15:54:42 +0800, JGong at winbond.com wrote:
> Hi, Jean
> 
> W83793: fix the fan input detection, catches the cases when alternative
> pins are used to route the fan9-12 input.
> 
> The patch looks OK, I have tested it on my motherboard, please apply.
> 
> Signed-off-by: Rudolf Marek <r.marek at assembler.cz>
> Signed-off-by: Gong Jun <jgong at winbond.com>

Applied, thanks.

-- 
Jean Delvare

