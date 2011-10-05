From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 05 Oct 2011 06:35:43 +0000
Subject: Re: [lm-sensors] EVGA 132-BL-E758 motherboard, chip F71882FG
Message-Id: <4E8BFABF.7060706@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201110041538.p94FcdZI008229@douglas.highley-recommended.com>
In-Reply-To: <201110041538.p94FcdZI008229@douglas.highley-recommended.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 10/04/2011 05:38 PM, David Highley wrote:
> This question may have been asked before, but I have not found the
> answer so far. It appears that a kernel change since version 2.36.1 is
> now blocking by default the monitoring/probing of this board and
> indicates that a driver should be used. I have not found a driver, but
> the lm-sensor information lists a driver, LPC, for the chip F71882FG. So
> I'm trying to understand why I still need to add
> apci_enforce_resources=lax to get monitoring to work.

See:
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
