From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 17 May 2006 06:17:14 +0000
Subject: [lm-sensors] [Fwd: RE: W83627EHF]
Message-Id: <446ABFEA.4040408@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

> Hi Rudolf,
> We received reply from HW engineer, i dont know if this solve your 
> question.
> If not we can contact them later.
> 
> 
>  > Dear DZ,
>  >
>  > Please check page 74 of pdf file index CR[47], bit 0 should be 1.
>  >
>  > PIN 58 is selected by HW strapping when PIN 52 pull up to VCC. Otherwise
>  > is AUXFANIN1.
>  >
>  > YS

Good. Thanks, This means I must check CR24 bit and see if the flash is enabled.

Regards,
Rudolf

