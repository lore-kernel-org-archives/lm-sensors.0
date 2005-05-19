From: yvanoers@xs4all.nl (Yuri van Oers)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: [rivatv-devel] loading rivatv is slow
Message-Id: <20030806221353.K77182-100000@xs1.xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030718152351.1dcbd333.khali@linux-fr.org>
In-Reply-To: <20030718152351.1dcbd333.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

Both sensor chips and decoder chips are located on the I2C bus of nVidia
cards. So yes, we're driver the I2C bus and sending stuff to it.
If your card does not support I2C, you don't need rivatv at all.

Hope that answers your question,
Regards,
Yuri

On Fri, 18 Jul 2003, Jean Delvare wrote:

>
> Hi folks,
>
> (I have been lurking on your IRC channel for days now, but it seems it
> isn't very active. Hope I'll have more luck here.)
>
> I noticed that the rivatv module is slow loading when the monitor
> plugged on my videocard does not support DDC/I2C. Why that? Are you
> sending I2C commands at module init?
>
> Thanks.
>
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: VM Ware
> With VMware you can run multiple operating systems on a single machine.
> WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
> same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
> _______________________________________________
> rivatv-devel mailing list
> rivatv-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/rivatv-devel
>
