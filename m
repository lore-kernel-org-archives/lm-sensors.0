From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 27 Mar 2012 15:47:19 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect : PCI bus is always required even if it might be missing on
Message-Id: <1332863239.21301.90.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <c838afb8-7576-42c2-abf6-ea56ca84daa3@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <c838afb8-7576-42c2-abf6-ea56ca84daa3@zmail15.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-03-27 at 11:19 -0400, Jaromir Capik wrote:
> Hello guys.
> 
> I was trying to autodetect sensors on my ARM based device (PandaBoard).
> This board doesn't have a PCI bus, but the sensors-detect script
> always expect one and then fails with the following message:
> 
> /sys/bus/pci/devices: No such file or directory at ./sensors-detect.bak line 2895.
> 
> The attached patch should avoid dying and returns empty PCI device list instead.
> 
Did you send it as attachment ? If so, the mailer might have removed it.

Please re-send, but not as attachment.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
