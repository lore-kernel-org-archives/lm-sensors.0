From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Jul 2012 11:36:42 +0000
Subject: Re: [lm-sensors] k15 cpu and wrong k10temp readings
Message-Id: <20120718133642.0dddbb50@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <8d88955561f011f99165a0705ba32184@mariom.pl>
In-Reply-To: <8d88955561f011f99165a0705ba32184@mariom.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please keep the list in Cc.

On Wed, 18 Jul 2012 12:55:52 +0200, Mariusz Kozakowski wrote:
> Jean Delvare <khali@linux-fr.org> writes:
> > Please read:
> > http://www.lm-sensors.org/wiki/FAQ/Chapter3#coretempreturnsunrealisticvalues
> >
> > The entry was originally written for the Intel coretemp driver but the
> > AMD k8temp and k10temp drivers suffer from the same issue AFAIK.
> So, on 3.4 and 3.5-rc7 it should work properly? I had this problem on
> 3.2, 3.3, 3.4 and now i'm having it on 3.5-rc7. If i understand
> correctly - ACPI resource check was fixed in 3.3 kernel.

You read the wrong FAQ entry. The one I referred to is titled:
"coretemp returns unrealistic values".

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
