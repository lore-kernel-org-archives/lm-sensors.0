From: Wim Van Sebroeck <wim@iguana.be>
Date: Wed, 13 Apr 2011 07:03:00 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/2] Use "request_muxed_region" in it87
Message-Id: <20110413070259.GE4070@infomag.iguana.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302641290-30212-1-git-send-email-natg@google.com> <1302641387-30264-1-git-send-email-natg@google.com>
In-Reply-To: <1302641387-30264-1-git-send-email-natg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org

Hi Nat,

> +	(void) request_muxed_region(REG, 2, NAME);

Why do we need to typecast this? Can't we just use 
+	request_muxed_region(REG, 2, NAME);

Kind regards,
Wim.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
