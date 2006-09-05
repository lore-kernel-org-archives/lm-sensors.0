From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 05 Sep 2006 09:10:37 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060905111037.908e7850.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Given that these 3 last chips (W83627HF, W83627EHF and W83627DHG) are
> > Super-I/O chips and are detected again later using a  more reliable
> > method, I suggest we drop the legacy detection method for them. I've
> > already done so for the ITE family some weeks ago. Objection anyone?
> 
> No objections here.

Done. In fact I left W83627HF, as our w83781d driver still supports
that chip and uses the legacy ISA probing method. At some point, I
think we should drop W83627HF support from the w83781d driver entirely,
as this is redundant with the w83627hf driver, and then we can drop ISA
probing in sensors-detect too. I'd rather postpone that change to until
after the upcoming lm-sensors release though.

Thanks,
-- 
Jean Delvare

