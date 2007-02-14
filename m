From: riwright@vt.edu (Rick Wright)
Date: Wed, 14 Feb 2007 19:44:01 +0000
Subject: [lm-sensors] Abit AT8 (non-32X) / Winbond 83627EHF
Message-Id: <45D36681.80707@vt.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D0A4B2.6030002@vt.edu>
In-Reply-To: <45D0A4B2.6030002@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Rick Wright wrote:
> Hans de Goede wrote:
> Forgot to ask:  Do you have any clue as to why the sensors-detect script 
> would set me up to use the w83627ehf chip?  Is this just the sane 
> fallback since the latest uGuru isn't mainline supported yet?  If I 
> understand correctly, uGuru is a modified Winbond chip, right?
> 

I have no clue, and it isn't a sane fallback as the uguru is a piece of 
software running on a microcontroller, which just happens to be produced 
by winbond, but it is totally different from the w83627ehf chip.

I really should teach sensors-detect about the abituguru one of these 
days, but that would probably require identifying by dmi data as the 
uguru otherwise is almost impossible to detect with reasonable certainty.

Regards,

Hans





