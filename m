From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 22 Nov 2011 10:14:40 +0000
Subject: Re: [lm-sensors] Sandy Bridge support?
Message-Id: <20111122111440.53a34022@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <0022152d6d71d9f528049a109a02@google.com>
In-Reply-To: <0022152d6d71d9f528049a109a02@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nick,

On Tue, 18 Jan 2011 16:47:44 +0000, DarkNovaNick@gmail.com wrote:
> On Jan 18, 2011 10:32am, Jean Delvare <khali@linux-fr.org> wrote:
> > OK, thanks. If you feel lucky, you may try to load the it87 driver with
> > parameter force_id, to force the driver to consider your chip as one it
> > supports. Given the name of your device, the first values to try would
> > be 0x8721 and 0x8720 (the two most recent chips) or 0x8718 (in case the
> > IT8728F is an evolution of the IT8718F - I remember the IT8716F and
> > IT8726F were compatible.) If you give this a try, please let us know
> > the results.
> 
> Thanks very much for your help, I was able to load the it87 driver with  
> 0x8720 and now running "sensors" gives data that at first glance makes  
> sense.

It turns our that the I8728F is rather compatible with the IT8721F.
Proper support was just added, you can use the standalone it87 driver
if you want:
  http://khali.linux-fr.org/devel/misc/it87/

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
