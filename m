From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 15 Oct 2012 14:12:49 +0000
Subject: Re: [lm-sensors] non-interactive sensors-detect
Message-Id: <20121015141249.GA4389@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <507BD5C2.8050506@cern.ch>
In-Reply-To: <507BD5C2.8050506@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 15, 2012 at 12:22:10PM +0300, Adrian Sevcenco wrote:
> Hi! Is there a way to run sensors-detect in a non-interactive way?
> I try to enable lm_sensors on a cluster and i find no way to do it..
> Is is possible to add switches like -y (yes all) or -d (default all)
> to sensors detect?
> 
Did you try "sudo sensors-detect < /dev/null" ?

It reports some script errors but seems to go woth the defaults.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
