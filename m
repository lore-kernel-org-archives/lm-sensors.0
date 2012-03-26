From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 26 Mar 2012 20:28:43 +0000
Subject: Re: [lm-sensors] Not detecting all fan RPMs
Message-Id: <20120326222843.407cfbcd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332789633.10230.9.camel@dfghom-gjhollo2.site>
In-Reply-To: <1332789633.10230.9.camel@dfghom-gjhollo2.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 Mar 2012 13:16:35 -0700, Guenter Roeck wrote:
> On Mon, 2012-03-26 at 15:44 -0400, Jean Delvare wrote:
> > The NCT6775 supports only 4 fans, so either there is some multiplexing
> > in place (which we don't support) or you have a second hardware
> > monitoring chip on your system.
>
> I had not thought about multiplexing - good point. That would explain
> why the chassis fans can only be configured for manual mode or full on.

From a monitoring perspective, this makes absolutely no sense of
course, as this means a delay in detecting fan failure. But the fact is
that we've already seen this in the past. Manufacturer apparently
preferred to save a few cents per board by using multiplexing and
getting an ugly and unreliable solution rather than adding a second
hardware monitoring chip for a clean and reliable one. Tsss...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
