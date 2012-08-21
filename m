From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 21 Aug 2012 15:28:26 +0000
Subject: Re: [lm-sensors] Chassis fan is reported incorrectly with M5A78L motherboard
Message-Id: <20120821152826.GC6827@growl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20531.32769.603792.771925@freddi.uddeborg>
In-Reply-To: <20531.32769.603792.771925@freddi.uddeborg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 21, 2012 at 08:01:14AM -0700, Guenter Roeck wrote:
> > It always reads the same sensor. The other ("new") monitoring interface
> > seems fine though. Unload the module and try reloading it with
> > "new_if=1", like this:
> > 
> > modprobe asus_atk0110 new_if=1
> > 
> > And see if everything looks good.
> > 
> If it does, should we add the board to atk_force_new_if[] ?

Yes, I'm preparing the patch.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
