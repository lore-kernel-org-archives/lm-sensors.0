From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: PII4X/Compaq ProLiant ML370 G2 server (fwd)
Message-Id: <20030129095620.55f71f1d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200301281638.h0SGcEm25577@morannon.frodo.local>
In-Reply-To: <200301281638.h0SGcEm25577@morannon.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>  If you found that the adapter hung after probing a certain address,
>  you can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> Segmentation fault

Strange. Never seen that before. Perl itself would be segfaulting. Could
you please tell me which distribution you are running,  and which
version of Perl is used?

Do you have any way to get a core dumped (ulimit -c unlimited could
help)?

May I send you a modified version of the script with some extra prints
to try and locate the problem?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
