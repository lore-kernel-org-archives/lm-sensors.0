From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Jun 2005 16:53:35 +0000
Subject: [lm-sensors] Ticket 2005
Message-Id: <o5CXxroX.1118932968.3094840.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506161659.57761.atis@mikrotik.com>
In-Reply-To: <200506161659.57761.atis@mikrotik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Atis,

On 2005-06-16, Atis Elsts wrote:
> Nevermind about that support ticket. "modprobe lm85 force_emc6d102=1,0x2e"
> did the trick. Perhaps the lm85 driver did not detect my chip correctly.

Can you please send the output of:

i2cdump 1 0x2e b

If possible, try to physically identify the chip for confirmation.

Thanks,
--
Jean Delvare
