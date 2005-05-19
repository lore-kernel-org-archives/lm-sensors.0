From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: ---=== Lm_sensors Support DB Entry #1692 ===---
Message-Id: <20040612182043.2ec0cf29.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040609062212.GC448@skilta.cc.tut.fi>
In-Reply-To: <20040609062212.GC448@skilta.cc.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This is a slim barebone-PC: MSI Hermes 845GV-Lite
> (http://www.msi.com.tw/program/products/slim_pc/slm/pro_slm_detail.ph
> p?UIDA6)
> 
> The manual says that there is SMSC LPC47M133-NC, which is also
> identified by sensors-detect, but it doesn't say anything about the
> LM86.
> 
> I haven't got the time right now to open the chassis and check if
> there really is LM86 installed, but when I do, I will send you a
> message.

Can you please dump the chips content using "i2cdump 0 0x4c"? I'd like
to make absolutely sure it's an LM86 before adding support to the lm90
driver (although not much doubt is allowed anymore).

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
