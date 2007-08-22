From: Boleslaw Ciesielski <bolek-sensors@curl.com>
Date: Wed, 22 Aug 2007 02:38:36 +0000
Subject: Re: [lm-sensors] Backporting coretemp and w83793 to 2.6.18
Message-Id: <46CBA1AC.5070400@curl.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46CB9161.5090408@curl.com>
In-Reply-To: <46CB9161.5090408@curl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Boleslaw Ciesielski wrote:
> I have this new server based on the Asus DSBF-DE/SAS motherboard and a
> pair of Xeons 5355. I want to run CentOS 5.0 (RHEL 5 clone) on it.
> CentOS 5.0 is based on the 2.6.18 kernel and as such has drivers for
> everything *except* for the sensors. The motherboard uses 83793 chip.
> 
> So, I wanted to backport the w83793 and coretemp drivers to 2.6.18
> kernel. I took the source from 2.6.22.3 for these two and tried to
> compile them for 2.6.18.
> 
> The w83793 compiles and loads as is, without any changes.
> 
> coretemp required some changes related to msr so I just restored the
> code that was in there when coretemp was floating around as a patch
> before it made it to the kernel. See the attached patch for detail.
> 
> Anyway, with those changes both coretemp and w83793 compile and load. I
> also copied sensors.conf from 2.10.4 and ran "sensors -s". However,
> neither is providing any data. Output looks like this:

Just a quick update. I got reply off-list that I am missing the new 
versions of the user tools. I installed 2.10.4 rpm from Fedora 7 and I 
get the readings now.

Thank you

Bolek

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
