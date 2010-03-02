From: Paul Thomas <pthomas8589@gmail.com>
Date: Tue, 02 Mar 2010 21:12:53 +0000
Subject: Re: [lm-sensors] [PATCH] V2 Driver for Texas Instruments ads7871
Message-Id: <c785bba31003021312m3dff449fu83c9fa46848afd53@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1267563932-31930-1-git-send-email-pthomas8589@gmail.com>
In-Reply-To: <1267563932-31930-1-git-send-email-pthomas8589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK, here's the new patch. It has most of the comments incorporated.
The section I'm most unsure of is the error handling in ads7871_probe.
In ads7871_probe, I do check that one register is written correctly
this ensures that there is really a chip there, but I just set err to
-1, is that OK? What should the error be for a chip that's not
actually on the bus?

thanks,
Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
