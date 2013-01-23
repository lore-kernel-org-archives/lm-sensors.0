From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Jan 2013 13:23:50 +0000
Subject: Re: [lm-sensors] [PATCH] avoid unwanted sensors-detect termination when the /dev/port is missing
Message-Id: <20130123142350.51e5de12@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1978493810.11074933.1358435561516.JavaMail.root@redhat.com>
In-Reply-To: <1978493810.11074933.1358435561516.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 23 Jan 2013 07:17:34 -0500 (EST), Jaromir Capik wrote:
> > I admit that dying in this case is a little abrupt. That being said,
> > without /dev/port, you won't be able to detect Super-I/O chips, ISA
> > chips and I/O-based IPMI interfaces, which only leave you with
> > I2C/SMBus-based, PCI-based and MSR-based sensors. Are there really
> > systems out there without /dev/proc where any of these is present?
> 
> Yes, such systems exist. I had the pleasure to debug the issue 
> directly on 2 systems where the /dev/port was missing, but
> I2C bus was present. One of the systems even didn't have
> any PCI bus. And I believe that we can expect more hardware
> like that in the future. With ARM based boards even more oddities
> can appear. The detection script needs to be as flexible
> as possible to handle such situations.

OK, thanks for the information. I do agree about flexibility, as long
as is is needed and not "just because we can".

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
